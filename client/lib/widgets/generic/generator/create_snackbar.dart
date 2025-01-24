import 'package:flutter/material.dart';

import 'package:client/config/colors.dart';

SnackBar createSnackBar({ message = 'An unexpected error has occurred.' }) {
  return SnackBar(
    content: Text(
      message,
    ),
    backgroundColor: AppColors.scarlet,
    duration: Duration(seconds: 3),
  );
}