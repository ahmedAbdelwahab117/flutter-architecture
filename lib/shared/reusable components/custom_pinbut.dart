import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:string_validator/string_validator.dart';

import '../resources/colors_manager.dart';
import '../resources/strings_manager.dart';

class CustomPinput extends StatelessWidget {
  const CustomPinput({
    super.key, required this.otpController,
  });
  final TextEditingController otpController;

  @override
  Widget build(BuildContext context) {
    return Pinput(
      controller: otpController,
      length: 6,
      autofocus: true,
      keyboardType: TextInputType.number,
      onTap: () {
        otpController.clear();
      },
      defaultPinTheme: PinTheme(
        margin: EdgeInsets.only(left: 8.w),
        height: 40.h,
        width: 40.w,
        decoration: BoxDecoration(
          border: Border.all(
            color: ColorsManager.pinPutColor,
          ),
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
      focusedPinTheme: PinTheme(
        margin: EdgeInsets.only(left: 12.w),
        width: 40.w,
        height: 40.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: ColorsManager.mainColor,
          ),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return StringsManager.required.tr();
        } else if (!value.isNumeric) {
          return StringsManager.otpValid.tr();
        } else {
          return null;
        }
      },
    );
  }
}