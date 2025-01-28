import 'package:flutter/material.dart';
import 'package:is_valid/is_valid.dart';

import 'package:travel_app/widgets/auth/auth_text_field.dart';
import 'package:travel_app/widgets/generic/box_button.dart';

class LoginForm extends StatefulWidget {
  final VoidCallback onSubmit;
  final List<String> formFields;
  final Map<String, String> formValues;
  final Function(String key, String value) onFieldChanged;

  const LoginForm({
    super.key,
    required this.onSubmit,
    required this.formFields,
    required this.formValues,
    required this.onFieldChanged,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  String? emailAddressValidator(String? emailAddress) {
    return (IsValid.validateEmail(emailAddress ?? '')) ?
      null :
      'Please enter a valid email address';
  }

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
    } else if (!RegExp(r'[0-9!@#\$%^&*(),.?":{}|<>_\-+=/\[\]\\]').hasMatch(password)) {
      return 'Your password should contain at least one number and one special character.';
    } else if (!RegExp(r'[!@#\$%^&*(),.?":{}|<>_\-+=/\[\]\\]').hasMatch(password)) {
      return 'Your password should contain at least one special character.';
    } else if (!RegExp(r'[0-9]').hasMatch(password)) {
      return 'Your password should contain at least one number.';
    } else if (IsValid.validatePassword(password, passwordValidationOptions)) {
      return null;
    } else {
      return 'An unexpected error occurred. Please try again.';
    }
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
            labelText: 'Enter Email Address',
            onChanged: (value) => widget.onFieldChanged('email', value),
            validator: emailAddressValidator,
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 12.0),
          AuthTextField(
            labelText: 'Enter Password',
            isProtected: true,
            onChanged: (value) => widget.onFieldChanged('password', value),
            validator: passwordValidator,
            keyboardType: TextInputType.visiblePassword,
          ),

          // LOGIN BUTTON
          SizedBox(height: 18.0),
          SizedBox(
              width: double.infinity,
              child: BoxButton(
                onPressed: handleSubmit,
                buttonLabel: 'Login',
                disabled: (widget.formFields
                    .any((key) => widget.formValues[key] == '')),
              )),
        ],
      ),
    );
  }
}
