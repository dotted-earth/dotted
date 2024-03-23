import 'package:flutter/material.dart';

class OnBoardingPageModel {
  final String title;
  final String description;
  final String imageUrl;
  final Color bgColor;
  final Color textColor;
  final String? dataKey;

  OnBoardingPageModel(
      {required this.title,
      required this.description,
      required this.imageUrl,
      this.dataKey,
      this.bgColor = Colors.white,
      this.textColor = Colors.black87});
}
