import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

import 'package:client/pages/home_page.dart';
import 'package:client/pages/itinerary/add_itinerary_page.dart';
import 'package:client/pages/locations/location_page.dart';
import 'package:client/widgets/navbar/navbar.dart';

// navbar Widget
class NavController extends StatefulWidget {
  const NavController({super.key});

  @override
  State<NavController> createState() => _NavControllerState();
}

class _NavControllerState extends State<NavController> {
  int _selectedIndex = 0;

  final List<Widget> pages = [
    HomePage(),
    AddItineraryPage(),
    LocationsPage(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: NavBar(
        currentIndex: _selectedIndex,
        onTabTapped: _onTabTapped,
      ),
    );
  }
}
