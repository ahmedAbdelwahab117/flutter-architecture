import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../config/theme/app_spacing.dart';
// import '../../../../../config/theme/app_theme.dart';
import '../../../../../core/utils/constant/app_colors.dart';
import '../../../../../core/utils/constant/app_fonts.dart';
import '../../model/on_boarding_item.dart';
import 'on_boarding_dots.dart';
import 'on_boarding_image.dart';
import 'on_boarding_metrics.dart';


class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    super.key,
    required this.item,
    required this.index,
    required this.count,
  });

  final OnBoardingItem item;
  final int index;
  final int count;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        final double imageHeight = min(
          constraints.maxWidth * OnBoardingMetrics.imageHeightRatio,
          constraints.maxHeight * OnBoardingMetrics.maxImageFraction,
        );

        return SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              OnBoardingImage(asset: item.image, height: imageHeight),
              const SizedBox(height: AppSpacing.xxxl),
              OnBoardingDots(current: index, count: count),
              const SizedBox(height: AppSpacing.xxl),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: OnBoardingMetrics.gutter,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title.tr(),
                      style: theme.headlineMedium?.copyWith(
                        // fontFamily: AppTheme.cairoFontFamily,
                        fontSize: 21,
                        fontWeight: FontManger.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      item.body.tr(),
                      style: theme.bodyMedium?.copyWith(
                        // fontFamily: AppTheme.cairoFontFamily,
                        fontSize: 15,
                        fontWeight: FontManger.medium,
                        color: AppColors.onBoardingBody,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
