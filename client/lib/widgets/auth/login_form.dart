import 'package:flutter/material.dart';
// import 'package:is_valid/is_valid.dart';

import 'package:client/widgets/auth/auth_text_field.dart';
import 'package:client/widgets/generic/box_button.dart';

class LoginForm extends StatefulWidget {
  final VoidCallback onSubmit;
  final List<String> formFields;
  final Map<String, String> formValues;
  final Function(String key, String value) onFieldCahnged;

  const LoginForm({
    super.key,
    required this.onSubmit,
    required this.formFields,
    required this.formValues,
    required this.onFieldCahnged,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
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
            labelText: 'Enter Username',
            onChanged: (value) => widget.onFieldCahnged('username', value),
            // validator: ,
            keyboardType: TextInputType.name,
          ),
          SizedBox(height: 12.0),
          AuthTextField(
            labelText: 'Enter Password',
            isProtected: true,
            onChanged: (value) => widget.onFieldCahnged('password', value),
            // validator: ,
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
