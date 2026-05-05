import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../shared/resources/colors_manager.dart';
import '../../../shared/reusable components/custom_text.dart';

class CustomProgressRow extends StatelessWidget {
  const CustomProgressRow({
    super.key, required this.text, required this.color,
    required  this.value ,
  });
  final String text;
  final Color color;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(text: text, color: ColorsManager.gray82Color, fontWeight: FontWeight.w400, fontSize: 12),
        SizedBox(),
        SizedBox(
          width: 225.w,
          height: 6.h,
          child: LinearProgressIndicator(
            backgroundColor: ColorsManager.background,
            color: color,
            borderRadius: BorderRadius.circular(5.r),
            value: value ?? 0.0,
          ),
        ),
      ],
    );
  }
}