import 'package:flutter/material.dart';

import 'package:client/config/colors.dart';
import 'package:client/config/text_styles.dart';

// AUTH TEXT FIELD WIDGET
class AuthTextField extends StatelessWidget {
  final String? hintText;
  
  const AuthTextField({
    super.key,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.TOMATO,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        hintText: hintText ?? 'Enter text',
        hintStyle: AppTextStyles.LABEL_2.copyWith(
          color: AppColors.TOMATO,
        ),
      ),
    );
  }
}