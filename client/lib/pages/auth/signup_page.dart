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
                    ),
                  ),
                  SizedBox(width: 12.0),
                  Expanded(
                    child: AuthTextField(
                      labelText: 'Enter Last Name',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.0),
              AuthTextField(
                labelText: 'Enter Email Address',
              ),
              SizedBox(height: 12.0),
              AuthTextField(
                labelText: 'Enter Username',
              ),
              SizedBox(height: 12.0),
              AuthTextField(
                labelText: 'Enter Password',
                isProtected: true,
              ),
              SizedBox(height: 12.0),
              AuthTextField(
                labelText: 'Confirm Password',
                isProtected: true,
              ),
              SizedBox(height: 18.0),
              SizedBox(
                width: double.infinity,
                child: BoxButton(
                  onPressed: () {},
                  buttonLabel: 'Signup',
                  disabled: true,
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