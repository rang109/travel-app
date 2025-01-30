import 'package:flutter/material.dart';

import 'package:client/widgets/navbar/nav_controller.dart';

void main() {
  runApp(const TravelApp());
}

// Root Widget
class TravelApp extends StatelessWidget {
  const TravelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Travel App',
      theme: ThemeData(
        // This is the theme of your application.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: NavController(),
    );
  }
}
