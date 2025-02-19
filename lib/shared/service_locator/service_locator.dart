// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

// import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:shared_preferences/shared_preferences.dart';

// import '../../data/local/local_data_source.dart';
// import '../../data/local/local_data_source_implementation.dart';
import '../../data/remote/remote_data_source.dart';
import '../../data/remote/remote_data_source_implementation.dart';
import '../../repository/repository.dart';
import '../../repository/repository_implementation.dart';
import '../helpers/dio_helper/dio_helper.dart';
import '../helpers/internet_checker/internet_checker.dart';
import '../helpers/shared_prefs_helper/prefs_helper.dart';
import '../routing/navigation_service.dart';
// import '../../data/local/local_data_source.dart';
// import '../../data/local/local_data_source_implementation.dart';
// import '../../data/remote/remote_data_source.dart';
// import '../../data/remote/remote_data_source_implementation.dart';
// import '../../repository/repository.dart';
// import '../../repository/repository_implementation.dart';

// import '../helpers/internet_checker/internet_checker.dart';
// import '../helpers/shared_prefs_helper/prefs_helper.dart';
// import '../routing/navigation_service.dart';

final sl = GetIt.instance;
// void setupServiceLocator() {
//   sl.registerLazySingleton<NavigationService>(() => NavigationService());
  // Register other services here
// }
class ServiceLocator {
  static Future<void> init() async {
    // register helpers, datasource
    await _registerLazySingleton();

    // register cubits/blocs
    await _registerFactory();
  }
}

Future<void> _registerLazySingleton() async {
  // register shared preferences
  if (sl.isRegistered<SharedPreferences>()) {
    sl.unregister<SharedPreferences>();
  }

  final sharedPrefs = await PrefsHelper().init();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
  if (sl.isRegistered<PrefsHelper>()) {
    sl.unregister<PrefsHelper>();
  }

  sl.registerLazySingleton<PrefsHelper>(() => PrefsHelper());

  if (sl.isRegistered<Dio>()) {
    sl.unregister<Dio>();
    sl.unregister<DioHelper>();
  }
  final Dio dio = DioHelper().init();
  debugPrint(
      '------------------- register Dio: ${dio.options.baseUrl} --------------------');
  sl.registerLazySingleton<Dio>(() => dio);
  sl.registerLazySingleton<DioHelper>(() => DioHelper());

  // network info
  if (sl.isRegistered<NetworkInfo>()) {
    sl.unregister<NetworkInfo>();
  }
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));
  // remote datasource
  if (sl.isRegistered<RemoteDataSource>()) {
    sl.unregister<RemoteDataSource>();
  }

  sl.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImplementation(dio: sl(), dioHelper: sl()));

  sl.registerLazySingleton<NavigationService>(
      () => NavigationService());

  // local datasource
  // if (sl.isRegistered<LocalDataSource>()) {
  //   sl.unregister<LocalDataSource>();
  // }
  //
  // sl.registerLazySingleton<LocalDataSource>(
  //     () => LocalDataSourceImpl(prefsHelper: sl<SharedPreferences>()));

  // repositories
  if (sl.isRegistered<Repository>()) {
    sl.unregister<Repository>();
  }


  sl.registerLazySingleton<Repository>(
      () => RepositoryImplementation(remoteDataSource: sl(), networkInfo: sl()));

  // navigation service
  if (sl.isRegistered<NavigationService>()) {
    sl.unregister<NavigationService>();
  }
  sl.registerLazySingleton<NavigationService>(() => NavigationService());
  // sl.registerLazySingleton<NotificationCubit>(() => NotificationCubit(repository: sl()));
}

Future<void> _registerFactory() async {
/*
  if (sl.isRegistered<LoginCubit>()) {
    sl.unregister<LoginCubit>();
  }
*/
}

