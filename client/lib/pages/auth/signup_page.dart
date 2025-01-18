import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:client/config/colors.dart';
import 'package:client/config/text_styles.dart';

import 'package:client/pages/auth/login_page.dart';
import 'package:client/pages/auth/verify_email_page.dart';

import 'package:client/widgets/auth/auth_text_field.dart';
import 'package:client/widgets/general/box_button.dart';

// Signup Page Widget
class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  static const List<String> signupFormFields = [
    'firstName',
    'lastName',
    'emailAddress',
    'username',
    'password',
    'confirmPassword',
  ];
  
  final Map<String, String> signupFormValues = 
    <String, String>{for (var key in signupFormFields) key: ''};

  void handleSignup() {
    debugPrint('First Name: ${signupFormValues['firstName']}');
    debugPrint('Last Name: ${signupFormValues['lastName']}');
    debugPrint('Email Address: ${signupFormValues['emailAddress']}');
    debugPrint('Username: ${signupFormValues['username']}');
    debugPrint('Password: ${signupFormValues['password']}');
    debugPrint('Confirm Password: ${signupFormValues['confirmPassword']}');

    // redirect to VerifyEmailPage
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => VerifyEmailPage(
          emailAddress: signupFormValues['emailAddress'] ?? '',
        )
      )
    );
  }

  // redirect to LoginPage
  void handleToLoginPage() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const LoginPage()
      )
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.WHITE,
      body: SafeArea(
        top: false,
        child: Stack(
          children: <Widget>[
            SvgPicture.asset('assets/svg/sky.svg'),
            Center(
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
                              setState(() => signupFormValues['firstName'] = value)
                          ),
                        ),
                        SizedBox(width: 12.0),
                        Expanded(
                          child: AuthTextField(
                            labelText: 'Enter Last Name',
                            onChanged: (value) => 
                              setState(() => signupFormValues['lastName'] = value)
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.0),
                    AuthTextField(
                      labelText: 'Enter Email Address',
                      onChanged: (value) => 
                        setState(() => signupFormValues['emailAddress'] = value)
                    ),
                    SizedBox(height: 12.0),
                    AuthTextField(
                      labelText: 'Enter Username',
                      onChanged: (value) => 
                        setState(() => signupFormValues['username'] = value)
                    ),
                    SizedBox(height: 12.0),
                    AuthTextField(
                      labelText: 'Enter Password',
                      isProtected: true,
                      onChanged: (value) => 
                        setState(() => signupFormValues['password'] = value)
                    ),
                    SizedBox(height: 12.0),
                    AuthTextField(
                      labelText: 'Confirm Password',
                      isProtected: true,
                      onChanged: (value) => 
                        setState(() => signupFormValues['confirmPassword'] = value)
                    ),
                    SizedBox(height: 18.0),
                    SizedBox(
                      width: double.infinity,
                      child: BoxButton(
                        onPressed: handleSignup,
                        buttonLabel: 'Signup',
                        disabled: (
                          signupFormFields.any(
                            (key) => signupFormValues[key] == ''
                          )
                        ),
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
                                handleToLoginPage();
                              }
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}