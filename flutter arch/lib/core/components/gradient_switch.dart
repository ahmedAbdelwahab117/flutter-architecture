import 'package:flutter/material.dart';

import '../utils/constant/app_colors.dart';
import '../utils/functions/responsive.dart';

class GradientSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const GradientSwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final width = context.byDevice(
      mobilePortrait: 53.0,
      mobileLandscape: 54.0,
      tablet: 64.0,
    );
    final height = context.byDevice(
      mobilePortrait: 30.0,
      mobileLandscape: 32.0,
      tablet: 36.0,
    );
    final thumbSize = height - 4.0;

    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(height),
          gradient: value ? AppColors.primaryGradient : null,
          color: value ? null : const Color(0xFFE0E0E0),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 300),
          alignment: value ? Alignment.centerLeft : Alignment.centerRight,
          child: Container(
            margin: const EdgeInsets.all(2.0),
            width: thumbSize,
            height: thumbSize,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
