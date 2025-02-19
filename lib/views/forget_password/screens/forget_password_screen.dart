import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trade_master/shared/reusable%20components/custom_text.dart';

import '../../../shared/resources/colors_manager.dart';
import '../../../shared/resources/strings_manager.dart';
import '../../../shared/reusable components/CustomColumnTextFiled.dart';
import '../../../shared/reusable components/custom_appbar.dart';
import '../../../shared/reusable components/custom_button.dart';
import '../../../shared/routing/routes_manager.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}
late TextEditingController _phoneController;

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  @override
  void initState() {
    _phoneController = TextEditingController();
    super.initState();
  }

  @override
  dispose() {
    _phoneController.dispose();
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
                  title: StringsManager.forgotPasswordTitle,
                ),
        
        
                //=======================================description=================================================
        
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: CustomText(
                  text: StringsManager.forgotPasswordDesc,
                  color: ColorsManager.gray4Color,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ),
                SizedBox(
                  height: 40.h,
                ),
        
                //=======================================phone number=================================================
                CustomColumnTextFiled(
                  title: StringsManager.phoneNumber,
                  hint: StringsManager.enterYourPhoneNumber,
                  controller: _phoneController,
                  borderColor: ColorsManager.whiteD9Color,
                  hintColor: ColorsManager.whiteCBColor,
                ),
                SizedBox(
                  height: 16.h,
                ),
        
        
                //=======================================button=================================================
                SizedBox(
                  height: 281.h,
                ),
                CustomButton(
                  text: StringsManager.sendCode,
                  function: () {
                    Navigator.of(context).pushNamed(RoutesManager.otpScreen);
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
}
