import 'package:flutter/material.dart';

import 'package:client/config/colors.dart';
import 'package:client/config/text_styles.dart';

// AUTH TEXT FIELD WIDGET
class AuthTextField extends StatefulWidget {
  final String? labelText;
  final bool? isProtected;
  final Function(String)? onChanged;

  const AuthTextField({
    super.key,
    this.labelText,
    this.isProtected,
    this.onChanged,
  });

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  final TextEditingController _controller = TextEditingController();
  bool _isVisible = false;

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

  // get textfield value
  String getValue() {
    return _controller.text;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: _isVisible,
      controller: _controller,
      cursorColor: AppColors.TOMATO,
      style: AppTextStyles.LABEL_2.copyWith(
        color: AppColors.TOMATO,
      ),
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
        labelText: widget.labelText ?? 'Enter text',
        labelStyle: AppTextStyles.LABEL_2.copyWith(
          color: AppColors.TOMATO,
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
    );
  }
}