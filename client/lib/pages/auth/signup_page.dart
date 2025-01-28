import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'package:travel_app/config/colors.dart';
import 'package:travel_app/config/text_styles.dart';

import 'package:travel_app/pages/auth/login_page.dart';
import 'package:travel_app/pages/auth/verify_email_page.dart';

import 'package:travel_app/widgets/auth/signup_form.dart';
import 'package:travel_app/widgets/generic/generator/create_snackbar.dart';

import 'package:travel_app/services/auth/signup.dart';
import 'package:travel_app/services/auth/send_otp.dart';

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

  void handleSignup() async {
    // var signupFormValues = <String, String>{
    //   'firstName': 'C',
    //   'lastName': 'B',
    //   'email': 'brillos.christian@gmail.com',
    //   'username': 'creeees',
    //   'password': 'qwerty123!',
    //   'confirmPassword': 'qwerty123!',
    // };

    // send signup request to server
    String? errorBuffer = await signup(signupFormValues);
    setState(() =>
      error = errorBuffer
    );

    if (error != null) {
      SnackBar snackBar = createSnackBar(message: error);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      return;
    }

    // send sendOtp request to server
    errorBuffer = await sendOtp(signupFormValues['email'] ?? '');
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
                    style: AppTextStyles.label_2.copyWith(
                      color: AppColors.tomato,
                    ),
                    children: <TextSpan>[
                      TextSpan(text: 'Already have an account?  '),
                      TextSpan(
                          style: AppTextStyles.label_2_1.copyWith(
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
