import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../shared/resources/colors_manager.dart';
import '../../../shared/reusable components/custom_text.dart';
import '../../../shared/reusable components/custom_text_filed.dart';

class CustomColumnTextFiled extends StatelessWidget {
  const CustomColumnTextFiled({
    super.key,
    required this.title,
    required this.hint,
    required this.controller,
    this.isPassword = false,
    this.isLast = false,
    this.validator,
   required this.borderColor,
   required this.hintColor,
  });

  final String title;
  final String hint;
  final TextEditingController controller;
  final bool? isPassword;
  final bool isLast;
  final Color? borderColor;
  final Color? hintColor;

  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:  EdgeInsets.only(left: 8.w),
          child: CustomText(
              text: title,
              color: ColorsManager.textColor,
              fontWeight: FontWeight.w500,
              fontSize: 12),
        ),
        SizedBox(height: 4.h),
        CustomTextFiled(
           hintColor: hintColor!,
borderColor: borderColor!,
          hintText: hint,
          isLast: isLast,
          controllers: controller,
          isPassword: isPassword,
          validator: validator,
        )
      ],
    );
  }
}
