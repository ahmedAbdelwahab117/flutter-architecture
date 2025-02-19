
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../shared/resources/colors_manager.dart';
import '../../../shared/resources/strings_manager.dart';
import '../../../shared/reusable components/CustomColumnTextFiled.dart';
import '../../../shared/reusable components/custom_appbar.dart';
import '../../../shared/reusable components/custom_button.dart';
import '../../../shared/reusable components/custom_text.dart';


class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}
late TextEditingController _passwordController;
late TextEditingController _confirmPasswordController;




class _ResetPasswordScreenState extends State<ResetPasswordScreen> {

  @override
  void initState() {
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();

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
                  title: StringsManager.resetPassword,
                ),

                //=======================================description=================================================

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: CustomText(
                    text: StringsManager.pleaseEnterYourNewPassword,
                    color: ColorsManager.gray82Color,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 40.h,
                ),

                //=======================================password=================================================
                CustomColumnTextFiled(
                  title: StringsManager.password,
                  hint: StringsManager.enterYourPassword,
                  controller: _passwordController,
                  borderColor: ColorsManager.whiteD9Color,
                  hintColor: ColorsManager.whiteCBColor,
                  isPassword: true,
                ),
                SizedBox(
                  height: 16.h,
                ),


                //=======================================confirmPassword=================================================
                CustomColumnTextFiled(
                  title: StringsManager.confirmPassword,
                  hint: StringsManager.confirmYourPassword,
                  controller: _confirmPasswordController,
                  borderColor: ColorsManager.whiteD9Color,
                  hintColor: ColorsManager.whiteCBColor,
                  isPassword: true,
                ),

                //=======================================button=================================================

                SizedBox(
                  height: 215.h,
                ),
                CustomButton(
                  text: StringsManager.done,
                  function: () {
                    // Navigator.of(context).pushNamed(RoutesManager.resetPasswordScreen);
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
