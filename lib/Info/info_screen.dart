import 'dart:collection';

import 'package:connect/Info/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Info extends StatefulWidget {
  const Info({Key? key}) : super(key: key);

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  bool trVel = true;
  bool File = true;
  bool EdtAsmt = true;
  bool question = true;
  bool users = true;
  bool profile = true;
  bool setting = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.black,
        backgroundColor: HexColor("#F6F6F6"),
        title: const Text(
          "Info",
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
        ),
        leading: const Icon(Icons.arrow_back_ios),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0, left: 8, right: 8),
        child: ListView(
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: trVel ? Colors.white : HexColor("#30CED9"),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                minimumSize: Size.fromHeight(50),
              ),
              onPressed: () {
                setState(
                  () {
                    trVel = !trVel;
                  },
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Track and Velocity",
                    style: TextStyle(
                      color: HexColor("#161717"),
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: File ? Colors.white : HexColor("#30CED9"),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  minimumSize: Size.fromHeight(50),
                ),
                onPressed: () {
                  setState(
                    () {
                      File = !File;
                    },
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Files",
                      style: TextStyle(
                        color: HexColor("#161717"),
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black,
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: EdtAsmt ? Colors.white : HexColor("#30CED9"),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  minimumSize: Size.fromHeight(47),
                ),
                onPressed: () {
                  setState(
                    () {
                      EdtAsmt = !EdtAsmt;
                    },
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Edit Assesments",
                      style: TextStyle(
                        color: HexColor("#161717"),
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black,
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: question ? Colors.white : HexColor("#30CED9"),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  minimumSize: Size.fromHeight(50),
                ),
                onPressed: () {
                  setState(
                    () {
                      question = !question;
                    },
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Questionnaires",
                      style: TextStyle(
                        color: HexColor("#161717"),
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black,
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: users ? Colors.white : HexColor("#30CED9"),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  minimumSize: Size.fromHeight(50),
                ),
                onPressed: () {
                  setState(
                    () {
                      users = !users;
                    },
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Users",
                      style: TextStyle(
                        color: HexColor("#161717"),
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black,
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: profile ? Colors.white : HexColor("#30CED9"),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  minimumSize: const Size.fromHeight(50),
                ),
                onPressed: () {
                  setState(() {
                    profile = !profile;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Profile",
                      style: TextStyle(
                        color: HexColor("#161717"),
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black,
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: setting ? Colors.white : HexColor("#30CED9"),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  minimumSize: Size.fromHeight(50),
                ),
                onPressed: () {
                  setState(
                    () {
                      setting = !setting;
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Setting()));
                    },
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Settings",
                      style: TextStyle(
                        color: HexColor("#161717"),
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: bottomNavigaion(),
    );
  }
}

class bottomNavigaion extends StatefulWidget {
  const bottomNavigaion({
    Key? key,
  }) : super(key: key);

  @override
  State<bottomNavigaion> createState() => _bottomNavigaionState();
}

class _bottomNavigaionState extends State<bottomNavigaion> {
  int _selecIndex = 0;
  void onTapped(int index) {
    setState(() {
      _selecIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                (Icons.dashboard_rounded),
              ),
              label: "dashboard"),
          BottomNavigationBarItem(
              icon: Icon(
                (Icons.nordic_walking),
              ),
              label: "exercise"),
          BottomNavigationBarItem(
              icon: Icon(
                (Icons.person_add_alt_sharp),
              ),
              label: "Info"),
          BottomNavigationBarItem(
              icon: Icon(
                (Icons.calendar_month),
              ),
              label: "schedule"),
          BottomNavigationBarItem(
              icon: Icon(
                (Icons.assessment_sharp),
              ),
              label: "assessment"),
        ],
        currentIndex: _selecIndex,
        selectedItemColor: HexColor("#30CED9"),
        unselectedItemColor: Colors.black,
        onTap: onTapped);
  }
}
