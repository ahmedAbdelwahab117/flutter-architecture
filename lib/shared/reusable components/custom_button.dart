import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback function;
  final double? width;
  final double? height;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;


  const CustomButton({
    super.key,
    required this.text,
    required this.function,
    this.height,
    this.width,
    this.color, this.textColor, this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: function,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: borderColor ?? Colors.transparent),
            color: color,
          ),
          height: height?.h,
          width: width?.w,
          child: Center(
              child: Text(text.tr(),
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins',
                        fontSize: 16.h,
                        color: textColor,
                      ))),
        ),
      ),
    );
  }
}
