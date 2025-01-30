import 'package:flutter/material.dart';

import 'package:travel_app/widgets/auth/auth_text_field.dart';
import 'package:travel_app/widgets/generic/box_button.dart';

import 'package:travel_app/utils/validators/password_validator.dart';

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

  String? confirmPasswordValidator(String? confirmPassword) {
    if (confirmPassword != widget.formValues['newPassword']) {
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
            onChanged: (value) => widget.onFieldChanged('newPassword', value),
            validator: passwordValidator,
            keyboardType: TextInputType.visiblePassword,
          ),
          SizedBox(height: 12.0),
          AuthTextField(
            labelText: 'Confirm New Password',
            isProtected: true,
            onChanged: (value) => widget.onFieldChanged('confirmNewPassword', value),
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
