// import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trade_master/shared/resources/assets_manager.dart';
import 'package:trade_master/shared/resources/colors_manager.dart';
import 'package:trade_master/shared/reusable%20components/custom_text.dart';

import '../../../shared/resources/strings_manager.dart';

Future<void> _takePhoto(
  ImageSource source,
  void Function(XFile?) updateImage,
) async {
  final pickedImage = await _pickImage(source);

  // final picker = ImagePicker();
  // final pickedImage = await picker.pickImage(source: source,);
  updateImage(pickedImage);
}

Future<XFile?> _pickImage(ImageSource source) async {
  final picker = ImagePicker();
  final pickedImage = await picker.pickImage(source: source);
  return pickedImage != null ? XFile(pickedImage.path) : null;
}

void showImagePicker(BuildContext context, updateImage) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: SvgPicture.asset(AssetsManager.cameraIcon),
              title: CustomText(
                  text: StringsManager.captureFromCamera,
                  color: ColorsManager.gray3DColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 14),
              onTap: () {
                _takePhoto(ImageSource.camera, updateImage);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: SvgPicture.asset(AssetsManager.gallaryIcon),
              title: CustomText(
                  text: StringsManager.pickFromGallery,
                  color: ColorsManager.gray3DColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 14),
              onTap: () {
                _takePhoto(ImageSource.gallery, updateImage);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: SvgPicture.asset(AssetsManager.removeIcon),
              title: CustomText(
                  text: StringsManager.removeProfilePhoto,
                  color: ColorsManager.redE5Color,
                  fontWeight: FontWeight.w400,
                  fontSize: 14),
              onTap: () {
                updateImage(null);

                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    },
  );
}
