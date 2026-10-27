import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nidaa_khafia/nidaa_khafia_app.dart';

// import '../../core/utils/constant/app_enums.dart';
// import '../../core/utils/functions/service_locator.dart';

import '../../modules/common/splash/view/splash_screen.dart';
import 'app_router_keys.dart';

final GoRouter appRouter = GoRouter(
  navigatorKey: NidaaKhafiaApp.navigatorKey,
  initialLocation: AppRouterKeys.splash,
  debugLogDiagnostics: true,

  routes: <RouteBase>[
    getRouteInstance('/', (state) => const SplashScreen()),
    // getRouteInstance(
    //   AppRouterKeys.onBoardingScreen,
    //       (state) => BlocProvider(
    //     create: (context) => OnboardingBloc(),
    //     child: const OnboardingScreen(),
    //   ),
    // ),

  ],
);

GoRoute getRouteInstance(
    String path,
    Widget Function(GoRouterState state) screen,
    ) => GoRoute(
  path: path.contains('/') ? path : '/$path',
  name: path,
  builder: (BuildContext context, GoRouterState state) {
    return screen(state);
  },
);
