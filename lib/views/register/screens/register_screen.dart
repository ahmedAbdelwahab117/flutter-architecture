import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trade_master/shared/resources/colors_manager.dart';
import 'package:trade_master/shared/resources/strings_manager.dart';
import 'package:trade_master/shared/reusable%20components/CustomColumnTextFiled.dart';
import 'package:trade_master/shared/reusable%20components/custom_button.dart';
import 'package:trade_master/shared/reusable%20components/custom_row.dart';
import 'package:trade_master/shared/routing/routes_manager.dart';

import '../../../shared/reusable components/custom_appbar.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

late TextEditingController _nameController;
late TextEditingController _emailController;
late TextEditingController _phoneController;
late TextEditingController _passwordController;

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  void initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
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
                title: StringsManager.signUp,
              ),
              //=======================================full name=================================================
              CustomColumnTextFiled(
                title: StringsManager.fullName,
                hint: StringsManager.enterYourFullName,
                controller: _nameController,
                borderColor: ColorsManager.whiteD9Color,
                hintColor: ColorsManager.whiteCBColor,
              ),
              SizedBox(
                height: 16.h,
              ),
              CustomColumnTextFiled(
                title: StringsManager.fullName,
                hint: StringsManager.enterYourFullName,
                controller: _nameController,
                borderColor: ColorsManager.whiteD9Color,
                hintColor: ColorsManager.whiteCBColor,
              ),
              SizedBox(
                height: 16.h,
              ),
              //=======================================email=================================================
              CustomColumnTextFiled(
                title: StringsManager.email,
                hint: StringsManager.enterYourEmail,
                controller: _emailController,
                borderColor: ColorsManager.whiteD9Color,
                hintColor: ColorsManager.whiteCBColor,
              ),
              SizedBox(
                height: 16.h,
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

              //=======================================button=================================================
              SizedBox(
                height: 64.h,
              ),
              CustomButton(
                text: StringsManager.signUp,
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
                firstText: StringsManager.alreadyHaveAnAccount,
                secondText: StringsManager.signIn,
                firstTextColor: ColorsManager.gray3DColor,
                secondTextColor: ColorsManager.gray2cColor,
                onTap: () {
                  Navigator.of(context).pushNamed(RoutesManager.loginScreen);
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


