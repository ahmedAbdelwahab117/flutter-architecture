import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

import '../resources/colors_manager.dart';
import 'custom_button.dart';
import 'custom_text.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    super.key,
    this.buttonOnTap,
    required this.text,
    required this.image,
    required this.chosen,
    this.firstButtonText,
    this.secondButtonText,
  });

  final bool chosen;
  final String text;
  final String? firstButtonText;
  final String? secondButtonText;
  final String image;
  final VoidCallback? buttonOnTap;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        chosen
            ? Row(
                children: [
                  CustomButton(
                    text: firstButtonText!,
                    function: () {
                      Navigator.of(context).pop();
                    },
                    height: 34.h,
                    width: 117.w,
                    color: ColorsManager.mainColor,
                    textColor: ColorsManager.whiteColor,
                  ),
                  SizedBox(
                    width: 16.w,
                  ),
                  CustomButton(
                      height: 34.h,
                      width: 117.w,
                      color: ColorsManager.grayColor,
                      textColor: ColorsManager.whiteColor,
                      text: secondButtonText!,
                      function: buttonOnTap!),
                ],
              )
            : const SizedBox(),
      ],
      backgroundColor: ColorsManager.whiteColor,
      insetPadding: EdgeInsets.only(right: 18.w, left: 18.w),
      iconPadding: EdgeInsets.only(top: 0.h, left: 0, right: 0, bottom: 10.h),
      titlePadding: EdgeInsets.only(right: 40.w, left: 40.w, bottom: 3.h),
      title: CustomText(
          maxLines: 2,
          textAlign: TextAlign.center,
          text: text.tr(),
          color: ColorsManager.textColor,
          fontWeight: FontWeight.w400,
          fontSize: 14),
      icon: Column(
        children: [
          // Padding(
          //   padding: EdgeInsets.only(
          //     left: 272.w,
          //     right: 10.w,
          //     top: 10.h,
          //   ),
          //   child: GestureDetector(
          //     onTap: () => Navigator.of(context).pop(),
          //     child: const Icon(
          //       Icons.close,
          //     ),
          //   ),
          // ),
          Lottie.asset(
            image,
            height: 70.h,
            width: 70.w,
            fit: BoxFit.cover,
            delegates: LottieDelegates(values: [
              ValueDelegate.color(
                const ['**'],
                callback: (value) => ColorsManager.mainColor,
              ),
            ]),
          ),
          SizedBox(
            height: 12.h,
          ),
        ],
      ),
    );
  }
}
