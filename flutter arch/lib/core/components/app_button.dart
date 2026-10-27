import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_liquid_glass_plus/flutter_liquid_glass.dart';
import '../utils/functions/responsive.dart';

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final double? width;
  final double? height;
  final double borderRadius;
  final TextStyle? labelStyle;
  final bool isLoading;

  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.width,
    this.height,
    this.borderRadius = 30,
    this.labelStyle,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final resolvedWidth = width ?? MediaQuery.sizeOf(context).width - 48.width;
    return LGButton.custom(
      onTap: isLoading ? () {} : onPressed,
      width: resolvedWidth,
      height: height ?? 52.height,
      shape: LiquidRoundedRectangle(borderRadius: borderRadius.radius),
      useOwnLayer: true,
      quality: LGQuality.premium,
      settings: const LiquidGlassSettings(
        blur: 18,
        thickness: 28,
        lightIntensity: 0.75,
        lightAngle: 0.5 * pi,
        ambientStrength: 0.12,
        refractiveIndex: 1.25,
        chromaticAberration: 0.005,
        saturation: 1.2,
        glassColor: Color.fromARGB(30, 255, 255, 255),
      ),
      child: isLoading
          ? SizedBox(
              width: 24.radius,
              height: 24.radius,
              child: const CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            )
          : Text(
              label,
              style: labelStyle ??
                  TextStyle(
                    fontSize: context.responsiveFontScale(16),
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
            ),
    );
  }
}