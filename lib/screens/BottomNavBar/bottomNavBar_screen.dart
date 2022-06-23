import 'package:calendar_view/calendar_view.dart';
import 'package:connect/screens/Info/info_screen.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../Assessments/assessments_screen.dart';
import '../Dashboard/dashboard_screen.dart';
import '../Exercises/exercises_screen.dart';
import '../Schedule/model/event.dart';
import '../Schedule/pages/month_view_page.dart';

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
    const ExerciseScreen(),
    const Info(),
    const MonthViewPageDemo(),
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
      appBar: _selecIndex != 3
          ? AppBar(
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
                  : _selecIndex == 1
                      ? const Text(
                          "Exercises",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : _selecIndex == 2
                          ? const Text(
                              "Info",
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
            )
          : null,
      body: _widgetOptions[_selecIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        backgroundColor: HexColor("#30CED9"),
        child: const Icon(Icons.chat_rounded),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              (Icons.dashboard_rounded),
            ),
            label: "Dashboard",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              (Icons.sports_gymnastics_rounded),
            ),
            label: "Exercises",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              (Icons.add),
              size: 50,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              (Icons.calendar_month),
            ),
            label: "Schedule",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              (Icons.assessment_sharp),
            ),
            label: "Assessment",
          ),
        ],
        currentIndex: _selecIndex,
        selectedItemColor: HexColor("#30CED9"),
        unselectedItemColor: Colors.black,
        onTap: onTapped,
      ),
    );
  }
}
