import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trade_master/shared/resources/assets_manager.dart';
import 'package:trade_master/shared/routing/routes_manager.dart';

void main() {
  runApp(const MaterialApp(home: SplashScreen()));
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isAnimated = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _isAnimated = true;
      });
    });
    _navigateToOnBoardingScreen();
  }

  void _navigateToOnBoardingScreen() {
    Future.delayed(const Duration(seconds: 3)).then((value)
    {
      Navigator.of(context).pushNamed(RoutesManager.onboarding);

    }
    // token.isNotEmpty? sl<NavigationService>()
    //     .navigatePushNamedAndRemoveUntil(RoutesManager.homeScreen): !onBoarding
    //     ? sl<NavigationService>()
    //     .navigatePushNamedAndRemoveUntil(RoutesManager.onBoarding)
    //     : sl<NavigationService>()
    //     .navigatePushNamedAndRemoveUntil(RoutesManager.loginScreen)

    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          AnimatedPositioned(
            duration: Duration(seconds: 1),
            curve: Curves.easeInOut,
            top: _isAnimated ? 380.h : -100,
            left: 130.w,
            child: SvgPicture.asset(
              AssetsManager.splashT,
              height: 53.h,
              width: 34.w,
            ),
          ),
          AnimatedPositioned(
            duration: Duration(seconds: 1),
            curve: Curves.easeInOut,
            bottom: _isAnimated ? 380.h : -100,
            left: 126.w,
            child: SvgPicture.asset(
              AssetsManager.splashM,
              height: 43.h,
              width: 44.w,
            ),
          ),
          AnimatedPositioned(
            duration: Duration(seconds: 1),
            curve: Curves.easeInOut,
            right: _isAnimated ? 126.w : -100,
            // يتحرك لليمين
            top: 390.h,
            child: AnimatedOpacity(
              duration: Duration(seconds: 1),
              opacity: _isAnimated ? 1 : 0,
              child: SvgPicture.asset(
                AssetsManager.splashTrade,
                width: 77.w,
                height: 20.h,
              ),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(seconds: 1),
            curve: Curves.easeInOut,
            right: _isAnimated ? 132 : -100,
            top: 412.h,
            child: AnimatedOpacity(
              duration: Duration(seconds: 1),
              opacity: _isAnimated ? 1 : 0,
              child: SvgPicture.asset(
                AssetsManager.splashMaster,
                width: 77.w,
                height: 20.h,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
