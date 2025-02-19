import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../constants.dart';
import '../resources/assets_manager.dart';
import '../resources/colors_manager.dart';

class CustomTextFiled extends StatefulWidget {
  const CustomTextFiled({
    super.key,
    required this.hintText,
    this.validator,
    this.isPhoto = false,
    this.isPassword = false,
    this.isPrefix = false,
    required this.controllers,
    required this.borderColor,
    this.isLast = false,
   required this.hintColor,
  });

  final TextEditingController controllers;
  final String hintText;
  final bool? isPassword;
  final bool? isPhoto;
  final bool isPrefix;
  final bool isLast;
  final String? Function(String?)? validator;
  final Color borderColor ;
  final Color hintColor ;

  @override
  State<CustomTextFiled> createState() => _CustomTextFiledState();
}

class _CustomTextFiledState extends State<CustomTextFiled> {
  bool isObscured = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 49.h,
      width: 343.w,
      child: TextFormField(
        // inputFormatters: [
        //   LengthLimitingTextInputFormatter(14),
        //   FilteringTextInputFormatter.digitsOnly,
        // ],
        controller: widget.controllers,
        style: Theme.of(context).textTheme.bodySmall,

        validator: widget.validator,
        obscureText: widget.isPassword! && isObscured,


        decoration: InputDecoration(


         suffixIconConstraints:  BoxConstraints(
            maxHeight: 27.h,
            maxWidth: 27.w,
          ),



          suffixIcon: widget.isPassword!
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      isObscured = !isObscured;
                    });
                  },
                  child: Padding(
                    padding:  EdgeInsets.only(right:context.locale.languageCode ==Constants.ar ? 0.w : 5.w,left: context.locale.languageCode ==Constants.ar ? 5.w : 0.w),
                    child: SvgPicture.asset(
                                    height: 20,
                                    width: 20,
                      isObscured ? AssetsManager.lockEye : AssetsManager.eyeIcon,
                    ),
                  ),
                )
              : null,
          errorStyle: const TextStyle(
            color: ColorsManager.redColor,
            height: 0,
            fontSize: 12,
            fontFamily: 'Poppins',
          ),
contentPadding: EdgeInsets.only(left: 10.w,right: 10.w),

          errorBorder: OutlineInputBorder(

              borderRadius: BorderRadius.circular(10.r),


              borderSide: const BorderSide(color:ColorsManager.mainColor, )

          ),
          filled: true,
          fillColor: ColorsManager.fillColorTextFiled,
          enabledBorder:  OutlineInputBorder(


            borderRadius: BorderRadius.all(Radius.circular(10.r)),
            borderSide: BorderSide(


              color: widget.borderColor,
            ),
          ),
          hintText: widget.hintText.tr(),
          hintStyle: TextStyle(
              color: widget.hintColor, fontFamily: 'Poppins'),

           focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
        color: ColorsManager.mainColor,
        ),
      ),
          ),
        ),
      );

  }
}

// class CustomImagePickerTextFiled extends StatefulWidget {
//   CustomImagePickerTextFiled({
//     super.key,
//     required this.hintText,
//     this.isPhoto = false,
//     required this.controller,
//   });
//
//   final TextEditingController controller;
//   final String hintText;
//   final bool isPhoto;
//
//   @override
//   State<CustomImagePickerTextFiled> createState() =>
//       _CustomImagePickerTextFiledState();
// }
//
// class _CustomImagePickerTextFiledState
//     extends State<CustomImagePickerTextFiled> {
//   final ImagePicker _picker = ImagePicker();
//
//   XFile? _selectedImage;
//
//   Future<void> _pickImage() async {
//     final XFile? pickedFile =
//         await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         widget.controller.text = pickedFile.path;
//       });
//     } /*else if (pickedFile == null) {
//    setState(() {
//      widget.controller.text =
//      'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png';
//
//    }); }*/
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 28.h,
//       width: 332.13.w,
//       child: TextFormField(
//         readOnly: true,
//         controller: widget.controller,
//         style: Theme.of(context).textTheme.bodySmall,
//         decoration: InputDecoration(
//           suffixIcon: widget.isPhoto
//               ? GestureDetector(
//                   onTap: _pickImage,
//                   child: SvgPicture.asset(
//                     AssetsManager.uploadPhoto,
//                     height: 21.h,
//                     width: 21.w,
//                   ),
//                 )
//               : null,
//           enabledBorder: const UnderlineInputBorder(
//             borderSide: BorderSide(
//               color: ColorsManager.hintTextColor,
//             ),
//           ),
//           hintText: '${widget.hintText.tr()}(${StringsManager.optional.tr()})',
//           hintStyle: const TextStyle(
//               color: ColorsManager.hintTextColor, fontFamily: 'Poppins'),
//           border: const UnderlineInputBorder(
//             borderSide: BorderSide(),
//           ),
//         ),
//       ),
//     );
//   }
// }

class CustomTextFiled1 extends StatefulWidget {
  const CustomTextFiled1({
    super.key,
    required this.hintText,
    this.validator,
    this.isPhoto = false,
    this.isPassword = false,
    this.isPrefix = false,
    required this.controllers,
  });

  final TextEditingController controllers;
  final String hintText;
  final bool? isPassword;
  final bool? isPhoto;
  final bool isPrefix;
  final String? Function(String?)? validator;

  @override
  State<CustomTextFiled1> createState() => _CustomTextFiled1State();
}

class _CustomTextFiled1State extends State<CustomTextFiled1> {
  bool isObscured = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 43.h,
      width: 328.w,
      child: TextFormField(
        controller: widget.controllers,
        style: Theme.of(context).textTheme.bodySmall,
        validator: widget.validator,
        obscureText: widget.isPassword! && isObscured,

        decoration: InputDecoration(

          suffixIconConstraints:  BoxConstraints(
            maxHeight: 27.h,
            maxWidth: 27.w,
          ),
          prefixIcon: widget.isPrefix? Padding(
            padding:  EdgeInsets.only(left: 6.w,right: 7.w,top:11.h,bottom:11.h),
            child: SvgPicture.asset(AssetsManager.creditCardIcon,),
          ):const SizedBox(),


          suffixIcon: widget.isPassword!
              ? GestureDetector(
            onTap: () {
              setState(() {
                isObscured = !isObscured;
              });
            },
            child: Padding(
              padding:  EdgeInsets.only(right: 5.w),
              child: SvgPicture.asset(
                height: 27,
                width: 27,
                isObscured ? AssetsManager.lockEye : AssetsManager.eyeIcon,
              ),
            ),
          )
              : null,
          errorStyle: const TextStyle(
            color: ColorsManager.redColor,
            height: 0,
            fontSize: 12,
            fontFamily: 'Poppins',
          ),


          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color:ColorsManager.mainColor, )

          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorsManager.grayColor,
            ),
          ),
          hintText: widget.hintText.tr(),
          hintStyle: const TextStyle(
              color: ColorsManager.grayColor, fontFamily: 'Poppins'),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color:ColorsManager.mainColor, )

          )
          ,   focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorsManager.mainColor,
          ),
        ),
        ),
      ),
    );

  }
}
