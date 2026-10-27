import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../../config/app_controller/app_controller_bloc.dart';
import '../../connection/implementation/dio_consumer.dart';
import '../../connection/implementation/network_info_impl.dart';
import '../../connection/interfaces/api_consumer.dart';
import '../../connection/interfaces/network_info.dart';
import 'callback_token.dart';
import 'shared_preferance_utils.dart';

final sl = GetIt.instance;

Future<void> intiService() async {
  // Services
  await PreferenceUtils.init();
  sl.registerLazySingleton<PreferenceUtils>(() => PreferenceUtils());
  sl.registerLazySingleton<HandleMultiCallLocal>(() => HandleMultiCallLocal());

  // Network
  sl.registerLazySingleton<Connectivity>(() => Connectivity());
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl<Connectivity>()),
  );
  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(client: Dio()));

  // Global Blocs
  sl.registerLazySingleton<AppControllerBloc>(() => AppControllerBloc());
  // Singleton: the header badge and the cart screen must see the same cart.

  // Feature Blocs (Factories)

}
