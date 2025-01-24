import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'package:client/config/colors.dart';
import 'package:client/config/text_styles.dart';

import 'package:client/pages/auth/login_page.dart';
import 'package:client/pages/auth/verify_email_page.dart';

import 'package:client/widgets/auth/signup_form.dart';
import 'package:client/widgets/generic/generator/create_snackbar.dart';

import 'package:client/services/auth/signup.dart';
import 'package:client/services/auth/send_otp.dart';

// Signup Page Widget
class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  static const List<String> signupFormFields = [
    'firstName',
    'lastName',
    'email',
    'username',
    'password',
    'confirmPassword',
  ];

  final Map<String, String> signupFormValues = <String, String>{
    for (var key in signupFormFields) key: ''
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

  void handleSignup() {
    var signupFormValues = <String, String>{
      'firstName': 'John',
      'lastName': 'Nash',
      'email': 'johnnash@gmail.com',
      'username': 'johnnash',
      'password': 'johnnashgwapo',
      'confirmPassword': 'johnnashgwapo',
    };

    debugPrint('$signupFormValues');

    // setState(() =>
    //   // error = await signup(signupFormValues)
    //   error = 'An error occurred.'
    //  ); // uncomment once ready

     if (error != null) {
      SnackBar snackBar = createSnackBar(message: error!);
      
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      return;
    }

    // setState(() async =>
    //   error = await sendOtp(signupFormValues['email'] ?? '')
    //  ); // uncomment once ready

     if (error != null) {
      SnackBar snackBar = createSnackBar(message: error!);
      
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      return;
    }

    // redirect to VerifyEmailPage
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => VerifyEmailPage(
            emailAddress: signupFormValues['email'] ?? '',
          )
        )
      );
  }

  // redirect to LoginPage
  void handleToLoginPage() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginPage()));
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
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SignupForm(
                  onSubmit: handleSignup,
                  formFields: signupFormFields,
                  formValues: signupFormValues,
                  onFieldChanged: (key, value) =>
                      setState(() => signupFormValues[key] = value),
                ),
                SizedBox(height: 10.0),
                RichText(
                  text: TextSpan(
                    style: AppTextStyles.LABEL_2.copyWith(
                      color: AppColors.tomato,
                    ),
                    children: <TextSpan>[
                      TextSpan(text: 'Already have an account?  '),
                      TextSpan(
                          style: AppTextStyles.LABEL_2_1.copyWith(
                            color: AppColors.tomato,
                          ),
                          text: 'Log in',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              debugPrint('Navigate to Login Page');
                              handleToLoginPage();
                            }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
