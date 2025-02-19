import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../custom_launcher.dart';
import '../resources/assets_manager.dart';

class CustomSocialIconsRow extends StatelessWidget {
  const CustomSocialIconsRow({
    super.key,
    required this.height,
    required this.width,this.whatsapp,this.telegram,
    this.isCallIcon = false, this.isSupport,  this.name = '',
  });

  final int height;
  final String? whatsapp;
  final String? telegram;
  final String ?name;
  final int width;
 final bool ? isCallIcon;
 final bool ? isSupport;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
         isCallIcon == true ? GestureDetector(
          onTap: () {
            CustomLauncher().call(whatsapp!, name??'');
          },
          child: SvgPicture.asset(
            AssetsManager.callIcon,
            height: height.h,
            width: width.w,
          ),
        ) : const SizedBox(),
        SizedBox(
          width:isSupport==true? 30.w:11.w,
        ),
        GestureDetector(
          onTap: () {
            CustomLauncher().openWhatsApp(whatsapp!);
          },
          child: SvgPicture.asset(
            AssetsManager.whatsappIcon,
            width: width.w,
            height: height.h,
          ),
        ),
        SizedBox(
          width: isSupport==true? 30.w:11.w,
        ),
        GestureDetector(
         onTap: () {
 CustomLauncher().openTelegram(telegram!);
         },
          child: SvgPicture.asset(
            AssetsManager.telegramIcon,
            height: height.h,
            width: width.w,
          ),
        ),

      ],
    );
  }
}


class CustomSocialIconsRow1 extends StatelessWidget {
  const CustomSocialIconsRow1({
    super.key,
    required this.height,
    required this.width,this.whatsapp,this.telegram,
    this.isCallIcon = false, this.isSupport,  this.name = '',
  });

  final int height;
  final String? whatsapp;
  final String? telegram;
  final String ?name;
  final int width;
  final bool ? isCallIcon;
  final bool ? isSupport;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        isCallIcon == true ? GestureDetector(
          onTap: () {
            CustomLauncher().call(whatsapp!, name??'');
          },
          child: SvgPicture.asset(
            AssetsManager.callIcon,
            height: height.h,
            width: width.w,
          ),
        ) : const SizedBox(),
        SizedBox(
          width:isSupport==true? 30.w:11.w,
        ),
        GestureDetector(
          onTap: () {
            CustomLauncher().openWebsite(whatsapp??'');
          },
          child: SvgPicture.asset(
            AssetsManager.whatsappIcon,
            width: width.w,
            height: height.h,
          ),
        ),
        SizedBox(
          width: isSupport==true? 30.w:11.w,
        ),
        GestureDetector(
          onTap: () {
            CustomLauncher().openWebsite(telegram??'');
          },
          child: SvgPicture.asset(
            AssetsManager.telegramIcon,
            height: height.h,
            width: width.w,
          ),
        ),

      ],
    );
  }
}
