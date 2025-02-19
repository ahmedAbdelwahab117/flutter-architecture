//appbar widget
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../resources/assets_manager.dart';
import '../resources/colors_manager.dart';
import 'custom_text.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({
    this.isDescription = false,
    this.title,
    this.isBack = false,
    super.key,
  });

  final String? title;

  final bool isBack;

  final bool isDescription;


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          isBack
              ? Padding(
            padding: EdgeInsets.only(top: 24.h),
            child: Row(
              children: [
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SvgPicture.asset(AssetsManager.arrowBackIcon))
              ],
            ),
          )
              : SizedBox(),
          SizedBox(
            height: 7.h,
          ),
          Image.asset(AssetsManager.masterIcon, width: 38.w, height: 46.h),
          SizedBox(
            height: 54.h,
          ),
          CustomText(
              text: title!,
              color: ColorsManager.textColor,
              fontWeight:isDescription ? FontWeight.w600: FontWeight.w800,
              fontSize:isDescription ? 18: 26),
          SizedBox(
            height: isDescription ?16.h :48.h,
          ),
        ],
      ),
    );
  }
}