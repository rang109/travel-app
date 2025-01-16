import 'package:flutter/material.dart';

import 'package:client/config/colors.dart';
import 'package:client/config/text_styles.dart';

import 'package:client/widgets/auth/text_field.dart';
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
                      hintText: 'Enter First Name',
                    ),
                  ),
                  SizedBox(width: 12.0),
                  Expanded(
                    child: AuthTextField(
                      hintText: 'Enter Last Name',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.0),
              AuthTextField(
                hintText: 'Enter Email Address',
              ),
              SizedBox(height: 12.0),
              AuthTextField(
                hintText: 'Enter Username',
              ),
              SizedBox(height: 12.0),
              AuthTextField(
                hintText: 'Enter Password',
              ),
              SizedBox(height: 12.0),
              AuthTextField(
                hintText: 'Confirm Password',
              ),
              SizedBox(height: 18.0),
              SizedBox(
                width: double.infinity,
                child: BoxButton(
                  onPressed: () {},
                  buttonLabel: 'Login',
                ),
              ),
              SizedBox(height: 6.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Already have an account?',
                    style: AppTextStyles.LABEL_1.copyWith(
                      color: AppColors.TOMATO,
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    'Log in',
                    style: AppTextStyles.LABEL_1_1.copyWith(
                      color: AppColors.TOMATO,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}