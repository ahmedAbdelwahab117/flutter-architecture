import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../models/api_model.dart';

abstract class ApisCalls {
  Future<Either<String, ApiModel>> globalApiGet(
    String path, {
    Map<String, dynamic>? queryParameters,
  });
  Future<Either<String, ApiModel>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  });
  Future<Either<String, ApiModel>> getPrivate(
    String path, {
    Map<String, dynamic>? queryParameters,
  });
  Future<Either<String, ApiModel>> post(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });

  /// Like [post], but keeps the server's error body instead of flattening it
  /// to a message, so callers can branch on a business `code` (for example the
  /// marketplace's `cart_vendor_conflict`). Left = the error payload.
  Future<Either<ApiModel, ApiModel>> postDetailed(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });

  Future<Either<String, ApiModel>> postFormData(
    String path, {
    FormData body,
    Map<String, dynamic>? queryParameters,
  });
  Future<Either<String, ApiModel>> auth(
    String path, {
    Map<String, dynamic> body,
    Map<String, dynamic>? queryParameters,
  });
  Future<Either<String, ApiModel>> put(
    String path, {
    Map<String, dynamic> body,
    Map<String, dynamic>? queryParameters,
  });
  Future<Either<String, ApiModel>> delete(
    String path, {
    Map<String, dynamic>? queryParameters,
  });
  Future<Either<String, ApiModel>> patch(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  });
  Future<Either<String, ApiModel>> patchFormData(
    String path, {
    FormData body,
    Map<String, dynamic>? queryParameters,
  });
}
