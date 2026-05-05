import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/colors_manager.dart';
import 'custom_text.dart';

class CustomCheckBox extends StatefulWidget {
  const CustomCheckBox(
      {super.key,
      required this.title,
      required this.isSelected,
      this.onChanged});

  final String title;
 final bool isSelected;

  final Function(bool?)? onChanged;

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 16.h,
          height: 16.h,
          child: Checkbox(
              activeColor: ColorsManager.mainColor,
              value: widget.isSelected,
              onChanged: widget.onChanged),
        ),
        CustomText(
            text: ' ${widget.title.tr()}',
            color: ColorsManager.grayColor,
            fontWeight: FontWeight.w400,
            fontSize: 12)
      ],
    );
  }
}






class CustomCheckBox2 extends StatefulWidget {
  CustomCheckBox2({super.key, required this.title,required this.isSelected, this.onChanged});

  final String title;
  bool isSelected ;
  final Function(bool?)? onChanged;

  @override
  State<CustomCheckBox2> createState() => _CustomCheckBox2State();
}

class _CustomCheckBox2State extends State<CustomCheckBox2> {

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 16.h,
          height: 16.h,
          child: Checkbox(
            activeColor: ColorsManager.mainColor,

              value: widget.isSelected,
              onChanged: widget.onChanged),
        ),
        CustomText(
            text: ' ${widget.title.tr()}',
            color: ColorsManager.textColor,
            fontWeight: FontWeight.w400,
            fontSize: 12)
      ],
    );
  }
}
