import 'package:flutter/cupertino.dart';
import 'package:trade_master/shared/routing/routes_manager.dart';

import '../../views/forget_password/screens/forget_password_screen.dart';
import '../../views/login/screens/login_screen.dart';
import '../../views/onboarding/screens/onboarding_screen.dart';
import '../../views/otp_screen/screens/otp_screen.dart';
import '../../views/register/screens/register_screen.dart';
import '../../views/reset_password/screens/reset_password_screen.dart';
import '../../views/splash/screens/second_splash_screen.dart';
import '../../views/splash/screens/splash_screen.dart';


class AppRouter {
  // method to generate screens routes
  // static Route? onGenerateRoute(RouteSettings routeSettings) {}
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RoutesManager.splashScreen:
        return CupertinoPageRoute(
            settings: routeSettings, builder: (_) =>  SplashScreen());
 case RoutesManager.secondSplashScreen:
        return CupertinoPageRoute(
            settings: routeSettings, builder: (_) =>  SecondSplashScreen());
        case RoutesManager.onboarding:
        return CupertinoPageRoute(
            settings: routeSettings, builder: (_) =>  OnboardingScreen());

 case RoutesManager.loginScreen:
        return CupertinoPageRoute(
            settings: routeSettings, builder: (_) =>  LoginScreen());

 case RoutesManager.registerScreen:
        return CupertinoPageRoute(
            settings: routeSettings, builder: (_) =>  RegisterScreen());
 case RoutesManager.forgetPasswordScreen:
        return CupertinoPageRoute(
            settings: routeSettings, builder: (_) =>  ForgetPasswordScreen());

case RoutesManager.otpScreen:
        return CupertinoPageRoute(
            settings: routeSettings, builder: (_) =>  OtpScreen());

case RoutesManager.resetPasswordScreen:
        return CupertinoPageRoute(
            settings: routeSettings, builder: (_) =>  ResetPasswordScreen());




      default:
        return null;
    }
  }
}
