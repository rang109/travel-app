import 'package:flutter/material.dart';

import 'package:client/config/colors.dart';
import 'package:client/config/text_styles.dart';

import 'package:client/pages/auth/login_page.dart';
import 'package:client/pages/auth/signup_page.dart';

import 'package:client/widgets/generic/box_button.dart';

// Welcome Page Widget
class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  // redirect to LoginPage
  void handleToLoginPage() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  // redirect to SignupPage
  void handleToSignupPage() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const SignupPage()));
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 64.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Welcome!',
                style: AppTextStyles.heading_1.copyWith(
                  color: AppColors.tomato,
                  height: 1.2,
                )
              ),
              Text(
                'Your Adventure Awaits',
                style: AppTextStyles.subtext_1.copyWith(
                  color: AppColors.tomato,
                )
              ),
              SizedBox(height: 64.0),
              SizedBox(
                width: double.infinity,
                child: BoxButton(
                  onPressed: handleToLoginPage,
                  buttonLabel: 'Login',
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: BoxButton(
                  onPressed: handleToSignupPage,
                  buttonLabel: 'Sign up',
                  outlined: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}