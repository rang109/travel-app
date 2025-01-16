import 'package:flutter/material.dart';

import 'package:client/config/colors.dart';
import 'package:client/config/text_styles.dart';

class BoxButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String? buttonLabel;
  
  const BoxButton({
    super.key,
    required this.onPressed,
    this.buttonLabel,
  });

  @override
  State<BoxButton> createState() => _BoxButtonState();
}

class _BoxButtonState extends State<BoxButton> {  
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.onPressed,
      style: TextButton.styleFrom(
        backgroundColor: AppColors.TOMATO,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: Text(
        widget.buttonLabel ?? 'Button',
        style: AppTextStyles.LABEL_1.copyWith(
          color: AppColors.WHITE,
        ),
      ),
    );
  }
}