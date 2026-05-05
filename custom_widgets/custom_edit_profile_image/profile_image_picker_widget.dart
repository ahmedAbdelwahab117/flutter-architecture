import 'dart:io';



import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trade_master/views/account/widgets/pick_image.dart';
import 'package:trade_master/views/account/widgets/profile_image.dart';

import '../../../shared/resources/assets_manager.dart';
import '../../../shared/resources/colors_manager.dart';

class ProfileImagePickerWidget extends StatelessWidget {
  const ProfileImagePickerWidget(
      {super.key,
      required this.onTap,
      required this.pickedImage,
      required this.profileImage});

  final Function(XFile? xFile)? onTap;
  final XFile? pickedImage;
  final String? profileImage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        pickedImage != null && pickedImage?.path.isNotEmpty == true
            ? ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(50.r)),
                child: Image.file(
                  File(pickedImage!.path),
                  height: 100.h,
                  width: 100.w,
                  fit: BoxFit.cover,
                ),
              )
            : ProfileImage(
                image: profileImage ?? '',
              ),
        Positioned(
          bottom: -15,
          child: GestureDetector(
            onTap: () {
              showImagePicker(context, onTap);
            },
            child: Container(
              padding: REdgeInsets.all(7),
              decoration: const BoxDecoration(
                color: ColorsManager.whiteColor,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                AssetsManager.cameraIcon,
                color: ColorsManager.mainColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
