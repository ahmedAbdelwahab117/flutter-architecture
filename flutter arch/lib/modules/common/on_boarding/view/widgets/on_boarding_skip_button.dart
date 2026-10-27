import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';


import '../../../../../config/theme/app_spacing.dart';
import '../../../../../core/utils/constant/app_colors.dart';
import '../../../../../core/utils/constant/app_strings.dart';

class OnBoardingSkipButton extends StatelessWidget {
  const OnBoardingSkipButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
        child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primaryColor,
            textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: 14,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.primaryColor,
            ),
          ),
          child: Text(AppStrings.skip.tr()),
        ),
      ),
    );
  }
}
