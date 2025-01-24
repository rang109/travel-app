import 'dart:async';

import 'package:flutter/material.dart';

import 'package:client/config/colors.dart';
import 'package:client/config/text_styles.dart';

import 'package:client/widgets/generic/box_button.dart';
import 'package:client/widgets/auth/otp_input_field.dart';

import 'package:client/pages/auth/reset_pass_page.dart';

import 'package:client/services/auth/send_otp.dart';

// Reset Password - Verify Email Page Widget

class ResetPassVerifyEmailPage extends StatefulWidget {
  final String emailAddress;

  const ResetPassVerifyEmailPage({
    super.key,
    required this.emailAddress,
  });

  @override
  State<ResetPassVerifyEmailPage> createState() =>
      _ResetPassVerifyEmailPageState();
}

class _ResetPassVerifyEmailPageState extends State<ResetPassVerifyEmailPage> {
  String otp = '';
  bool isIncorrectOTP = false;
  String? errorMessage;

  String? censoredEmail;

  String timeLeft = '00:00';
  bool isTimerActive = false;
  Timer? resendTimer;

  Image? bg;

  String? error;

  @override
  void initState() {
    super.initState();

    if (widget.emailAddress == '') return;

    List<String>? parsedEmail = widget.emailAddress.split('@');
    if (parsedEmail[0].length <= 2) {
      censoredEmail =
          widget.emailAddress.replaceRange(0, parsedEmail[0].length, '*' * 4);
    } else {
      censoredEmail =
          widget.emailAddress.replaceRange(2, parsedEmail[0].length, '*' * 4);
    }

    bg = Image.asset('assets/img/auth-bg-2.png');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(bg!.image, context);
  }

  @override
  void dispose() {
    resendTimer?.cancel();
    super.dispose();
  }

  void handleVerifyEmail() {
    if (otp.length != 6) return;

    // send otp to server
    debugPrint('OTP: $otp');
    // verifyEmail(otp); // uncomment if ready

    // receive response
    setState(() => isIncorrectOTP = !(otp == 'qwerty')); // temporary

    // update error message
    setState(() => errorMessage = (isIncorrectOTP) ? 'Incorrect OTP.' : null);

    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const ResetPassPage()));
  }

  void handleResendEmail() {
    debugPrint('Resend email');

    // TODO: add snackbar for error
    // setState(() async =>
    //   error = await sendOtp(widget.emailAddress)
    // ); // uncomment when ready

    if (error == null) return;

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
      backgroundColor: AppColors.white,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: bg!.image,
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Check you mail!',
                      style: AppTextStyles.HEADING_2.copyWith(
                        color: AppColors.tomato,
                      ),
                    ),
                    Text(
                      'We sent a code to $censoredEmail.',
                      style: AppTextStyles.LABEL_1.copyWith(
                        color: AppColors.tomato,
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 24.0),
                        child: OtpInputField(
                          onChanged: (value) => setState(() => otp = value),
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
                                disabled: !(otp.length == 6),
                              ),
                            ),
                            SizedBox(height: 2.0),
                            SizedBox(
                              width: double.infinity,
                              child: BoxButton(
                                onPressed: handleResendEmail,
                                buttonLabel: isTimerActive
                                    ? 'Resend in $timeLeft'
                                    : 'Resend',
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
          ],
        ),
      ),
    );
  }
}
