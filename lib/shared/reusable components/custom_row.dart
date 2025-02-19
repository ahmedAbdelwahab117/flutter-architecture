import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

// import '../../../shared/resources/colors_manager.dart';
import '../../../shared/reusable components/custom_text.dart';

class CustomRowAuth extends StatelessWidget {
  const CustomRowAuth({
    super.key,
    required this.firstText,
    required this.secondText,
    this.onTap,
    required this.firstTextColor,
    required this.secondTextColor,
  });

  final String firstText;
  final Color firstTextColor;
  final String secondText;
  final Color secondTextColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomText(
            text: '${firstText.tr()} ',
            color: firstTextColor,
            fontWeight: FontWeight.w400,
            fontSize: 12.8),
        GestureDetector(
            onTap: onTap,
            child: CustomText(
              text: secondText.tr(),
              color: secondTextColor,
              fontWeight: FontWeight.w400,
              fontSize: 12.8,
              decoration: TextDecoration.underline,
            )),
      ],
    );
  }
}
