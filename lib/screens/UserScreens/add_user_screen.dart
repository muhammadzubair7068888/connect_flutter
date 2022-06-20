import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  int? groupvalue;
  @override
  void initState() {
    // TODO: implement initState
    groupvalue = 0;
  }

  setGroupValue(int val) {
    setState(() {
      groupvalue = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#FFFFFF"),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "User",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 22, color: Colors.black),
        ),
        backgroundColor: HexColor("#FFFFFF"),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: HexColor("#02010E"),
          ),
          onPressed: () {},
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 18.0, left: 20),
              child: Text(
                "Add New User",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 25),
              child: CircleAvatar(
                backgroundImage: const AssetImage("images/profile.png"),
                radius: 50,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomRight,
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.white70,
                        child: IconButton(
                          icon: const Icon(
                            Icons.camera_alt,
                            color: Colors.black,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12),
              child: Row(
                children: const [
                  Text("Name",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  SizedBox(
                    width: 125,
                  ),
                  Text("Email",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: SizedBox(
                      width: 150,
                      child: TextField(
                        autofocus: false,
                        decoration: InputDecoration(
                          isCollapsed: true,
                          contentPadding:
                              const EdgeInsets.fromLTRB(5, 10, 5, 10),
                          hintText: 'Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: SizedBox(
                      width: 155,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "bw@cp.com",
                          isCollapsed: true,
                          contentPadding:
                              const EdgeInsets.fromLTRB(5, 10, 5, 10),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7.0)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 8.0),
              child: Row(
                children: const [
                  Text("Password",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  SizedBox(
                    width: 98,
                  ),
                  Text("Confirm Password",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: SizedBox(
                      width: 150,
                      child: TextField(
                        obscureText: true,
                        autofocus: false,
                        decoration: InputDecoration(
                          isCollapsed: true,
                          contentPadding:
                              const EdgeInsets.fromLTRB(5, 10, 5, 10),
                          hintText: '*******',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: SizedBox(
                      width: 155,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Confirm Password",
                          isCollapsed: true,
                          contentPadding:
                              const EdgeInsets.fromLTRB(5, 10, 5, 10),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7.0)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0, top: 8.0),
              child: Row(
                children: const [
                  Text("Height",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  SizedBox(
                    width: 125,
                  ),
                  Text("Starting Weight",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: SizedBox(
                      width: 150,
                      child: TextField(
                        autofocus: false,
                        decoration: InputDecoration(
                          isCollapsed: true,
                          contentPadding:
                              const EdgeInsets.fromLTRB(5, 10, 5, 10),
                          hintText: 'Height',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: SizedBox(
                      width: 155,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Starting Weight",
                          isCollapsed: true,
                          contentPadding:
                              const EdgeInsets.fromLTRB(5, 10, 5, 10),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7.0)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0, top: 8.0),
              child: Row(
                children: const [
                  Text("School",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  SizedBox(
                    width: 125,
                  ),
                  Text("Level",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: SizedBox(
                      width: 150,
                      child: TextField(
                        autofocus: false,
                        decoration: InputDecoration(
                          isCollapsed: true,
                          contentPadding:
                              const EdgeInsets.fromLTRB(5, 10, 5, 10),
                          hintText: 'School',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: SizedBox(
                      width: 155,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Level",
                          isCollapsed: true,
                          contentPadding:
                              const EdgeInsets.fromLTRB(5, 10, 5, 10),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7.0)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(18.0),
              child: Text(
                "User Status",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
            ),
            Row(
              children: [
                Radio(
                  activeColor: HexColor("#30CED9"),
                  value: 1,
                  groupValue: groupvalue,
                  onChanged: (int? val) {
                    setGroupValue(val!);
                  },
                ),
                const Text(
                  "Active",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                ),
                SizedBox(width: 90),
                Radio(
                  activeColor: HexColor("#30CED9"),
                  value: 2,
                  groupValue: groupvalue,
                  onChanged: (int? val) {
                    setGroupValue(val!);
                  },
                ),
                const Text(
                  "Banned",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: SizedBox(
                  height: 43,
                  width: 120,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                      onPressed: () {},
                      child: const Text("Submit")),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
