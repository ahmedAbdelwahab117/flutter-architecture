import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/constant/app_colors.dart';
import '../utils/functions/responsive.dart';
import '../utils/functions/router_handler.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({
    super.key,
    required this.title,
    this.trailing,
    this.titleColor,
    this.backgroundColor,
    this.showBackButton = true,
  });

  final String title;
  final Widget? trailing;
  final Color? titleColor;
  final Color? backgroundColor;
  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    final titleCol = titleColor ?? AppColors.titleTextColor;

    final padding = context.byDevice<EdgeInsets>(
      mobilePortrait: EdgeInsets.symmetric(
        horizontal: 16.width,
        vertical: 16.height,
      ),
      mobileLandscape: EdgeInsets.symmetric(
        horizontal: 20.width,
        vertical: 12.height,
      ),
      tablet: EdgeInsets.symmetric(horizontal: 32.width, vertical: 20.height),
    );

    final titleFontSize = context.byDevice<double>(
      mobilePortrait: 18.sp,
      mobileLandscape: 18.sp,
      tablet: 22.sp,
    );

    return backgroundColor != null
        ? Container(
            color: backgroundColor,
            padding: padding,
            child: _buildRow(context, isRtl, titleCol, titleFontSize),
          )
        : Padding(
            padding: padding,
            child: _buildRow(context, isRtl, titleCol, titleFontSize),
          );
  }

  Widget _buildRow(
    BuildContext context,
    bool isRtl,
    Color titleCol,
    double fontSize,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (showBackButton)
          GestureDetector(
            onTap: () => RouterHandler.pop(context),
            child: Icon(
              isRtl ? Icons.arrow_back_ios_new : Icons.arrow_back_ios,
              color: titleCol,
              size: 20.r,
            ),
          )
        else
          SizedBox(width: 24.r),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              color: titleCol,
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        trailing ?? SizedBox(width: 24.r),
      ],
    );
  }
}
