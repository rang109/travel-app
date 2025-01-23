import 'package:flutter/material.dart';
import 'package:is_valid/is_valid.dart';

import 'package:client/widgets/auth/auth_text_field.dart';
import 'package:client/widgets/generic/box_button.dart';

class ResetPassFrom extends StatefulWidget {
  final VoidCallback onSubmit;
  final List<String> formFields;
  final Map<String, String> formValues;
  final Function(String key, String value) onFieldChanged;

  const ResetPassFrom({
    super.key,
    required this.onSubmit,
    required this.formFields,
    required this.formValues,
    required this.onFieldChanged,
  });

  @override
  State<ResetPassFrom> createState() => _ResetPassFormState();
}

class _ResetPassFormState extends State<ResetPassFrom> {
  final _formKey = GlobalKey<FormState>();

  String? passwordValidator(String? password) {
    Map<PasswordValidation, dynamic> passwordValidationOptions = {
      PasswordValidation.minLength: 8,
      PasswordValidation.disallowLetters: false,
      PasswordValidation.disallowNumbers: false,
      PasswordValidation.disallowSpecialChars: false,
    };

    if (password == null) {
      return 'Password is empty.';
    } else if (password.length < 8) {
      return 'Your password is too short.';
    } else if (!RegExp(r'[0-9!@#\$%^&*(),.?":{}|<>_\-+=/\[\]\\]')
        .hasMatch(password)) {
      return 'Your password should contain at least one number and one special character.';
    } else if (!RegExp(r'[!@#\$%^&*(),.?":{}|<>_\-+=/\[\]\\]')
        .hasMatch(password)) {
      return 'Your password should contain at least one special character.';
    } else if (!RegExp(r'[0-9]').hasMatch(password)) {
      return 'Your password should contain at least one number.';
    } else if (IsValid.validatePassword(password, passwordValidationOptions)) {
      return null;
    } else {
      return 'An unexpected error occurred. Please try again.';
    }
  }

  String? confirmPasswordValidator(String? confirmPassword) {
    if (confirmPassword != widget.formValues['password']) {
      return 'Passwords does not match.';
    }

    return null;
  }

  void handleSubmit() {
    if (_formKey.currentState!.validate()) {
      widget.onSubmit();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 12.0),
          AuthTextField(
            labelText: 'Enter New Password',
            isProtected: true,
            onChanged: (value) => widget.onFieldChanged('password', value),
            validator: passwordValidator,
            keyboardType: TextInputType.visiblePassword,
          ),
          SizedBox(height: 12.0),
          AuthTextField(
            labelText: 'Confirm New Password',
            isProtected: true,
            validator: confirmPasswordValidator,
            keyboardType: TextInputType.visiblePassword,
          ),

          // RESET PASSWORD BUTTON
          SizedBox(height: 18.0),
          SizedBox(
              width: double.infinity,
              child: BoxButton(
                onPressed: handleSubmit,
                buttonLabel: 'Reset Password',
                disabled: (widget.formFields
                    .any((key) => widget.formValues[key] == '')),
              )),
        ],
      ),
    );
  }
}
