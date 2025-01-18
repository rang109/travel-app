import 'package:flutter/material.dart';

import 'package:pinput/pinput.dart';

import 'package:client/config/colors.dart';
import 'package:client/config/text_styles.dart';

class OtpInputField extends StatefulWidget {
  const OtpInputField({super.key});

  @override
  State<OtpInputField> createState() => _OtpInputFieldState();
}

class _OtpInputFieldState extends State<OtpInputField> {
  @override
  Widget build(BuildContext context) {
    return Pinput(
      length: 6,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      defaultPinTheme: PinTheme(
        width: 46.0,
        height: 54.0,
        textStyle: AppTextStyles.LABEL_2_1.copyWith(
          color: AppColors.TOMATO,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.TOMATO,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}