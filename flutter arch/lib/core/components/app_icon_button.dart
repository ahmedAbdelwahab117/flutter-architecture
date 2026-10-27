import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_liquid_glass_plus/buttons/liquid_glass_icon_button.dart';
import 'package:flutter_liquid_glass_plus/flutter_liquid_glass.dart';
import '../utils/functions/responsive.dart';

class AppIconButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;

  const AppIconButton({super.key, required this.onTap, required this.icon});

  @override
  Widget build(BuildContext context) {
    return LGIconButton(
                  icon: icon,
                  iconSize: 25,
                  onPressed: onTap,
                  size: 56.width,
                  shape: LGIconButtonShape.circle,
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
                );
  }
}