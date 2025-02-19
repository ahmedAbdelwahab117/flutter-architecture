import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../constants.dart';
import '../../service_locator/service_locator.dart';
import '../shared_prefs_helper/prefs_helper.dart';

class DioHelper {
  Dio init() {
    final dio = Dio(
      BaseOptions(
        baseUrl: Constants.baseUrl,
        receiveDataWhenStatusError: true,
        followRedirects: false,
        receiveTimeout: const Duration(seconds: 30),
        validateStatus: (state) {
          if(state == 401){
            return false;
          }else {
           return state! < 500;
          }
        },
      ),
    );

    // Logger for debugging
    dio.interceptors.add(PrettyDioLogger(
      request: true,
      responseBody: true,
      requestBody: true,
      requestHeader: true,
      responseHeader: true,
    ));

    // Add Interceptor to handle token expiration
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = sl<PrefsHelper>().getToken();
          if (token.isNotEmpty) {
            options.headers[Constants.authorization] = 'Bearer $token';
          }
          handler.next(options);
        },
        onError: (DioError error, handler) async {
          print('Error: ${error.response?.statusCode} InterceptorsWrapper');
          print('Error: ${error.response?.statusCode}');
          if (error.response?.statusCode == 401) {
            // If token is expired, attempt to refresh it
            final isTokenRefreshed = await _refreshToken();
            if (isTokenRefreshed) {
              // Retry the failed request
              final token = sl<PrefsHelper>().getToken();
              error.requestOptions.headers[Constants.authorization] = 'Bearer $token';
              final retryResponse = await dio.request(
                error.requestOptions.path,
                options: Options(
                  method: error.requestOptions.method,
                  headers: error.requestOptions.headers,
                ),
                data: error.requestOptions.data,
                queryParameters: error.requestOptions.queryParameters,
              );
              return handler.resolve(retryResponse);
            } else {
              // Logout if refresh token fails
              await logout();
            }
          }
          handler.next(error); // Pass the error if not 401
        },
      ),
    );

    return dio;
  }

  void addHeaders() {
    final token = sl<PrefsHelper>().getToken();
    if (token.isEmpty) return;

    sl<Dio>().options.headers = {
      Constants.authorization: 'Bearer $token',
    };
  }

  void removeHeader() {
    sl<Dio>().options.headers = {};
  }

  Future<void> logout() async {
    await sl<PrefsHelper>().removeToken();
    removeHeader();
  }

  Future<bool> _refreshToken() async {
    try {
      final refreshToken = sl<PrefsHelper>().getRefreshToken();
      if (refreshToken.isEmpty) {
        return false;
      }

      final response = await Dio().post(
        '${Constants.baseUrl}/api/token/refresh/',
        data: {'refresh': refreshToken},
      );

      if (response.statusCode == 200) {
        final newToken = response.data['access'];
        sl<PrefsHelper>().saveData(key: Constants.token, value: newToken);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error refreshing token: $e');
      return false;
    }
  }
}
