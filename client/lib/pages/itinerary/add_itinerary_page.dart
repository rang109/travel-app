import 'package:flutter/material.dart';

// Add Itinerary Page
class AddItineraryPage extends StatefulWidget {
  AddItineraryPage({super.key});

  @override
  State<AddItineraryPage> createState() => _AddIteneraryPageState();
}

class _AddIteneraryPageState extends State<AddItineraryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Your Iteneraries'),
    );
  }
}
