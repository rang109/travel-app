import 'package:flutter/material.dart';

import 'package:travel_app/config/colors.dart';
import 'package:travel_app/config/text_styles.dart';

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
              AppColors.lightSalmon :
              AppColors.tomato,
            )
          ),
        ) :
        TextButton.styleFrom(
          backgroundColor: (widget.disabled ?? false) ?
          AppColors.lightSalmon :
          AppColors.tomato,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Text(
          widget.buttonLabel ?? 'Button',
          style: AppTextStyles.label_1.copyWith(
            color: (widget.outlined ?? false) ?
            ((widget.disabled ?? false) ? 
              AppColors.lightSalmon : 
              AppColors.tomato) :
            AppColors.white,
          ),
        ),
      );
  }
}