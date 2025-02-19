import 'package:trade_master/repository/repository.dart';

import '../data/remote/remote_data_source.dart';
import '../shared/helpers/internet_checker/internet_checker.dart';

class RepositoryImplementation extends Repository {
  final RemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  RepositoryImplementation({required this.remoteDataSource , required this.networkInfo});
}