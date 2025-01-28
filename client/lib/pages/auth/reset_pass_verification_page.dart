import 'dart:async';

import 'package:flutter/material.dart';

import 'package:travel_app/config/colors.dart';
import 'package:travel_app/config/text_styles.dart';

import 'package:travel_app/widgets/generic/box_button.dart';
import 'package:travel_app/widgets/auth/otp_input_field.dart';
import 'package:travel_app/widgets/generic/generator/create_snackbar.dart';

import 'package:travel_app/pages/auth/reset_pass_page.dart';

import 'package:travel_app/services/auth/send_otp.dart';
import 'package:travel_app/services/auth/verify_email.dart';

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

    bg = Image.asset('assets/img/auth-bg-1.png');
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

  void handleVerifyEmail() async {
    if (otp.length != 6) return;

    // send verifyEmail request to server
    String? errorBuffer = await verifyEmail(otp, widget.emailAddress);
    setState(() {
      error = errorBuffer;
      isIncorrectOTP = error != null;
    });

    if (error != null) {
      SnackBar snackBar = createSnackBar(message: error);

      if (!mounted) return;
      
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      return;
    }

    if (!mounted) return;

    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => ResetPassPage(
          emailAddress: widget.emailAddress,
        )));
  }

  void handleResendEmail() async {
    // send sendOtp request to server
    String? errorBuffer = await sendOtp(widget.emailAddress);
    setState(() =>
      error = errorBuffer
     );

    if (error != null) {
      SnackBar snackBar = createSnackBar(message: error);

      if (!mounted) return;
      
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      return;
    }

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
                      style: AppTextStyles.heading_2.copyWith(
                        color: AppColors.tomato,
                      ),
                    ),
                    Text(
                      'We sent a code to $censoredEmail.',
                      style: AppTextStyles.label_1.copyWith(
                        color: AppColors.tomato,
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 24.0),
                        child: OtpInputField(
                          onChanged: (value) => setState(() => otp = value),
                          error: isIncorrectOTP,
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
