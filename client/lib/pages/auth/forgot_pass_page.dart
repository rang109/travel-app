import 'package:flutter/material.dart';
// import 'package:flutter/gestures.dart';

import 'package:client/config/colors.dart';
import 'package:client/config/text_styles.dart';

import 'package:client/pages/auth/reset_pass_verification_page.dart';

import 'package:client/widgets/auth/forgot_pass_form.dart';

// ForgotPass Widget
class ForgotPassPage extends StatefulWidget {
  const ForgotPassPage({super.key});

  @override
  State<ForgotPassPage> createState() => _ForgotPassPageState();
}

class _ForgotPassPageState extends State<ForgotPassPage> {
  static const List<String> forgotPassFormField = [
    'emailAddress',
  ];

  final Map<String, String> forgotPassFormValue = <String, String>{
    for (var key in forgotPassFormField) key: ''
  };

  Image? bg;

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

  void handleSendCode() {
    debugPrint('$forgotPassFormValue');

    // redirect to VerifyEmailPage
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ResetPassVerifyEmailPage(
              emailAddress: forgotPassFormValue['emailAddress'] ?? '',
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
                    style: AppTextStyles.HEADING_2.copyWith(
                      color: AppColors.tomato,
                    ),
                  ),
                  Text('Please enter your registered email.',
                      style: AppTextStyles.LABEL_1.copyWith(
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
