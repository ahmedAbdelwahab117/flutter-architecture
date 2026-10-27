import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/constant/app_colors.dart';
import '../utils/functions/responsive.dart';

class AppTextField extends StatelessWidget {
  final String label;
  final String? labelTrailing;
  final String hint;
  final TextEditingController controller;
  final bool obscureText;
  final bool isrequired;
  final bool isPassword;
  final VoidCallback? onToggleVisibility;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final TextInputAction textInputAction;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int? maxLines;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;
  final bool readOnly;
  final VoidCallback? onTap;

  const AppTextField({
    super.key,
    required this.label,
    this.labelTrailing,
    required this.hint,
    required this.controller,
    this.obscureText = false,
    this.isPassword = false,
    this.onToggleVisibility,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.textInputAction = TextInputAction.next,
    this.focusNode,
    this.nextFocusNode,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines = 1,
    this.maxLength,
    this.inputFormatters,
    this.onChanged,
    this.readOnly = false,
    this.onTap,  this.isrequired = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty) ...[
          Padding(
            padding: EdgeInsets.only(top: 12.height),
            child: Row(
              mainAxisAlignment:  MainAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: AppColors.titleTextColor,
                    fontSize: context.responsiveFontScale(14),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                  !isrequired
                    ? const SizedBox.shrink()
                    : Text(
                        '*',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: context.responsiveFontScale(14),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                if (labelTrailing != null && labelTrailing!.isNotEmpty) ...[
                  SizedBox(width: 6.width),
                  Text(
                    labelTrailing!,
                    style: TextStyle(
                      color: AppColors.hintColor,
                      fontSize: context.responsiveFontScale(13),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ],
            ),
          ),
          SizedBox(height: 8.height),
        ],
        SizedBox(
          width: 560.width,
          child: TextFormField(
            controller: controller,
            
            obscureText: obscureText,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            focusNode: focusNode,
            validator: validator,
            maxLines: obscureText ? 1 : maxLines,
            maxLength: maxLength,
            inputFormatters: inputFormatters,
            onChanged: onChanged,
            readOnly: readOnly,
            onTap: onTap,
            onFieldSubmitted: (_) {
              if (nextFocusNode != null) {
                FocusScope.of(context).requestFocus(nextFocusNode);
              }
            },
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: AppColors.hintColor, fontSize: context.responsiveFontScale(13)),
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.width,
                vertical: 14.height,
              ),
              counterText: '',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.radius),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.radius),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.radius),
                borderSide: const BorderSide(
                  color: AppColors.primaryColor,
                  width: 1.5,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.radius),
                borderSide: const BorderSide(color: AppColors.errorColor),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.radius),
                borderSide: const BorderSide(
                  color: AppColors.errorColor,
                  width: 1.5,
                ),
              ),
              prefixIcon: prefixIcon,
              suffixIcon: isPassword
                  ? IconButton(
                      icon: Icon(
                        obscureText ? Icons.visibility_off : Icons.visibility,
                        color: AppColors.hintColor,
                        size: 20.radius,
                      ),
                      onPressed: onToggleVisibility,
                    )
                  : suffixIcon,
            ),
          ),
        ),
      ],
    );
  }
}
