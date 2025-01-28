import 'package:flutter/material.dart';

import 'package:travel_app/widgets/auth/auth_text_field.dart';
import 'package:travel_app/widgets/generic/box_button.dart';

import 'package:travel_app/utils/validators/email_validator.dart';
import 'package:travel_app/utils/validators/password_validator.dart';

class SignupForm extends StatefulWidget {
  final VoidCallback onSubmit;
  final List<String> formFields;
  final Map<String, String> formValues;
  final Function(String key, String value) onFieldChanged;
  
  const SignupForm({
    super.key,
    required this.onSubmit,
    required this.formFields,
    required this.formValues,
    required this.onFieldChanged,
  });

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();  

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
          Row(
            children: <Widget>[
              Expanded(
                child: AuthTextField(
                  labelText: 'Enter First Name',
                  onChanged: (value) => 
                    widget.onFieldChanged('firstName', value),
                  keyboardType: TextInputType.name,
                ),
              ),
              SizedBox(width: 12.0),
              Expanded(
                child: AuthTextField(
                  labelText: 'Enter Last Name',
                  onChanged: (value) => 
                    widget.onFieldChanged('lastName', value),
                  keyboardType: TextInputType.name,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.0),
          AuthTextField(
            labelText: 'Enter Email Address',
            onChanged: (value) => 
              widget.onFieldChanged('email', value),
            validator: emailAddressValidator,
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 12.0),
          AuthTextField(
            labelText: 'Enter Username',
            onChanged: (value) => 
              widget.onFieldChanged('username', value),
          ),
          SizedBox(height: 12.0),
          AuthTextField(
            labelText: 'Enter Password',
            isProtected: true,
            onChanged: (value) => 
              widget.onFieldChanged('password', value),
            validator: passwordValidator,
            keyboardType: TextInputType.visiblePassword,
          ),
          SizedBox(height: 12.0),
          AuthTextField(
            labelText: 'Confirm Password',
            isProtected: true,
            onChanged: (value) => 
              widget.onFieldChanged('confirmPassword', value),
            validator: confirmPasswordValidator,
            keyboardType: TextInputType.visiblePassword
          ),
          // SUBMIT BUTTON
          SizedBox(height: 18.0),
          SizedBox(
            width: double.infinity,
            child: BoxButton(
              onPressed: handleSubmit,
              buttonLabel: 'Signup',
              disabled: (
                widget.formFields.any(
                  (key) => widget.formValues[key] == ''
                )
              ),
            ),
          ),
        ],
      ),
    );
  }
}