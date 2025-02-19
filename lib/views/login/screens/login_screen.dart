import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../shared/resources/colors_manager.dart';
import '../../../shared/resources/strings_manager.dart';
import '../../../shared/reusable components/CustomColumnTextFiled.dart';
import '../../../shared/reusable components/custom_appbar.dart';
import '../../../shared/reusable components/custom_button.dart';
import '../../../shared/reusable components/custom_row.dart';
import '../../../shared/reusable components/custom_text.dart';
import '../../../shared/routing/routes_manager.dart';

class  LoginScreen extends StatefulWidget {
  const  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
 late TextEditingController _phoneController ;
 late TextEditingController _passwordController ;
class _LoginScreenState extends State<LoginScreen> {

  @override
  void initState() {
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
     super.initState();
  }
  @override
  dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.whiteColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomAppbar(
                title: StringsManager.signInTitle,
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
              //=======================================password=================================================
              CustomColumnTextFiled(
                title: StringsManager.password,
                hint: StringsManager.enterYourPassword,
                controller: _passwordController,
                borderColor: ColorsManager.whiteD9Color,
                hintColor: ColorsManager.whiteCBColor,
                isPassword: true,
              ),
              //=======================================ForgetPassword=================================================
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      style: TextButton.styleFrom(
                          padding: EdgeInsets.zero),

                      onPressed: () {
                        Navigator.of(context).pushNamed(RoutesManager.forgetPasswordScreen);
                      },
                      child:  CustomText(
                        decoration: TextDecoration.underline,
                          text: StringsManager.forgotPassword,
                          color: ColorsManager.mainColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 12)


                  ),
                ],
              ),

              //=======================================button=================================================
              SizedBox(
                height: 216.h,
              ),
              CustomButton(
                text: StringsManager.signIn,
                function: () {},
                color: ColorsManager.mainColor,
                height: 49.h,
                width: 343.w,
                textColor: ColorsManager.whiteColor,
              ),
              //=======================================customRow Auth=================================================
              SizedBox(
                height: 16.h,
              ),
              CustomRowAuth(
                firstText: StringsManager.doNotHaveAnAccount,
                secondText: StringsManager.signUp,
                firstTextColor: ColorsManager.gray3DColor,
                secondTextColor: ColorsManager.gray2cColor,
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(
                height: 16.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
