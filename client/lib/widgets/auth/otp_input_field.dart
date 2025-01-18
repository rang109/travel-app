import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:pinput/pinput.dart';

import 'package:client/config/colors.dart';
import 'package:client/config/text_styles.dart';

class OtpInputField extends StatefulWidget {
  final Function(String)? onChanged;
  
  const OtpInputField({
    super.key,
    this.onChanged,
  });

  @override
  State<OtpInputField> createState() => _OtpInputFieldState();
}

class _OtpInputFieldState extends State<OtpInputField> {
  @override
  Widget build(BuildContext context) {
    return Pinput(
      length: 6,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      onChanged: widget.onChanged,
      keyboardType: TextInputType.text,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9]")),
      ],
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