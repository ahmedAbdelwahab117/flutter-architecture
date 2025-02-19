import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:trade_master/shared/resources/assets_manager.dart';
import 'package:trade_master/shared/resources/strings_manager.dart';

import '../../../shared/resources/colors_manager.dart';
import '../../../shared/reusable components/custom_text.dart';
import '../../../shared/routing/routes_manager.dart';

class CustomOnBoarding extends StatefulWidget {
  const CustomOnBoarding({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.controller,
  });

  final String image;
  final String title;
  final String description;
  final PageController controller;

  @override
  State<CustomOnBoarding> createState() => _CustomOnBoardingState();
}

class _CustomOnBoardingState extends State<CustomOnBoarding> {
  @override
  Widget build(BuildContext context) {
    return Localizations.override(
      context: context,
      locale: context.locale,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(children: [
            Image.asset(
              widget.image,
              width: double.infinity,
              height: 529.h,
              fit: BoxFit.cover,
            ),
            Positioned(
              top: 40.h,
              right: 24.w,
              child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(RoutesManager.registerScreen);
                  },
                  child: CustomText(
                    text: StringsManager.skip,
                    color: ColorsManager.textColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                  )),
            ),
            Positioned(
              bottom: 40.h,
              right: 170.w,
              child: SmoothPageIndicator(
                controller: widget.controller,
                count: 3,
                effect: WormEffect(
                  dotWidth: 8.w,
                  dotHeight: 8.h,
                  activeDotColor: ColorsManager.textColor,
                  dotColor: ColorsManager.whiteD9Color,
                ),
              ),
            ),
          ]),
          SizedBox(
            height: 40.h,
          ),
          CustomText(
            color: ColorsManager.textColor,
            text: widget.title.tr(),
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
          SizedBox(
            height: 24.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: CustomText(
              maxLines: 6,
              color: ColorsManager.text2Color,
              textAlign: TextAlign.center,
              text: widget.description.tr(),
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: 50.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: GestureDetector(
             onTap: () {
                if (widget.controller.page!.toInt() == 2) {
                  Navigator.of(context).pushNamed(RoutesManager.registerScreen);
                } else {
                  widget.controller.nextPage(
                      duration: Duration(milliseconds: 500), curve: Curves.ease);
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomText(
                      text: StringsManager.next,
                      color: ColorsManager.mainColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                  SizedBox(
                    width: 8.w,
                  ),
                  SvgPicture.asset(AssetsManager.arrowRightIcon)
                ],
              ),
            ),
          )
          // Text(
          //   widget.title.tr(),
          //   style: MyTheme.lightTheme.textTheme.displayMedium
          //       ?.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w500),
          // ),
          // Text(
          //   maxLines: 2,
          //   widget.description.tr(),
          //   style: MyTheme.lightTheme.textTheme.labelSmall
          //       ?.copyWith(fontSize: 12.sp, fontWeight: FontWeight.w300),
          // )
        ],
      ),
    );
  }
}
