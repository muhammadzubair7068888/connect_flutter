import 'dart:convert';

import 'package:connect/screens/Info/info_screen.dart';
import 'package:connect/screens/Schedule/extension.dart';
import 'package:date_field/date_field.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../Globals/globals.dart';
import '../Assessments/assessments_screen.dart';
import '../Chat/chatList_screen.dart';
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
  final int? index;
  final String? i;
  final String? u;
  const BottomNavBar({
    Key? key,
    required this.role,
    required this.index,
    required this.i,
    required this.u,
  }) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final storage = const FlutterSecureStorage();
  int _selecIndex = 0;
  String? imgUrl;
  String name = "";
  String height = "";
  String email = "";
  String strWeight = "";
  String handedness = "";
  int age = 0;
  String school = "";
  String lvl = "";
  String? token;
  String? id;

  late final List<Widget> _widgetOptions = <Widget>[
    const DashboardScreen(
      role: 'admin',
    ),
    const ExerciseScreen(),
    const Info(
      role: 'admin',
    ),
    MonthViewPageDemo(
      role: 'admin',
      i: widget.i,
      u: widget.u,
    ),
    const AssessmentScreen(),
  ];
  late final List<Widget> _widgetOptionsUser = <Widget>[
    const DashboardScreen(
      role: 'user',
    ),
    const Info(
      role: 'user',
    ),
    MonthViewPageDemo(
      role: 'user',
      i: widget.i,
      u: widget.u,
    ),
  ];

  void onTapped(int index) {
    setState(() {
      _selecIndex = index;
    });
  }

  check() {
    setState(() {
      if (widget.index != null) {
        _selecIndex = widget.index!;
      }
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

// --                                                               -- //
// --                          START                                -- //
// --                                                               -- //
  Future logout() async {
    await EasyLoading.show(
      status: 'Loading...',
      maskType: EasyLoadingMaskType.black,
    );
    var url = Uri.parse('${apiURL}signout');
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

  Future getProfile() async {
    // await EasyLoading.show(
    //   status: 'Loading...',
    //   maskType: EasyLoadingMaskType.black,
    // );
    var url = Uri.parse('${apiURL}profile');
    String? token = await storage.read(key: "token");
    http.Response response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      var jsonBody = response.body;
      var jsonData = jsonDecode(jsonBody);
      if (mounted) {
        setState(() {
          name = jsonData["data"]["name"];
          height = jsonData["data"]["height"];
          email = jsonData["data"]["email"];
          strWeight = jsonData["data"]["starting_weight"];
          handedness = jsonData["data"]["handedness"];
          age = jsonData["data"]["age"];
          school = jsonData["data"]["school"];
          lvl = jsonData["data"]["level"];
          imgUrl = jsonData["data"]["avatar"];
        });
      }
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

  Future<void> _readToken() async {
    final t = await storage.read(key: "token");
    setState(() {
      token = t;
    });
  }

  Future<void> _readRole() async {
    final i = await storage.read(key: "id");
    setState(() {
      id = i;
    });
  }
// --                                                               -- //
// --                           END                                 -- //
// --                                                               -- //

  @override
  void initState() {
    super.initState();
    _readToken();
    _readRole();
    check();
    getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.role != "user"
          ? AppBar(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(10),
                ),
              ),
              centerTitle: true,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: InkWell(
                    child: const Icon(Icons.chat_rounded),
                    onTap: () {
                      //
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatListScreen(
                            urC: imgUrl,
                            currentName: name,
                            i: widget.i,
                            index: widget.index,
                            role: widget.role,
                            u: widget.u,
                            id: id,
                            token: token,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
              leading: PopupMenuButton(
                onSelected: (value) {
                  if (value == MenuItem.item1) {
                    //
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileScreen(
                          age: age,
                          email: email,
                          height: height,
                          handedness: handedness,
                          imgUrl: imgUrl,
                          lvl: lvl,
                          name: name,
                          school: school,
                          strWeight: strWeight,
                          role: widget.role,
                        ),
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
                            color: HexColor("#30CED9"), // red as border color
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.transparent,
                          child: Padding(
                            padding: const EdgeInsets.all(1),
                            child: ClipOval(
                              child: imgUrl != null
                                  ? Image.network(
                                      '$imgUrl',
                                      // '$publicUrl$imgUrl',
                                      fit: BoxFit.cover,
                                      width: 80.0,
                                      height: 80.0,
                                    )
                                  : null,
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
                          : _selecIndex == 3
                              ? const Text(
                                  "Schedule",
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
          : AppBar(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(10),
                ),
              ),
              centerTitle: true,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: InkWell(
                    child: const Icon(Icons.chat_rounded),
                    onTap: () {
                      //
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatListScreen(
                            urC: imgUrl,
                            currentName: name,
                            i: widget.i,
                            index: widget.index,
                            role: widget.role,
                            u: widget.u,
                            id: id,
                            token: token,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
              leading: PopupMenuButton(
                onSelected: (value) {
                  if (value == MenuItem.item1) {
                    //
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileScreen(
                          age: age,
                          email: email,
                          height: height,
                          handedness: handedness,
                          imgUrl: imgUrl,
                          lvl: lvl,
                          name: name,
                          school: school,
                          strWeight: strWeight,
                          role: widget.role,
                        ),
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
                            color: HexColor("#30CED9"), // red as border color
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.transparent,
                          child: Padding(
                            padding: const EdgeInsets.all(1),
                            child: ClipOval(
                              child: imgUrl != null
                                  ? Image.network(
                                      '$imgUrl',
                                      fit: BoxFit.cover,
                                      width: 80.0,
                                      height: 80.0,
                                    )
                                  : null,
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
                          "Schedule",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
            ),
      body: widget.role == "user"
          ? _widgetOptionsUser[_selecIndex]
          : _widgetOptions[_selecIndex],
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
