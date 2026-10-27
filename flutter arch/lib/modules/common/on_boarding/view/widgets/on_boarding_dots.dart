import 'package:flutter/material.dart';

import '../../../../../config/theme/app_radius.dart';
import '../../../../../config/theme/app_spacing.dart';
import '../../../../../core/utils/constant/app_colors.dart';
import 'on_boarding_metrics.dart';


class OnBoardingDots extends StatelessWidget {
  const OnBoardingDots({super.key, required this.current, required this.count});

  final int current;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        final bool active = index == current;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: AppSpacing.xs / 2),
          width: active
              ? OnBoardingMetrics.activeDotWidth
              : OnBoardingMetrics.dotSize,
          height: OnBoardingMetrics.dotSize,
          decoration: BoxDecoration(
            color: active ? AppColors.ratingStarDark : AppColors.placeholderGrey,
            borderRadius: BorderRadius.circular(AppRadius.pill),
          ),
        );
      }),
    );
  }
}
