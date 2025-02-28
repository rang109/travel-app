import 'package:flutter/material.dart';

import 'package:travel_app/widgets/auth/auth_text_field.dart';
import 'package:travel_app/widgets/generic/box_button.dart';

import 'package:travel_app/utils/validators/email_validator.dart';

class ForgotPassForm extends StatefulWidget {
  final VoidCallback onSubmit;
  final List<String> formFields;
  final Map<String, String> formValues;
  final Function(String key, String value) onFieldChanged;

  const ForgotPassForm({
    super.key,
    required this.onSubmit,
    required this.formFields,
    required this.formValues,
    required this.onFieldChanged,
  });

  @override
  State<ForgotPassForm> createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {
  final _formKey = GlobalKey<FormState>();

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
            labelText: 'Enter registered email',
            onChanged: (value) => widget.onFieldChanged('email', value),
            validator: emailAddressValidator,
            keyboardType: TextInputType.emailAddress,
          ),

          // SEND CODE BUTTON
          SizedBox(height: 18.0),
          SizedBox(
              width: double.infinity,
              child: BoxButton(
                onPressed: handleSubmit,
                buttonLabel: 'Send Code',
                disabled: (widget.formFields
                    .any((key) => widget.formValues[key] == '')),
              )),
        ],
      ),
    );
  }
}
