import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';

class DashboardSettingScreen extends StatefulWidget {
  const DashboardSettingScreen({Key? key}) : super(key: key);

  @override
  State<DashboardSettingScreen> createState() => _DashboardSettingScreenState();
}

class _DashboardSettingScreenState extends State<DashboardSettingScreen> {
  bool weight = true;
  bool armPain = true;
  bool pd3 = true;
  bool pd4 = true;
  bool pd5 = true;
  bool pd6 = true;
  bool pd7 = true;
  bool Slt = true;
  bool Mtw = true;
  bool Dchd = true;
  bool klt = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#FFFFFF"),
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
        centerTitle: true,
        title: const Text(
          "Settings",
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(
              "Dashboard Graphs",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(
                    color: Color.fromARGB(255, 199, 184, 184),
                  ),
                  primary: HexColor("#FFFFFF"),
                ),
                child: SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text("Weight"),
                  activeColor: HexColor("#30CED9"),
                  onChanged: (value) => {
                    setState(
                      () {
                        weight = value;
                      },
                    )
                  },
                  value: weight,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(
                    color: Color.fromARGB(255, 199, 184, 184),
                  ),
                  primary: HexColor("#FFFFFF"),
                ),
                child: SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text("Arm Pain"),
                  activeColor: HexColor("#30CED9"),
                  onChanged: (value) => {
                    setState(
                      () => armPain = value,
                    ),
                  },
                  value: armPain,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(
                    color: Color.fromARGB(255, 199, 184, 184),
                  ),
                  primary: HexColor("#FFFFFF"),
                ),
                child: SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text("Pull Down 3"),
                  activeColor: HexColor("#30CED9"),
                  onChanged: (value) => {
                    setState(
                      () {
                        pd3 = value;
                      },
                    )
                  },
                  value: pd3,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(
                    color: Color.fromARGB(255, 199, 184, 184),
                  ),
                  primary: HexColor("#FFFFFF"),
                ),
                child: SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text("Pull Down 4"),
                  activeColor: HexColor("#30CED9"),
                  onChanged: (value) => {
                    setState(
                      () {
                        pd4 = value;
                      },
                    )
                  },
                  value: pd4,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(
                    color: Color.fromARGB(255, 199, 184, 184),
                  ),
                  primary: HexColor("#FFFFFF"),
                ),
                child: SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text("Pull Down 5"),
                  activeColor: HexColor("#30CED9"),
                  onChanged: (value) => {
                    setState(
                      () {
                        pd5 = value;
                      },
                    )
                  },
                  value: pd5,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(
                    color: Color.fromARGB(255, 199, 184, 184),
                  ),
                  primary: HexColor("#FFFFFF"),
                ),
                child: SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text("Pull Down 6"),
                  activeColor: HexColor("#30CED9"),
                  onChanged: (value) => {
                    setState(
                      () {
                        pd6 = value;
                      },
                    )
                  },
                  value: pd6,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(
                    color: Color.fromARGB(255, 199, 184, 184),
                  ),
                  primary: HexColor("#FFFFFF"),
                ),
                child: SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text("Pull Down 7"),
                  activeColor: HexColor("#30CED9"),
                  onChanged: (value) => {
                    setState(
                      () {
                        pd7 = value;
                      },
                    )
                  },
                  value: pd7,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(
                    color: Color.fromARGB(255, 199, 184, 184),
                  ),
                  primary: HexColor("#FFFFFF"),
                ),
                child: SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text("Standing Long Toss"),
                  activeColor: HexColor("#30CED9"),
                  onChanged: (value) => {
                    setState(
                      () {
                        Slt = value;
                      },
                    )
                  },
                  value: Slt,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(
                    color: Color.fromARGB(255, 199, 184, 184),
                  ),
                  primary: HexColor("#FFFFFF"),
                ),
                child: SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text("Mound Throw Velocity"),
                  activeColor: HexColor("#30CED9"),
                  onChanged: (value) => {
                    setState(
                      () {
                        Mtw = value;
                      },
                    )
                  },
                  value: Mtw,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(
                    color: const Color.fromARGB(255, 199, 184, 184),
                  ),
                  primary: HexColor("#FFFFFF"),
                ),
                child: SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text("Double Crow Hop Distance"),
                  activeColor: HexColor("#30CED9"),
                  onChanged: (value) => {
                    setState(
                      () => Dchd = value,
                    )
                  },
                  value: Dchd,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(
                    color: Color.fromARGB(255, 199, 184, 184),
                  ),
                  primary: HexColor("#FFFFFF"),
                ),
                child: SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text("Kneeling Long Toss"),
                  activeColor: HexColor("#30CED9"),
                  onChanged: (value) => {
                    setState(
                      () {
                        klt = value;
                      },
                    )
                  },
                  value: klt,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15, top: 20),
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
                    child: const Text("Update "),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
