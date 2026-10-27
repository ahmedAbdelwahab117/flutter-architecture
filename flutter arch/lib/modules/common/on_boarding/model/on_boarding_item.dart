

import '../../../../core/utils/constant/app_images.dart';
import '../../../../core/utils/constant/app_strings.dart';

class OnBoardingItem {
  const OnBoardingItem({
    required this.image,
    required this.title,
    required this.body,
  });

  final String image;
  final String title;
  final String body;

  static final List<OnBoardingItem> items = [
    OnBoardingItem(
      image: AppImages.onBoard1,
      title: AppStrings.onboardingTitle1,
      body: AppStrings.onboardingSubtitle1,
    ),
      OnBoardingItem(
      image: AppImages.onBoard2,
      title: AppStrings.onboardingTitle2,
      body: AppStrings.onboardingSubtitle2,
    ),
      OnBoardingItem(
      image: AppImages.onBoard3,
      title: AppStrings.onboardingTitle3,
      body: AppStrings.onboardingSubtitle3,
    ),
  ];
}
