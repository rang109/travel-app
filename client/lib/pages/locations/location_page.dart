import 'package:flutter/material.dart';

// Locations Page
class LocationsPage extends StatefulWidget {
  LocationsPage({super.key});

  @override
  State<LocationsPage> createState() => _LocationsPageState();
}

class _LocationsPageState extends State<LocationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Locations'),
    );
  }
}
