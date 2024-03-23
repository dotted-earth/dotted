import 'package:dotted/features/user/models/preference_item_model.dart';
import 'package:flutter/material.dart';

class OnBoardingPageModel {
  final String title;
  final String description;
  final String imageUrl;
  final Color bgColor;
  final Color textColor;
  final List<PreferenceItemModel> preferences;
  final Set<PreferenceItemModel> selectedPreferences;
  final ValueChanged<PreferenceItemModel> onPreferenceSelected;

  OnBoardingPageModel({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.onPreferenceSelected,
    required this.preferences,
    required this.selectedPreferences,
    this.bgColor = Colors.white,
    this.textColor = Colors.black87,
  });
}
