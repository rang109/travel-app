import 'package:flutter/material.dart';
// import 'package:flutter/gestures.dart';

import 'package:travel_app/config/colors.dart';
import 'package:travel_app/config/text_styles.dart';

import 'package:travel_app/pages/auth/reset_pass_verification_page.dart';

import 'package:travel_app/widgets/auth/forgot_pass_form.dart';
import 'package:travel_app/widgets/generic/generator/create_snackbar.dart';

import 'package:travel_app/services/auth/send_otp.dart';

// ForgotPass Widget
class ForgotPassPage extends StatefulWidget {
  const ForgotPassPage({super.key});

  @override
  State<ForgotPassPage> createState() => _ForgotPassPageState();
}

class _ForgotPassPageState extends State<ForgotPassPage> {
  static const List<String> forgotPassFormField = [
    'email',
  ];

  final Map<String, String> forgotPassFormValue = <String, String>{
    for (var key in forgotPassFormField) key: ''
  };

  Image? bg;

  String? error;

  @override
  void initState() {
    super.initState();
    bg = Image.asset('assets/img/auth-bg-1.png');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(bg!.image, context);
  }

  void handleSendCode() async {
    // send sendOtp request to server
    String? errorBuffer = await sendOtp(forgotPassFormValue['email'] ?? '');
    setState(() =>
      error = errorBuffer
     );

    if (error != null) {
      SnackBar snackBar = createSnackBar(message: error);

      if (!mounted) return;
      
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      return;
    }

    if (!mounted) return;

    // redirect to ResetPassVerifyEmailPage
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ResetPassVerifyEmailPage(
              emailAddress: forgotPassFormValue['email'] ?? '',
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: bg!.image,
          fit: BoxFit.cover,
        )),
        child: Center(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 30.0),
                  Text(
                    'Forgot Password?',
                    style: AppTextStyles.heading_2.copyWith(
                      color: AppColors.tomato,
                    ),
                  ),
                  Text('Please enter your registered email.',
                      style: AppTextStyles.label_1.copyWith(
                        color: AppColors.tomato,
                      )),
                  SizedBox(height: 50.0),
                  ForgotPassForm(
                    onSubmit: handleSendCode,
                    formFields: forgotPassFormField,
                    formValues: forgotPassFormValue,
                    onFieldChanged: (key, value) =>
                        setState(() => forgotPassFormValue[key] = value),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
