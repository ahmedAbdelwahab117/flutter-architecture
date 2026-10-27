import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../models/api_model.dart';

abstract class HandlerResponse {
  Either<String, ApiModel> handleResponseStatus(Response response);
  Exception handleDioError(DioException error);
  dynamic handleResponseAsJson(Response<dynamic> response);
}
