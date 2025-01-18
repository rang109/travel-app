import 'package:flutter/material.dart';

import 'package:client/config/colors.dart';
import 'package:client/config/text_styles.dart';

import 'package:client/widgets/general/box_button.dart';
import 'package:client/widgets/auth/otp_input_field.dart';

// Verify Email Page Widget

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  String censoredEmail = 'he***@gmail.com';
  String timeLeft = '00:00';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Verify email',
              style: AppTextStyles.HEADING_2.copyWith(
                color: AppColors.TOMATO,
              ),
            ),
            Text(
              'We sent a code to $censoredEmail.',
              style: AppTextStyles.LABEL_1.copyWith(
                color: AppColors.TOMATO,
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 24.0),
                child: OtpInputField(),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      width: double.infinity,
                      child: BoxButton(
                        onPressed: () {},
                        buttonLabel: 'Submit',
                      ),
                    ),
                    SizedBox(height: 2.0),
                    SizedBox(
                      width: double.infinity,
                      child: BoxButton(
                        onPressed: () {},
                        buttonLabel: 'Resend' ' in $timeLeft',
                        outlined: true,
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