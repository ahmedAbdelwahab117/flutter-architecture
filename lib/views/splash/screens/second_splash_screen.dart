import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trade_master/shared/resources/assets_manager.dart';
import 'package:trade_master/shared/resources/colors_manager.dart';
import 'package:trade_master/shared/resources/strings_manager.dart';
import 'package:trade_master/shared/reusable%20components/custom_button.dart';
import 'package:trade_master/shared/reusable%20components/custom_text.dart';
import 'package:trade_master/shared/routing/routes_manager.dart';

class SecondSplashScreen extends StatelessWidget {
  const SecondSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorsManager.whiteColor,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(image: AssetImage(AssetsManager.mainIcon)),
              SizedBox(height: 56.h),
              CustomText(
                  text: StringsManager.firstTitle,
                  color: ColorsManager.textColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 18),
              SizedBox(height: 20.h),
              CustomText(
                  text: StringsManager.firstDesc,
                  color: ColorsManager.text2Color,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  maxLines: 5,
                  textAlign: TextAlign.center),
              SizedBox(height: 190.h),
              CustomButton(
                text: StringsManager.getStarted,
                function: () {
                  Navigator.of(context).pushNamed(RoutesManager.onboarding);
                },
                height: 49.h,
                width: 343.w,
                color: ColorsManager.mainColor,
                textColor: ColorsManager.whiteColor,
              )
            ],
          ),
        ));
  }
}
