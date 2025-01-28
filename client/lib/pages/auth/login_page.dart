import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'package:travel_app/config/colors.dart';
import 'package:travel_app/config/text_styles.dart';

import 'package:travel_app/pages/home_page.dart';
import 'package:travel_app/pages/auth/forgot_pass_page.dart';

import 'package:travel_app/widgets/auth/login_form.dart';
import 'package:travel_app/widgets/generic/generator/create_snackbar.dart';

import 'package:travel_app/services/auth/login.dart';

// Login Page Widget
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static const List<String> loginFormFields = [
    'email',
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

  void handleLogin() async {
    // send login request to server
    String? errorBuffer = await login(loginFormValues);
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
                    onFieldChanged: (key, value) =>
                        setState(() => loginFormValues[key] = value),
                  ),
                  SizedBox(height: 10.0),
                  RichText(
                    text: TextSpan(
                      style: AppTextStyles.label_2.copyWith(
                        color: AppColors.tomato,
                      ),
                      children: <TextSpan>[
                        TextSpan(text: 'Forgot Password?  '),
                        TextSpan(
                            style: AppTextStyles.label_2_1.copyWith(
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
