import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hossam_badawi/shared/custom_launcher.dart';

import '../colors_manager.dart';
import '../resources/strings_manager.dart';
import '../reusable components/custom_elevated_button.dart';



void showMustUpdateDialog(BuildContext context) {
  final screenSize = MediaQuery.of(context).size;

  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return PopScope(
        canPop: false,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(14.0)),
          ),
          backgroundColor: Theme.of(context).canvasColor,
          title: Text(
            StringsManager.updateIsRequired.tr(),
            style: TextStyle(
              color: ColorsManager.black,
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                StringsManager.updateIsRequiredContent.tr(),
                style: TextStyle(
                  color: ColorsManager.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 24),
              Row(
                children: [
                  CustomElevatedButtonWidget(
                    height: screenSize.height * 0.04,
                    width: screenSize.width * 0.05,
                    textStyle: TextStyle(fontSize: 16 , color: ColorsManager.whiteColor),
                    title: StringsManager.update.tr(),
                    onPressed: () {
                      CustomLauncher().openWebsite(StringsManager.googlePlayApp);
                    },
                  ),
                  SizedBox(width: 16),
                  CustomElevatedButtonWidget(
                    height: screenSize.height * 0.04,
                    width: screenSize.width * 0.09,
                    buttonColor: Colors.red,
                    textStyle: TextStyle(fontSize: 16 , color: ColorsManager.whiteColor),

                    title: StringsManager.exit.tr(),

                    onPressed: () => exit(0),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

