import 'package:dio/dio.dart';
import 'package:trade_master/data/remote/remote_data_source.dart';

import '../../shared/helpers/dio_helper/dio_helper.dart';

class RemoteDataSourceImplementation extends RemoteDataSource {
  final Dio dio;
  final DioHelper dioHelper;

  RemoteDataSourceImplementation({required this.dio, required this.dioHelper});

}