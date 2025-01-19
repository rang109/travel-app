import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:pinput/pinput.dart';

import 'package:client/config/colors.dart';
import 'package:client/config/text_styles.dart';

class OtpInputField extends StatefulWidget {
  final Function(String)? onChanged;
  final bool? error;
  final String? errorMessage;
  
  const OtpInputField({
    super.key,
    this.onChanged,
    this.error,
    this.errorMessage,
  });

  @override
  State<OtpInputField> createState() => _OtpInputFieldState();
}

class _OtpInputFieldState extends State<OtpInputField> {
  final TextEditingController _controller = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Pinput(
          length: 6,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          onChanged: widget.onChanged,
          keyboardType: TextInputType.visiblePassword,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9]")),
          ],
          controller: _controller,
          defaultPinTheme: (!(widget.error ?? false)) ?
            PinTheme(
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
            ) :
            PinTheme(
              width: 46.0,
              height: 54.0,
              textStyle: AppTextStyles.LABEL_2_1.copyWith(
                color: AppColors.TOMATO,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.SCARLET,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
        ),
        if (widget.error ?? false)
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 0.0),
            child: Text(
              widget.errorMessage ?? 'An unexpected error has occurred',
              style: AppTextStyles.LABEL_2.copyWith(
                color: AppColors.SCARLET,
              ),
            ),
          ),
      ],
    );
  }
}