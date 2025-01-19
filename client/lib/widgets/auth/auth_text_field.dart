import 'package:flutter/material.dart';

import 'package:client/config/colors.dart';
import 'package:client/config/text_styles.dart';

// AUTH TEXT FIELD WIDGET
class AuthTextField extends StatefulWidget {
  final String? labelText;
  final bool? isProtected;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;

  const AuthTextField({
    super.key,
    this.labelText,
    this.isProtected,
    this.onChanged,
    this.validator,
    this.keyboardType,
  });

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  final TextEditingController _controller = TextEditingController();
  bool _isVisible = false;
  bool _error = false;

  @override
  void initState() {
    super.initState();
    _isVisible = widget.isProtected ?? false;
    _controller.addListener(() {
      final String text = _controller.text;
      _controller.value = _controller.value.copyWith(
        text: text,
        selection: TextSelection(
          baseOffset: text.length,
          extentOffset: text.length,
        ),
        composing: TextRange.empty,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _isVisible = widget.isProtected ?? false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _isVisible,
      controller: _controller,
      cursorColor: AppColors.TOMATO,
      style: AppTextStyles.LABEL_2.copyWith(
        color: AppColors.TOMATO,
      ),
      keyboardType: widget.keyboardType,
      onChanged: widget.onChanged,
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
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.TOMATO,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.SCARLET,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.SCARLET,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        errorStyle: AppTextStyles.LABEL_3.copyWith(
          color: AppColors.SCARLET,
        ),
        errorMaxLines: 2,
        labelText: widget.labelText ?? 'Enter text',
        labelStyle: AppTextStyles.LABEL_2.copyWith(
          color: AppColors.TOMATO,
        ),
        floatingLabelStyle: TextStyle(
          color: (_error) ?
            AppColors.SCARLET :
            AppColors.TOMATO,
        ),
        suffixIcon: (widget.isProtected ?? false) ? IconButton(
          icon: Icon(_isVisible ? 
            Icons.visibility : 
            Icons.visibility_off
          ),
          color: AppColors.TOMATO,
          onPressed: () {
            setState(() {
              _isVisible = !_isVisible;
            });
          },
        ) : null,
      ),
      validator: (value) {
        String? errorMessage = widget.validator?.call(value);
        setState(() => 
          _error = errorMessage != null
        );
        return errorMessage;
      },
    );
  }
}