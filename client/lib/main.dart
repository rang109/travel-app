import 'package:flutter/material.dart';

import 'package:client/pages/home_page.dart';
import 'package:client/pages/auth/login_page.dart';
import 'package:client/pages/auth/signup_page.dart';
import 'package:client/pages/auth/verify_email_page.dart';

void main() {
  runApp(const TravelApp());
}

// Root Widget
class TravelApp extends StatelessWidget {
  const TravelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel App',
      theme: ThemeData(
        // This is the theme of your application.
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SignupPage(),
    );
  }
}