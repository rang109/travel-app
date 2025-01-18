import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:client/config/colors.dart';
import 'package:client/config/text_styles.dart';

import 'package:client/pages/auth/login_page.dart';
import 'package:client/pages/auth/verify_email_page.dart';

import 'package:client/widgets/auth/signup_form.dart';

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
    debugPrint('$signupFormValues');

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
                    SignupForm(
                      onSubmit: handleSignup,
                      formFields: signupFormFields,
                      formValues: signupFormValues,
                      onFieldChanged: (key, value) =>
                        setState(() => signupFormValues[key] = value),
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