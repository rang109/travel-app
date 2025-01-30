import 'dart:async';

import 'package:flutter/material.dart';

import 'package:travel_app/config/colors.dart';
import 'package:travel_app/config/text_styles.dart';

import 'package:travel_app/widgets/generic/box_button.dart';
import 'package:travel_app/widgets/auth/otp_input_field.dart';
import 'package:travel_app/widgets/generic/generator/create_snackbar.dart';

import 'package:travel_app/services/auth/verify_email.dart';
import 'package:travel_app/services/auth/send_otp.dart';

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

    // navigate to next page
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
                      'Verify email',
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
