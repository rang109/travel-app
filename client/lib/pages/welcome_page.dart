import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';

// Welcome Page Widget
class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset("assets/animations/welcome-splash.json"),
      ),
    );
  }
}
