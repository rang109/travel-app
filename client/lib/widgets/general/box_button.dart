import 'package:flutter/material.dart';

import 'package:client/config/colors.dart';
import 'package:client/config/text_styles.dart';

class BoxButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String? buttonLabel;
  final bool? outlined;
  final bool? disabled;
  
  const BoxButton({
    super.key,
    required this.onPressed,
    this.buttonLabel,
    this.outlined,
    this.disabled,
  });

  @override
  State<BoxButton> createState() => _BoxButtonState();
}

class _BoxButtonState extends State<BoxButton> {  
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: (widget.disabled ?? false) ? 
        null :
        widget.onPressed,
      style: (widget.outlined ?? false) ? 
        OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(
              color: (widget.disabled ?? false) ?
              AppColors.LIGHT_SALMON :
              AppColors.TOMATO,
            )
          ),
        ) :
        TextButton.styleFrom(
          backgroundColor: (widget.disabled ?? false) ?
          AppColors.LIGHT_SALMON :
          AppColors.TOMATO,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Text(
          widget.buttonLabel ?? 'Button',
          style: AppTextStyles.LABEL_1.copyWith(
            color: (widget.outlined ?? false) ?
            ((widget.disabled ?? false) ? 
              AppColors.LIGHT_SALMON : 
              AppColors.TOMATO) :
            AppColors.WHITE,
          ),
        ),
      );
  }
}