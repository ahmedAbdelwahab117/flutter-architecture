

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:trade_master/shared/constants.dart';
import 'package:trade_master/shared/routing/app_router.dart';
import 'package:trade_master/shared/routing/navigation_service.dart';
import 'package:trade_master/shared/routing/routes_manager.dart';
import 'package:trade_master/shared/service_locator/service_locator.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Bloc.observer = MyBlocObserver();

  await ServiceLocator.init();
  await EasyLocalization.ensureInitialized();

  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  // await NotificationService().requestFCMPermissions();
  // await NotificationService().initNotification();
  WidgetsFlutterBinding.ensureInitialized();
  // setupServiceLocator();
  runApp(
    EasyLocalization(
        path: 'assets/translation',
        supportedLocales: const [Locale(Constants.ar), Locale(Constants.en)],
        fallbackLocale: const Locale(Constants.ar),
        startLocale: const Locale(Constants.en),
        child: const MyApp()),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        builder: FToastBuilder(),
        locale: context.locale,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        onGenerateRoute: AppRouter.onGenerateRoute,
        // theme: MyTheme.lightTheme,

        debugShowCheckedModeBanner: false,
        navigatorKey: sl<NavigationService>().navigatorKey,
        initialRoute: RoutesManager.splashScreen,

      ),
    );
  }
}