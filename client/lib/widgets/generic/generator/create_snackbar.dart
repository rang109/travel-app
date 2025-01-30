import 'package:flutter/material.dart';

import 'package:travel_app/config/colors.dart';
import 'package:travel_app/config/text_styles.dart';

SnackBar createSnackBar({ message = 'An unexpected error has occurred.' }) {
  return SnackBar(
    content: Text(
      message,
      style: AppTextStyles.label_2_1.copyWith(
        color: AppColors.white,
      ),
      textAlign: TextAlign.center,
    ),
    backgroundColor: AppColors.scarlet,
    duration: Duration(seconds: 5),
  );
}