
import 'package:dio/dio.dart';

class ApiService {
  String baseUrl = "https://moueen.sass.cyparta.com/api/v1/";
  final Dio _dio;

  ApiService()
      : _dio = Dio(
    BaseOptions(
      baseUrl: "https://moueen.sass.cyparta.com/api/v1/",
      headers: {
        "accept": "*/*",
        "Accept-Language": "en", // Default language
      },
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      responseType: ResponseType.json,
    ),
  );

  /// Generic POST request (JSON body)
  Future<Map<String, dynamic>> post({
    required String endpoint,
    Map<String, dynamic>? data,
    String? token,
    String? acceptLanguage,
  }) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: data,
        options: Options(
          contentType: Headers.jsonContentType,
          headers: {
            if (token != null) "Authorization": "Bearer $token",
            if (acceptLanguage != null) "Accept-Language": acceptLanguage,
          },
        ),
      );
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    }
  }

  /// Multipart/form-data POST request (e.g., file uploads)
  Future<Map<String, dynamic>> postFormData({
    required String endpoint,
    required FormData data,
    String? token,
    String? acceptLanguage, // ✅ added
  }) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: data,
        options: Options(
          contentType: 'multipart/form-data',
          headers: {
            if (token != null) "Authorization": "Bearer $token",
            if (acceptLanguage != null) "Accept-Language": acceptLanguage,
          },
        ),
      );

      if (response.data is Map<String, dynamic>) {
        return response.data as Map<String, dynamic>;
      } else {
        throw Exception("Unexpected response format: ${response.data}");
      }
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    }
  }

  /// Multipart/form-data PATCH request (for edit profile)
  Future<Map<String, dynamic>> patchFormData({
    required String endpoint,
    required FormData data,
    String? token,
    String? acceptLanguage, // ✅ added
  }) async {
    try {
      final response = await _dio.patch(
        endpoint,
        data: data,
        options: Options(
          contentType: 'multipart/form-data',
          headers: {
            if (token != null) "Authorization": "Bearer $token",
            if (acceptLanguage != null) "Accept-Language": acceptLanguage,
          },
        ),
      );

      if (response.data is Map<String, dynamic>) {
        return response.data as Map<String, dynamic>;
      } else {
        throw Exception("Unexpected response format: ${response.data}");
      }
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    }
  }

  /// GET request
  Future<dynamic> get({
    String? endPoint,
    Options? option,
    String? token,
    String? acceptLanguage,
  }) async {
    final response = await _dio.get(
      "$baseUrl$endPoint",
      options: option ??
          Options(
            headers: {
              if (token != null) "Authorization": "Bearer $token",
              if (acceptLanguage != null) "Accept-Language": acceptLanguage,
            },
          ),
    );
    return response.data;
  }

  /// DELETE request with optional token
  Future<Map<String, dynamic>?> delete({
    required String endpoint,
    required String token,
    String? acceptLanguage, // ✅ added
  }) async {
    try {
      final response = await _dio.delete(
        endpoint,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            if (acceptLanguage != null) "Accept-Language": acceptLanguage,
          },
        ),
      );

      // DELETE often returns 204 No Content → data will be null
      if (response.data == null) {
        return {}; // return empty map for consistency
      }

      if (response.data is! Map<String, dynamic>) {
        throw Exception("Unexpected response format: ${response.data}");
      }

      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    }
  }

  /// Centralized error logger
  void _handleDioError(DioException e) {
    print("❌ Dio error: ${e.message}");
    if (e.response != null) {
      print("📩 Response data: ${e.response?.data}");
      print("📩 Response headers: ${e.response?.headers}");
      print("📩 Status code: ${e.response?.statusCode}");
    }
  }
}
