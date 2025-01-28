import 'package:flutter/material.dart';
// import 'package:flutter/gestures.dart';

import 'package:travel_app/config/colors.dart';
import 'package:travel_app/config/text_styles.dart';

import 'package:travel_app/pages/auth/login_page.dart';

import 'package:travel_app/widgets/auth/reset_pass_form.dart';
import 'package:travel_app/widgets/generic/generator/create_snackbar.dart';

import 'package:travel_app/services/auth/reset_password.dart';

// Reset Password Page Widget
class ResetPassPage extends StatefulWidget {
  final String emailAddress;
  
  const ResetPassPage({
    super.key,
    required this.emailAddress,
  });

  @override
  State<ResetPassPage> createState() => _ResetPassPageState();
}

class _ResetPassPageState extends State<ResetPassPage> {
  static const List<String> resetPassFormFields = [
    'newPassword',
    'confirmNewPassword',
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

  void handleResetPasswordPage() async {
    Map<String, String> updatedUserDetails = {
      'email': widget.emailAddress,
      'newPassword': resetPassFormValues['newPassword'] ?? '',
      'confirmNewPassword': resetPassFormValues['confirmNewPassword'] ?? '',
    };

    // send verifyEmail request to server
    String? errorBuffer = await resetPassword(updatedUserDetails);
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

    // redirect to login page
    Navigator.of(context).pop();
    Navigator.of(context).pop();
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
