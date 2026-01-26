import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DefaultFormField extends StatelessWidget {
  String? Function(String?)? validate;
  String hint;
  TextEditingController controller;
  TextInputType textInputType;
  bool? isObscured;
  Widget? suffixIcon;
  Widget? suffixIconObscured;
  FocusNode? focusNode;
  FocusNode? nextFocus;
  void Function(bool)? onTap;
  Function(String)? onchange;
  TextInputAction? textInputAction;
  Function(String)? onSubmitted;
  DefaultFormField({required this.hint,
    required this.validate,
    required this.controller,
    required this.textInputType,
    this.isObscured,
    this.suffixIcon,
    this.suffixIconObscured,
    this.focusNode,
    this.onchange,
    this.onTap,
    this.textInputAction,
    this.onSubmitted,
    this.nextFocus});

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: onTap,
      child: TextFormField(
        cursorHeight:20.h,
        onFieldSubmitted: onSubmitted,
        keyboardType: textInputType,
        obscureText: isObscured ?? false,
        onChanged: onchange,
        controller: controller,
        textInputAction: textInputAction,
        decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Theme
                        .of(context)
                        .cardColor, width: 1.5.w)),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Theme
                        .of(context)
                        .cardColor, width: 1.5.w)),
            errorBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 1.5.w)),
            hintText: hint,
            hintStyle: Theme
                .of(context)
                .textTheme
                .titleSmall,
            contentPadding: REdgeInsetsDirectional.all(10),
            suffixIcon: isObscured ?? false ? suffixIconObscured : suffixIcon),
        style: Theme
            .of(context)
            .textTheme
            .displayMedium!
            .copyWith(fontWeight: FontWeight.normal),
        validator: validate,
        focusNode: focusNode,
      ),
    );
  }
}