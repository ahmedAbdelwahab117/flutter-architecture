import 'package:flutter/material.dart';

class SuccessModel {
  final String title;
  final String subTitle;
  final String btnTitle;
  final Function(BuildContext) onTapBack;
  final String image;
  final Size imageSize;

  const SuccessModel({
    required this.title,
    required this.subTitle,
    required this.btnTitle,
    required this.onTapBack,
    required this.image,
    required this.imageSize,
  });
}
