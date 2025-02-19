// import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../shared/resources/assets_manager.dart';
import '../../../shared/resources/colors_manager.dart';
import '../../../shared/resources/strings_manager.dart';
import '../../../shared/routing/routes_manager.dart';
import '../widgets/custom_onboarding.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
 static final PageController pageController = PageController();
  int currentPage = 0;

  List<Widget> boarding = [
    CustomOnBoarding(
      controller: pageController,
      image: AssetsManager.onboarding1,
      title: StringsManager.onboardingTitle1,
      description: StringsManager.onboardingDesc1,
    ),
    CustomOnBoarding(
      controller: pageController,
      image: AssetsManager.onboarding2,
      title: StringsManager.onboardingTitle2,
      description: StringsManager.onboardingDesc2,
    ),
    CustomOnBoarding(
      controller: pageController,
      image: AssetsManager.onboarding1,
      title: StringsManager.onboardingTitle3,
      description: StringsManager.onboardingDesc3,
    )

  ];

  void nextPage() {
    if (currentPage == boarding.length - 1) {
      // On last page, navigate to registration
      Navigator.of(context).pushReplacementNamed(RoutesManager.secondSplashScreen);
    } else {
      // Go to next page
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.whiteColor,
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        scrollDirection: Axis.horizontal,
        onPageChanged: (index) {
          setState(() {
            currentPage = index;
          });
        },
        children: boarding,
      ),

    );
  }
}
