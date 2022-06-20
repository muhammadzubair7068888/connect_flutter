import 'package:connect/screens/Dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor("#FFFFFF"),
        appBar: AppBar(
          elevation: 0.0,
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
          child: Center(
            child: Column(
              children: [
                Text(
                  "My Profile",
                  style: TextStyle(
                      color: HexColor("#222222"),
                      fontSize: 30,
                      fontWeight: FontWeight.w600),
                ),
                formFielf(formKey: _formKey)
              ],
            ),
          ),
        ));
  }
}

class formFielf extends StatefulWidget {
  const formFielf({
    Key? key,
    required GlobalKey<FormState> formKey,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;

  @override
  State<formFielf> createState() => _formFielfState();
}

class _formFielfState extends State<formFielf> {
  String name = "  Alix";
  String height = " 22454";
  String email = " test@cp.com";
  String strWeight = "   45";
  String handedness = "   Left";
  String age = "  45";
  String Scl = "  Becon";
  String lvl = "    4";
  bool btnPress = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: CircleAvatar(
                backgroundImage: AssetImage("images/profile.png"),
                radius: 55,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomRight,
                      child: btnPress
                          ? CircleAvatar(
                              radius: 18,
                              backgroundColor: Colors.white70,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.camera_alt,
                                  color: Colors.black,
                                ),
                                onPressed: () {},
                              ),
                            )
                          : const CircleAvatar(
                              backgroundColor: Colors.transparent,
                            ),
                    )
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: Container(
                    width: 120,
                    child: TextField(
                      enabled: btnPress,
                      controller: TextEditingController()..text = '$name',
                      onChanged: (nam) {
                        name = nam;
                      },
                      autofocus: false,
                      decoration: InputDecoration(
                        isCollapsed: true,
                        contentPadding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                        labelText: 'Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7.0),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 120,
                  child: TextField(
                    enabled: btnPress,
                    controller: TextEditingController()..text = '$height',
                    onChanged: (high) {
                      height = high;
                    },
                    decoration: InputDecoration(
                      labelText: "Height",
                      isCollapsed: true,
                      contentPadding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7.0)),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: TextField(
                enabled: btnPress,
                controller: TextEditingController()..text = '$email',
                onChanged: (eml) {
                  email = eml;
                },
                decoration: InputDecoration(
                    isCollapsed: true,
                    contentPadding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7.0)),
                    labelText: "Email"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 140,
                    child: TextField(
                      enabled: btnPress,
                      controller: TextEditingController()..text = '$strWeight',
                      onChanged: (weight) {
                        strWeight = weight;
                      },
                      decoration: InputDecoration(
                          isCollapsed: true,
                          contentPadding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7.0)),
                          labelText: "Starting Weight"),
                    ),
                  ),
                  SizedBox(
                    width: 140,
                    child: TextField(
                      enabled: btnPress,
                      controller: TextEditingController()..text = '$handedness',
                      onChanged: (hndedness) {
                        handedness = hndedness;
                      },
                      decoration: InputDecoration(
                          isCollapsed: true,
                          contentPadding:
                              const EdgeInsets.fromLTRB(5, 10, 5, 10),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7.0)),
                          labelText: "Handedness"),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 140,
                    child: TextField(
                      enabled: btnPress,
                      controller: TextEditingController()..text = '$age',
                      onChanged: (Age) {
                        age = Age;
                      },
                      decoration: InputDecoration(
                          isCollapsed: true,
                          contentPadding:
                              const EdgeInsets.fromLTRB(5, 10, 5, 10),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7.0)),
                          labelText: "Age"),
                    ),
                  ),
                  SizedBox(
                    width: 140,
                    child: TextField(
                      enabled: btnPress,
                      controller: TextEditingController()..text = '$Scl',
                      onChanged: (scol) {
                        Scl = scol;
                      },
                      decoration: InputDecoration(
                          isCollapsed: true,
                          contentPadding:
                              const EdgeInsets.fromLTRB(5, 10, 5, 10),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7.0)),
                          labelText: "School"),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: TextField(
                enabled: btnPress,
                controller: TextEditingController()..text = '$lvl',
                onChanged: (level) {
                  lvl = level;
                },
                decoration: InputDecoration(
                    isCollapsed: true,
                    contentPadding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7.0)),
                    labelText: "Level"),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20),
              child: SizedBox(
                width: 180,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                    onPressed: () {
                      // setState(() {
                      //   btnPress = !btnPress;
                      // });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DashboardScreen(),
                        ),
                      );
                    },
                    child:
                        //  btnPress
                        // ?
                        const Text("Submit")
                    // : const Text("Edit Profile"),
                    ),
              ),
            ),
          ],
        ));
  }
}
