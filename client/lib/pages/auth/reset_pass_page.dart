import 'package:flutter/material.dart';
// import 'package:flutter/gestures.dart';

import 'package:client/config/colors.dart';
import 'package:client/config/text_styles.dart';

import 'package:client/pages/auth/login_page.dart';

import 'package:client/widgets/auth/reset_pass_form.dart';
import 'package:client/widgets/generic/generator/create_snackbar.dart';

import 'package:client/services/auth/reset_password.dart';

// Reset Password Page Widget
class ResetPassPage extends StatefulWidget {
  const ResetPassPage({super.key});

  @override
  State<ResetPassPage> createState() => _ResetPassPageState();
}

class _ResetPassPageState extends State<ResetPassPage> {
  static const List<String> resetPassFormFields = [
    'password',
  ];

  final Map<String, String> resetPassFormValues = <String, String>{
    for (var key in resetPassFormFields) key: ''
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

  void handleResetPasswordPage() {
    debugPrint('$resetPassFormValues');

    // uncomment when ready
    // setState(() async =>
    //   error = await resetPassword(resetPassFormValues['password']!)
    // );

    if (error != null) {
      SnackBar snackBar = createSnackBar(message: error!);

      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      return;
    }


    // redirect to login page
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => LoginPage()));
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
                  SizedBox(height: 80.0),
                  Text('Reset Password',
                      style: AppTextStyles.heading_2.copyWith(
                        color: AppColors.tomato,
                      )),
                  Text('Create new password.',
                      style: AppTextStyles.label_1.copyWith(
                        color: AppColors.tomato,
                      )),
                  SizedBox(height: 50.0),
                  ResetPassFrom(
                    onSubmit: handleResetPasswordPage,
                    formFields: resetPassFormFields,
                    formValues: resetPassFormValues,
                    onFieldChanged: (key, value) =>
                        setState(() => resetPassFormValues[key] = value),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
