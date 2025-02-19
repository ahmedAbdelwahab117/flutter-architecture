import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:trade_master/shared/reusable%20components/custom_row.dart';

import '../../../shared/resources/colors_manager.dart';
import '../../../shared/resources/strings_manager.dart';
import '../../../shared/reusable components/custom_appbar.dart';
import '../../../shared/reusable components/custom_button.dart';
import '../../../shared/reusable components/custom_pinbut.dart';
import '../../../shared/reusable components/custom_text.dart';
import '../../../shared/routing/routes_manager.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

late TextEditingController _otpController;
late Timer _timer;
int _start = 60;
bool _isResendButtonEnabled = false;

class _OtpScreenState extends State<OtpScreen> {
  @override
  void initState() {
    _otpController = TextEditingController();
    _startTimer();

    super.initState();
  }

  @override
  dispose() {
    _otpController.dispose();
    _timer.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.whiteColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomAppbar(
                  isBack: true,
                  isDescription: true,
                  title: StringsManager.oTPVerification,
                ),

                //=======================================description=================================================

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: StringsManager.enterTheOTPSentTo,
                        color: ColorsManager.gray82Color,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      ),
                      CustomText(
                        text: '+201027102701',
                        color: ColorsManager.gray3DColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40.h,
                ),

                //=======================================timer=================================================

                //todo: add timer here
                CustomText(
                    text: '1:33',
                    color: ColorsManager.red14Text,
                    fontWeight: FontWeight.w400,
                    fontSize: 14),
                SizedBox(
                  height: 16.h,
                ),

                //=======================================otpForm=================================================

                //todo: add timer here

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: CustomPinput(
                    otpController: _otpController,
                  ),
                ),
                SizedBox(
                  height: 14.h,
                ),
                CustomRowAuth(
                    firstText: StringsManager.doNotReceiveTheCode,
                    secondText: _isResendButtonEnabled
                        ? StringsManager.resendCode.tr()
                        : '${_start}s',
                    firstTextColor: ColorsManager.grayAFColor,
                    onTap: _isResendButtonEnabled
                        ? () {
                            _startTimer();
                          }
                        : null,
                    secondTextColor: ColorsManager.mainColor),

                //=======================================button=================================================

                SizedBox(
                  height: 251.h,
                ),
                CustomButton(
                  text: StringsManager.verify,
                  function: () {
                    Navigator.of(context)
                        .pushNamed(RoutesManager.resetPasswordScreen);
                  },
                  color: ColorsManager.mainColor,
                  height: 49.h,
                  width: 343.w,
                  textColor: ColorsManager.whiteColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _startTimer() {
    _isResendButtonEnabled = false;
    _start = 60;
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (_start == 0) {
        setState(() {
          _isResendButtonEnabled = true;
          timer.cancel();
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }
}


