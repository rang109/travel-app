import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'package:client/config/colors.dart';
import 'package:client/config/text_styles.dart';

import 'package:client/widgets/auth/auth_text_field.dart';
import 'package:client/widgets/general/box_button.dart';

// Signup Page Widget
class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final Map<String, String> signupFormValues = {};

  void handleSignup() {
    debugPrint('First Name: ${signupFormValues['firstName']}');
    debugPrint('Last Name: ${signupFormValues['lastName']}');
    debugPrint('Email Address: ${signupFormValues['emailAddress']}');
    debugPrint('Username: ${signupFormValues['username']}');
    debugPrint('Password: ${signupFormValues['password']}');
    debugPrint('Confirm Password: ${signupFormValues['confirmPassword']}');
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: AuthTextField(
                      labelText: 'Enter First Name',
                      onChanged: (value) => 
                        signupFormValues['firstName'] = value
                    ),
                  ),
                  SizedBox(width: 12.0),
                  Expanded(
                    child: AuthTextField(
                      labelText: 'Enter Last Name',
                      onChanged: (value) => 
                        signupFormValues['lastName'] = value
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.0),
              AuthTextField(
                labelText: 'Enter Email Address',
                onChanged: (value) => 
                  signupFormValues['emailAddress'] = value
              ),
              SizedBox(height: 12.0),
              AuthTextField(
                labelText: 'Enter Username',
                onChanged: (value) => 
                  signupFormValues['username'] = value
              ),
              SizedBox(height: 12.0),
              AuthTextField(
                labelText: 'Enter Password',
                isProtected: true,
                onChanged: (value) => 
                  signupFormValues['password'] = value
              ),
              SizedBox(height: 12.0),
              AuthTextField(
                labelText: 'Confirm Password',
                isProtected: true,
                onChanged: (value) => 
                  signupFormValues['confirmPassword'] = value
              ),
              SizedBox(height: 18.0),
              SizedBox(
                width: double.infinity,
                child: BoxButton(
                  onPressed: handleSignup,
                  buttonLabel: 'Signup',
                ),
              ),
              SizedBox(height: 10.0),
              RichText(
                text: TextSpan(
                  style: AppTextStyles.LABEL_2.copyWith(
                    color: AppColors.TOMATO,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Already have an account?  '
                    ),
                    TextSpan(
                      style: AppTextStyles.LABEL_2_1.copyWith(
                        color: AppColors.TOMATO,
                      ),
                      text: 'Log in',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          debugPrint('Navigate to Login Page');
                        }
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}