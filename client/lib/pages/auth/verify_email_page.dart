import 'dart:async';

import 'package:flutter/material.dart';

import 'package:client/config/colors.dart';
import 'package:client/config/text_styles.dart';

import 'package:client/widgets/generic/box_button.dart';
import 'package:client/widgets/auth/otp_input_field.dart';

// Verify Email Page Widget

class VerifyEmailPage extends StatefulWidget {
  final String emailAddress;
  
  const VerifyEmailPage({
    super.key,
    required this.emailAddress,
  });

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  String? otp;
  bool isIncorrectOTP = false;
  String? errorMessage;

  String? censoredEmail;

  String timeLeft = '00:00';
  bool isTimerActive = false;
  Timer? resendTimer;

  @override
  void initState() {
    super.initState();

    if (widget.emailAddress == '') return;

    List<String>? parsedEmail = widget.emailAddress.split('@');
    if (parsedEmail[0].length <= 2) {
      censoredEmail = widget.emailAddress.replaceRange(0, parsedEmail[0].length, '*' * 4);
    } else {
      censoredEmail = widget.emailAddress.replaceRange(2, parsedEmail[0].length, '*' * 4);
    }
  }

  @override
  void dispose() {
    resendTimer?.cancel();
    super.dispose();
  }

  void handleVerifyEmail() {
    // send otp to server
    debugPrint('OTP: $otp');

    // receive response
    setState(() => isIncorrectOTP = !(otp == 'qwerty')); // temporary
    
    // update error message
    setState(() =>
      errorMessage = (isIncorrectOTP) ?
        'Incorrect OTP.' :
        null
    );
  }

  void handleResendEmail() {
    debugPrint('Resend email');
    startResendTimer();
  }

  void startResendTimer() {
    setState(() {
      isTimerActive = true;
      timeLeft = '02:00';
    });

    Duration timerDuration = Duration(minutes: 2);
    resendTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      final remainingSeconds = timerDuration.inSeconds - timer.tick;
      if (remainingSeconds <= 0) {
        timer.cancel();
        setState(() {
          isTimerActive = false;
          timeLeft = '00:00';
        });
      } else {
        final minutes = (remainingSeconds ~/ 60).toString().padLeft(2, '0');
        final seconds = (remainingSeconds % 60).toString().padLeft(2, '0');
        setState(() {
          timeLeft = '$minutes:$seconds';
        });
      }
    });
  }

  final _formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: _formKey,
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
                  child: OtpInputField(
                    onChanged: (value) =>
                      setState(() => otp = value),
                    error: isIncorrectOTP,
                    errorMessage: errorMessage,
                  ),
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
                          onPressed: handleVerifyEmail,
                          buttonLabel: 'Submit',
                          disabled: !(otp?.length == 6),
                        ),
                      ),
                      SizedBox(height: 2.0),
                      SizedBox(
                        width: double.infinity,
                        child: BoxButton(
                          onPressed: handleResendEmail,
                          buttonLabel: isTimerActive ?
                            'Resend in $timeLeft' :
                            'Resend',
                          outlined: true,
                          disabled: isTimerActive,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}