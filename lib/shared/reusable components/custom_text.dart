import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomText extends StatelessWidget {
  const CustomText(
      {super.key,
      required this.text,
      required this.color,
      required this.fontWeight,
      required this.fontSize,
      this.textAlign,
      this.decoration,
      this.maxLines});

  final TextAlign? textAlign;
  final String text;
  final Color color;
  final FontWeight fontWeight;
  final double fontSize;
  final TextDecoration? decoration;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Localizations.override(
      context: context,
      locale: context.locale,
      child: Text(

        textAlign: textAlign,
        text.tr(),
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            decoration: decoration,
            color: color,
            fontSize: fontSize.sp,
            fontWeight: fontWeight,
            decorationColor: color,
            fontFamily: 'Poppins'),
      ),
    );
  }
}
