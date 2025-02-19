import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
    this.height,
    this.indent,
    this.endIndent,
    this.thickness,
    this.color,
  });

  final double? height;
  final int? indent;
  final int? endIndent;
  final double? thickness;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Divider(

      height: height?.h,
      color: color,
      endIndent: endIndent?.w,
      thickness: thickness?.h,
      indent: indent?.w,
    );
  }
}
