import 'package:flutter/material.dart';

import '../utils/constant/app_colors.dart';
import '../utils/functions/responsive.dart';

/// Primary CTA in the app's two-tone green — same gradient the navbar and the
/// home card buttons use.
class GradientButton extends StatelessWidget {
  const GradientButton({
    super.key,
    required this.onPressed,
    this.label,
    this.child,
    this.height,
    this.borderRadius = 14,
    this.enabled = true,
  }) : assert(label != null || child != null, 'label or child is required');

  final VoidCallback onPressed;
  final String? label;
  final Widget? child;
  final double? height;
  final double borderRadius;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1 : 0.5,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: enabled ? onPressed : null,
          borderRadius: BorderRadius.circular(borderRadius.radius),
          child: Ink(
            height: height ?? 50.height,
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(borderRadius.radius),
            ),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.width),
              alignment: Alignment.center,
              child:
                  child ??
                  Text(
                    label!,
                    style: TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: context.responsiveFontScale(14),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
