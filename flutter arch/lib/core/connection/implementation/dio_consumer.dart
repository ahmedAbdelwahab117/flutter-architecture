import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_formatter/dio_http_formatter.dart';
import 'package:flutter/foundation.dart';

import '../../models/api_model.dart';
import '../../utils/constant/app_enums.dart';
import '../../utils/functions/callback_token.dart';
// import '../../utils/functions/crashlytics_collector.dart';
import '../../utils/functions/handle_phone_not_verified.dart';
import '../../utils/functions/log_out.dart';
import '../../utils/functions/print_state.dart';
import '../../utils/functions/service_locator.dart';
// import '../../services/remote_config_helper.dart';
import '../concept/end_points.dart';
import '../concept/exceptions.dart';
import '../concept/status_code.dart';
import '../interfaces/api_consumer.dart';

class DioConsumer implements ApiConsumer {
  final Dio client;

  DioConsumer({required this.client}) {
    client.interceptors.addAll([
      _connectivityInterceptor(),
      _authInterceptor(),
      if (kDebugMode) HttpFormatter(),
    ]);

    client.options
      // ..baseUrl = RemoteConfigHelper.getBaseUrl()
      ..connectTimeout = const Duration(milliseconds: 30000)
      ..receiveTimeout = const Duration(milliseconds: 30000)
      ..responseType = ResponseType.plain
      ..followRedirects = false
      ..validateStatus = (status) {
        return status != null && status < 500;
      };
  }

  @override
  Future<Either<String, ApiModel>> globalApiGet(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await client.get(path, queryParameters: queryParameters);
      final isError =
          response.statusCode == 400 ||
          response.statusCode == 403 ||
          response.statusCode == 404;

      if (isError) {
        final json = handleResponseAsJson(response);
        String message = 'Unknown Error';
        if (json is Map) {
          message =
              json['message'] ??
              json['error'] ??
              json['detail'] ??
              'Unknown Error';
        } else if (json is List) {
          message = json.join('\n');
        }
        return left(message);
      }

      return right(
        ApiModel(
          response: handleResponseAsJson(response),
          statusCode: response.statusCode!,
        ),
      );
    } on DioException catch (e) {
      return left(handleDioError(e).toString());
    }
  }

  @override
  Future<Either<String, ApiModel>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await client.get(path, queryParameters: queryParameters);
      return handleResponseStatus(response);
    } on DioException catch (e) {
      return left(handleDioError(e).toString());
    }
  }

  @override
  Future<Either<String, ApiModel>> getPrivate(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await client.get(
        path,
        queryParameters: queryParameters,
        options: Options(),
      );
      return handleResponseStatus(response);
    } on DioException catch (e) {
      return left(handleDioError(e).toString());
    }
  }

  @override
  Future<Either<String, ApiModel>> post(
    String path, {
    dynamic body,
    bool formDataIsEnabled = false,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await client.post(
        path,
        queryParameters: queryParameters,
        data: body,
        options: Options(headers: headers),
      );
      return handleResponseStatus(response);
    } on DioException catch (e) {
      return left(handleDioError(e).toString());
    }
  }

  @override
  Future<Either<String, ApiModel>> put(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await client.put(
        path,
        queryParameters: queryParameters,
        data: body,
      );
      return handleResponseStatus(response);
    } on DioException catch (e) {
      return left(handleDioError(e).toString());
    }
  }

  @override
  Future<Either<ApiModel, ApiModel>> postDetailed(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await client.post(
        path,
        queryParameters: queryParameters,
        data: body,
        options: Options(headers: headers),
      );
      final status = response.statusCode ?? 0;
      final model = ApiModel(
        response: handleResponseAsJson(response),
        statusCode: status,
      );
      return status >= 200 && status < 300 ? right(model) : left(model);
    } on DioException catch (e) {
      return left(
        ApiModel(
          response: {'detail': handleDioError(e).toString()},
          statusCode: 0,
        ),
      );
    }
  }

  @override
  Future<Either<String, ApiModel>> patch(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await client.patch(
        path,
        queryParameters: queryParameters,
        data: body,
      );
      return handleResponseStatus(response);
    } on DioException catch (e) {
      return left(handleDioError(e).toString());
    }
  }

  @override
  Future<Either<String, ApiModel>> patchFormData(
    String path, {
    FormData? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await client.patch(
        path,
        queryParameters: queryParameters,
        data: body,
        options: Options(headers: {'Accept': 'application/json'}),
      );

      return handleResponseStatus(response);
    } on DioException catch (e) {
      return left(handleDioError(e).toString());
    }
  }

  @override
  Future<Either<String, ApiModel>> postFormData(
    String path, {
    FormData? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await client.post(
        path,
        queryParameters: queryParameters,
        data: body,
        options: Options(headers: {'Accept': 'application/json'}),
      );

      return handleResponseStatus(response);
    } on DioException catch (e) {
      return left(handleDioError(e).toString());
    }
  }

  @override
  Future<Either<String, ApiModel>> delete(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await client.delete(
        path,
        queryParameters: queryParameters,
      );
      return handleResponseStatus(response);
    } on DioException catch (e) {
      return left(handleDioError(e).toString());
    }
  }

  @override
  Future<Either<String, ApiModel>> auth(
    String path, {
    Map<String, dynamic>? body,
    bool formDataIsEnabled = false,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      printState(
        'API Request: POST $path\nBody: $body\nQuery Parameters: $queryParameters',
      );
      final response = await client.post(
        path,
        queryParameters: queryParameters,
        data: formDataIsEnabled ? FormData.fromMap(body!) : body,
        options: Options(extra: {'requiresToken': false}),
      );
      printState(response.data);
      return handleResponseStatus(response);
    } on DioException catch (e) {
      return left(handleDioError(e).toString());
    }
  }

  @override
  dynamic handleResponseAsJson(Response response) {
    if (response.data == null || response.data.toString().trim().isEmpty) {
      return {};
    }
    return jsonDecode(response.data.toString());
  }

  @override
  Either<String, ApiModel> handleResponseStatus(Response response) {
    final status = response.statusCode ?? 0;
    final json = handleResponseAsJson(response);

    if (status >= 200 && status < 300) {
      return right(ApiModel(response: json, statusCode: status));
    }

    String? message;
    if (json is Map) {
      message = json['message'] ?? json['error'] ?? json['detail'];

      if (message == null && json.isNotEmpty) {
        final List<String> errors = [];
        json.forEach((key, value) {
          if (value is List) {
            errors.add(value.join(', '));
          } else if (value is String) {
            errors.add(value);
          }
        });
        if (errors.isNotEmpty) {
          message = errors.join('\n');
        }
      }
    } else if (json is List) {
      message = json.join('\n');
    }

    return left(message ?? response.statusMessage ?? 'Unknown Error');
  }

  @override
  Exception handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return FetchDataException();

      case DioExceptionType.cancel:
        return FetchDataException();

      case DioExceptionType.badCertificate:
      case DioExceptionType.connectionError:
        return NoInternetConnectionException();

      case DioExceptionType.unknown:
        if (error.error is SocketException) {
          return NoInternetConnectionException();
        }
        return FetchDataException(error.message);

      case DioExceptionType.badResponse:
        final code = error.response?.statusCode ?? 0;
        printState(error.response?.data);
        switch (code) {
          case StatusCode.badRequest:
            return BadRequestException();
          case StatusCode.unauthorized:
          case StatusCode.forbidden:
            return UnauthorizedException();
          case StatusCode.notFound:
            return NotFoundException();
          case StatusCode.conflict:
            return ConflictException();
          case StatusCode.internalServerError:
            return InternalServerException();
          default:
            return FetchDataException('Unexpected server error: $code');
        }
      case DioExceptionType.transformTimeout:
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }

  /// Returns the body of a 403 `phone_not_verified` answer, or null when
  /// the response is anything else. The body is not valid JSON for every
  /// error the server can produce, hence the guard.
  Map<String, dynamic>? _phoneNotVerifiedPayload(Response? response) {
    if (response == null || response.statusCode != StatusCode.forbidden) {
      return null;
    }
    try {
      final json = handleResponseAsJson(response);
      if (json is Map && json['code'] == phoneNotVerifiedCode) {
        return Map<String, dynamic>.from(json);
      }
    } catch (_) {
      // Not a JSON body - nothing to redirect on.
    }
    return null;
  }

  // bool _shouldLogApiError(DioException error) {
  //   switch (error.type) {
  //     case DioExceptionType.connectionError:
  //     case DioExceptionType.connectionTimeout:
  //     case DioExceptionType.receiveTimeout:
  //     case DioExceptionType.sendTimeout:
  //     case DioExceptionType.cancel:
  //       return false;
  //     default:
  //       return true;
  //   }
  // }

  InterceptorsWrapper _authInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) async {
        options.headers['Accept-Language'] = 'ar';
        if (options.extra['requiresToken'] != false) {
          final token = await sl<HandleMultiCallLocal>().getLocalData(
            keyType: LocalEnumKey.accessToken,
          );
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
        }

        handler.next(options);
      },

      onResponse: (response, handler) async {
        final bool isRefreshRequest =
            response.requestOptions.path == EndPoints.refreshTokenApi;

        // Check if token is expired based on user's provided response structure
        final bool isTokenExpired =
            response.statusCode == 401 &&
            !isRefreshRequest &&
            handleResponseAsJson(response)['code'] == 'token_not_valid';

        if (isTokenExpired) {
          try {
            final retryResponse = await _handle401AndRetry(
              response.requestOptions,
            );
            if (retryResponse != null) return handler.resolve(retryResponse);
          } catch (_) {
            logOut();
          }
        }

        final phoneNotVerified = _phoneNotVerifiedPayload(response);
        if (phoneNotVerified != null) {
          handlePhoneNotVerified(phoneNotVerified);
        }

        return handler.next(response);
      },

      onError: (DioException e, ErrorInterceptorHandler handler) async {
        // Prevent infinite loop if refreshTokenApi fails with 401
        final bool isRefreshRequest =
            e.requestOptions.path == EndPoints.refreshTokenApi;

        // Check if token is expired based on user's provided response structure
        final bool isTokenExpired =
            e.response?.statusCode == 401 &&
            !isRefreshRequest &&
            (e.response == null ||
                handleResponseAsJson(e.response!)['code'] == 'token_not_valid');

        if (isTokenExpired && EndPoints.refreshTokenApi.isNotEmpty) {
          try {
            final response = await _handle401AndRetry(e.requestOptions);
            if (response != null) return handler.resolve(response);
          } catch (_) {
            logOut();
            return handler.next(e);
          }
        }

        // The following retry logic might cause ANR/Signal 3 if multiple requests fail at once
        // Commenting it out for now to ensure stability
        /*
        if (e.type == DioExceptionType.connectionError ||
            e.error is SocketException ||
            e.type == DioExceptionType.connectionTimeout ||
            e.type == DioExceptionType.receiveTimeout) {
          showToast('connection_error'.tr(), state: ToastStates.error);

          const int maxRetries = 3;
          const Duration retryDelay = Duration(seconds: 5);

          for (int attempt = 1; attempt <= maxRetries; attempt++) {
            await Future.delayed(retryDelay);

            if (await sl<NetworkInfo>().isConnected) {
              try {
                final retryResponse = await client.fetch(e.requestOptions);
                return handler.resolve(retryResponse);
              } catch (err) {
                if (attempt == maxRetries &&
                    (err is DioException && err.response?.statusCode == 401)) {
                  logOut();
                }
              }
            }

            if (attempt == maxRetries) {
              return handler.reject(e);
            }
          }
        }
        */

        final phoneNotVerified = _phoneNotVerifiedPayload(e.response);
        if (phoneNotVerified != null) {
          handlePhoneNotVerified(phoneNotVerified);
        }

        // if (_shouldLogApiError(e)) {
        //   await CrashlyticsCollector().logApiError(
        //     url: e.requestOptions.uri.toString(),
        //     method: e.requestOptions.method,
        //     statusCode: e.response?.statusCode,
        //     requestBody: e.requestOptions.data?.toString(),
        //     responseBody: e.response?.data?.toString(),
        //     error: e,
        //   );
        // }

        return handler.reject(e);
      },
    );
  }

  InterceptorsWrapper _connectivityInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) async {
        final results = await sl<Connectivity>().checkConnectivity();
        if (results.contains(ConnectivityResult.none)) {
          return handler.reject(
            DioException(
              requestOptions: options,
              type: DioExceptionType.connectionError,
              message: 'No internet connection',
            ),
          );
        }
        handler.next(options);
      },
    );
  }

  Completer<void>? _refreshTokenCompleter;

  Future<Response?> _handle401AndRetry(RequestOptions requestOptions) async {
    if (_refreshTokenCompleter != null) {
      await _refreshTokenCompleter!.future;
    } else {
      _refreshTokenCompleter = Completer();
      try {
        await _refreshToken();
        _refreshTokenCompleter!.complete();
        _refreshTokenCompleter = null;
      } catch (e) {
        _refreshTokenCompleter!.completeError(e);
        _refreshTokenCompleter = null;
        rethrow;
      }
    }

    final newHeaders = Map<String, dynamic>.from(requestOptions.headers);
    final newAccessToken = await sl<HandleMultiCallLocal>().getLocalData(
      keyType: LocalEnumKey.accessToken,
    );
    newHeaders['Authorization'] = 'Bearer $newAccessToken';
    newHeaders['isRetry'] = true;

    return client.fetch(requestOptions.copyWith(headers: newHeaders));
  }

  Future<void> _refreshToken() async {
    final refreshToken = await sl<HandleMultiCallLocal>().getLocalData(
      keyType: LocalEnumKey.refreshToken,
    );
    if (refreshToken == null || refreshToken.isEmpty) {
      throw Exception('Refresh token missing');
    }
    final response = await client.post(
      EndPoints.refreshTokenApi,
      data: {'refresh': refreshToken},
      options: Options(extra: {'requiresToken': false}),
    );

    if (response.statusCode == 200) {
      final data = handleResponseAsJson(response);
      final newAccess = data['access'];
      final newRefresh = data['refresh'];

      if (newAccess != null) {
        await sl<HandleMultiCallLocal>().saveLocalData(
          keyType: LocalEnumKey.accessToken,
          data: newAccess,
        );
      }
      if (newRefresh != null) {
        await sl<HandleMultiCallLocal>().saveLocalData(
          keyType: LocalEnumKey.refreshToken,
          data: newRefresh,
        );
      }
    } else {
      throw Exception('Failed to refresh token');
    }
  }
}
