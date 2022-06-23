import 'package:connect/screens/Info/info_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../Globals/globals.dart';
import '../Assessments/assessments_screen.dart';
import '../Dashboard/dashboard_screen.dart';
import '../Exercises/exercises_screen.dart';
import '../Profile/profile_screen.dart';
import '../Schedule/pages/month_view_page.dart';
import 'package:http/http.dart' as http;

import '../SignIn_TermConditions_Welcome/welcome_screen.dart';

enum MenuItem {
  item1,
  item2,
  item3,
  item4,
}

class BottomNavBar extends StatefulWidget {
  final String role;
  const BottomNavBar({
    Key? key,
    required this.role,
  }) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selecIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    const DashboardScreen(),
    const ExerciseScreen(),
    const Info(
      role: 'admin',
    ),
    const MonthViewPageDemo(),
    const AssessmentScreen(),
  ];
  final List<Widget> _widgetOptionsUser = <Widget>[
    const DashboardScreen(),
    const Info(
      role: 'user',
    ),
    const MonthViewPageDemo(),
  ];
  void onTapped(int index) {
    setState(() {
      _selecIndex = index;
    });
  }

  void _navigate() {
    Navigator.pushAndRemoveUntil<void>(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => const WelcomeScreen(),
      ),
      (route) => false,
    );
  }

  final storage = const FlutterSecureStorage();
  Future logout() async {
    await EasyLoading.show(
      status: 'Loading...',
      maskType: EasyLoadingMaskType.black,
    );
    var url = Uri.parse('${baseURL}signout');
    String? token = await storage.read(key: "token");
    http.Response response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      await storage.deleteAll();
      _navigate();
      await EasyLoading.dismiss();
    } else {
      await EasyLoading.dismiss();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.redAccent,
            dismissDirection: DismissDirection.vertical,
            content: Text('Server Error'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    print(widget.role);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.role != "user"
          ? _selecIndex != 3
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
              : null
          : _selecIndex != 2
              ? AppBar(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(10),
                    ),
                  ),
                  centerTitle: true,
                  leading: PopupMenuButton(
                    onSelected: (value) {
                      if (value == MenuItem.item1) {
                        //
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProfileScreen(),
                          ),
                        );
                      } else if (value == MenuItem.item2) {
                        //
                      } else if (value == MenuItem.item3) {
                        //
                        logout();
                      }
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              border: Border.all(
                                color:
                                    HexColor("#30CED9"), // red as border color
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 40,
                              backgroundColor: Colors.transparent,
                              child: Padding(
                                padding: const EdgeInsets.all(6),
                                child: ClipRRect(
                                  child: Image.network(
                                    'https://www.woolha.com/media/2020/03/eevee.png',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const PopupMenuItem(
                        value: MenuItem.item1,
                        child: Text("My Profile"),
                      ),
                      const PopupMenuItem(
                        value: MenuItem.item2,
                        child: Text("Contact Us"),
                      ),
                      const PopupMenuItem(
                        value: MenuItem.item3,
                        child: Text("Sign Out"),
                      )
                    ],
                  ),
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
      body: widget.role == "user"
          ? _widgetOptionsUser[_selecIndex]
          : _widgetOptions[_selecIndex],
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
        items: widget.role != "user"
            ? const <BottomNavigationBarItem>[
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
              ]
            : const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(
                    (Icons.dashboard_rounded),
                  ),
                  label: "Dashboard",
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
              ],
        currentIndex: _selecIndex,
        selectedItemColor: HexColor("#30CED9"),
        unselectedItemColor: Colors.black,
        onTap: onTapped,
      ),
    );
  }
}
