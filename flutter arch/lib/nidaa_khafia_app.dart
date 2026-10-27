import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/app_controller/app_controller_bloc.dart';
import 'config/router/app_router.dart';
import 'config/theme/app_theme.dart';
import 'core/utils/constant/app_strings.dart';
import 'core/utils/functions/responsive.dart';
import 'core/utils/functions/service_locator.dart';
import 'core/utils/functions/translation.dart';

class NidaaKhafiaApp extends StatelessWidget {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  const NidaaKhafiaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl.get<AppControllerBloc>()),
      ],
      child: ScreenUtilWrapper(
        child: BlocBuilder<AppControllerBloc, AppControllerState>(
          builder: (context, state) {
            final currentLocale = locale(context);
            return MaterialApp.router(
              localizationsDelegates: localizationDelegates(context),
              supportedLocales: supportedLocales(context),
              locale: currentLocale,
              debugShowCheckedModeBanner: false,
              routerConfig: appRouter,
              theme: AppTheme.light(),
              darkTheme: AppTheme.dark(currentLocale),
              themeMode: ThemeMode.light,
              title: AppStrings.appName,
            );
          },
        ),
      ),
    );
  }
}
