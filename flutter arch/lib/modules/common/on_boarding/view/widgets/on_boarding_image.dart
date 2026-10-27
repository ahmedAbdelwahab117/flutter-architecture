import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../../../core/utils/constant/app_colors.dart';
import 'on_boarding_metrics.dart';

class OnBoardingImage extends StatelessWidget {
  const OnBoardingImage({super.key, required this.asset, required this.height});

  final String asset;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height + OnBoardingMetrics.rimWidth,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          _layer(
            top: OnBoardingMetrics.rimWidth * 2,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(
                sigmaX: OnBoardingMetrics.shadowBlur,
                sigmaY: OnBoardingMetrics.shadowBlur,
              ),
              child: _tinted(AppColors.blackColor.withValues(alpha: 0.12)),
            ),
          ),
          _layer(
            top: OnBoardingMetrics.rimWidth,
            child: _tinted(AppColors.primaryColor),
          ),
          _layer(top: 0, child: _image()),
        ],
      ),
    );
  }

  Widget _layer({required double top, required Widget child}) {
    return Positioned(
      top: top,
      left: 0,
      right: 0,
      height: height,
      child: child,
    );
  }

  Widget _tinted(Color color) {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      child: _image(),
    );
  }

  Widget _image() {
    return Image.asset(
      asset,
      fit: BoxFit.cover,
      alignment: Alignment.bottomCenter,
      gaplessPlayback: true,
    );
  }
}
