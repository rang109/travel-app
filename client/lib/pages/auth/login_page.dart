import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'package:client/config/colors.dart';
import 'package:client/config/text_styles.dart';

import 'package:client/pages/home_page.dart';
import 'package:client/pages/auth/forgot_pass_page.dart';

import 'package:client/widgets/auth/login_form.dart';

import 'package:client/services/auth/login.dart';

// Login Page Widget
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static const List<String> loginFormFields = [
    'emailAddress',
    'password',
  ];

  final Map<String, String> loginFormValues = <String, String>{
    for (var key in loginFormFields) key: ''
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

  void handleLogin() {
    debugPrint('$loginFormValues');

    // TODO: add snackbar for error
    // setState(() async => 
    //  error = login(loginFormValues)
    //) // uncomment when ready

    if (error == null) return;

    // redirect to home page/dashboard
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
  }

  // redirect to forgot password page
  void handleForgotPasswordPage() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const ForgotPassPage()));
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
                  SizedBox(height: 120.0),
                  LoginForm(
                    onSubmit: handleLogin,
                    formFields: loginFormFields,
                    formValues: loginFormValues,
                    onFieldCahnged: (key, value) =>
                        setState(() => loginFormValues[key] = value),
                  ),
                  SizedBox(height: 10.0),
                  RichText(
                    text: TextSpan(
                      style: AppTextStyles.LABEL_2.copyWith(
                        color: AppColors.tomato,
                      ),
                      children: <TextSpan>[
                        TextSpan(text: 'Forgot Password?  '),
                        TextSpan(
                            style: AppTextStyles.LABEL_2_1.copyWith(
                              color: AppColors.tomato,
                            ),
                            text: 'Click Here',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                debugPrint('Navigate to Forgot Password Page');
                                handleForgotPasswordPage();
                              }),
                      ],
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
