import 'package:flutter/material.dart';

import 'package:client/config/colors.dart';

// navbar Widget
class NavBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTabTapped;

  const NavBar(
      {super.key, required this.currentIndex, required this.onTabTapped});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 40),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BottomNavigationBar(
          currentIndex: widget.currentIndex,
          backgroundColor: AppColors.lightBisque,
          selectedItemColor: AppColors.tomato,
          unselectedItemColor: AppColors.wheat,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          iconSize: 30,
          onTap: (index) {
            widget.onTabTapped(index);
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.location_pin),
              label: 'Location',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_rounded),
              label: 'Plans',
            ),
          ],
        ),
      ),
    );
  }
}
