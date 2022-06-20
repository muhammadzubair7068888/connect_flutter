import 'package:connect/screens/Info/info_screen.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../Assessments/assessments_screen.dart';
import '../Dashboard/dashboard_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selecIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    const DashboardScreen(),
    const Info(),
    const AssessmentScreen(),
  ];
  void onTapped(int index) {
    setState(() {
      _selecIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
        centerTitle: true,
        title: _selecIndex == 0
            ? const Text(
                "Dashboard",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              )
            : const Text(
                "Assessments",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
        foregroundColor: Colors.black,
        backgroundColor: HexColor("#30CED9"),
      ),
      body: _widgetOptions[_selecIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                (Icons.dashboard_rounded),
              ),
              label: "dashboard"),
          // BottomNavigationBarItem(
          //     icon: Icon(
          //       (Icons.nordic_walking),
          //     ),
          //     label: "exercise"),
          BottomNavigationBarItem(
              icon: Icon(
                (Icons.person_add_alt_sharp),
              ),
              label: "Info"),
          // BottomNavigationBarItem(
          //     icon: Icon(
          //       (Icons.calendar_month),
          //     ),
          //     label: "schedule"),
          BottomNavigationBarItem(
              icon: Icon(
                (Icons.assessment_sharp),
              ),
              label: "assessment"),
        ],
        currentIndex: _selecIndex,
        selectedItemColor: HexColor("#30CED9"),
        unselectedItemColor: Colors.black,
        onTap: onTapped,
      ),
    );
  }
}
