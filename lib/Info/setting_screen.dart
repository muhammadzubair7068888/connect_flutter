import 'package:connect/Info/info_screen.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.black,
        backgroundColor: HexColor("#F6F6F6"),
        title: const Text(
          "Setting",
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0, left: 8, right: 8),
        child: ListView(
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  minimumSize: const Size.fromHeight(50),
                  primary: Colors.white),
              onPressed: () {
                setState(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const GeneralSetting()));
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "General Setting",
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
              padding: const EdgeInsets.only(top: 18.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  minimumSize: const Size.fromHeight(50),
                  primary: Colors.white,
                ),
                onPressed: () {
                  setState(
                    () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => const DashBoardGraph())));
                    },
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Dashboard Graph",
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
      bottomNavigationBar: const bottomNavigaion(),
    );
  }
}

class GeneralSetting extends StatefulWidget {
  const GeneralSetting({
    Key? key,
  }) : super(key: key);

  @override
  State<GeneralSetting> createState() => _GeneralSettingState();
}

class _GeneralSettingState extends State<GeneralSetting> {
  bool switchBtn = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.black,
        backgroundColor: HexColor("#F6F6F6"),
        title: const Text(
          "Setting",
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 50),
          const Padding(
            padding: EdgeInsets.only(left: 28.0),
            child: Text(
              "Custom Logo",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 18.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      primary: HexColor("#EEEEF2"),
                    ),
                    child: const Text(
                      "Choose file",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ),
                ),
                const Text(
                  "No file chosen",
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Center(
            child: SizedBox(
              height: 40,
              width: 100,
              child: ElevatedButton(
                  onPressed: () {}, child: const Text("Upload ")),
            ),
          ),
          const SizedBox(height: 20),
          SwitchListTile(
            title: const Text(
              "LeaderBoard",
              style: TextStyle(color: Colors.grey),
            ),
            value: switchBtn,
            onChanged: (bool value) {
              setState(
                () {
                  switchBtn = value;
                },
              );
            },
            activeColor: HexColor("#30CED9"),
          ),
        ],
      ),
      bottomNavigationBar: const bottomNavigaion(),
    );
  }
}

class DashBoardGraph extends StatefulWidget {
  const DashBoardGraph({
    Key? key,
  }) : super(key: key);

  @override
  State<DashBoardGraph> createState() => _DashBoardGraphState();
}

class _DashBoardGraphState extends State<DashBoardGraph> {
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
        centerTitle: true,
        foregroundColor: Colors.black,
        backgroundColor: HexColor("#FFFFFF"),
        title: const Text(
          "Setting",
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
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
          padding: const EdgeInsets.only(top: 18.0, left: 10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(
              "Dashboard Graph",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(
                    color: Color.fromARGB(255, 199, 184, 184),
                  ),
                  primary: HexColor("#FFFFFF"),
                ),
                child: SizedBox(
                  width: 250,
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
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(
                    color: Color.fromARGB(255, 199, 184, 184),
                  ),
                  primary: HexColor("#FFFFFF"),
                ),
                child: SizedBox(
                  width: 250,
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
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(
                    color: Color.fromARGB(255, 199, 184, 184),
                  ),
                  primary: HexColor("#FFFFFF"),
                ),
                child: SizedBox(
                  width: 250,
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
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(
                    color: Color.fromARGB(255, 199, 184, 184),
                  ),
                  primary: HexColor("#FFFFFF"),
                ),
                child: SizedBox(
                  width: 250,
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
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(
                    color: Color.fromARGB(255, 199, 184, 184),
                  ),
                  primary: HexColor("#FFFFFF"),
                ),
                child: SizedBox(
                  width: 250,
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
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(
                    color: Color.fromARGB(255, 199, 184, 184),
                  ),
                  primary: HexColor("#FFFFFF"),
                ),
                child: SizedBox(
                  width: 250,
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
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(
                    color: Color.fromARGB(255, 199, 184, 184),
                  ),
                  primary: HexColor("#FFFFFF"),
                ),
                child: SizedBox(
                  width: 250,
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
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(
                    color: Color.fromARGB(255, 199, 184, 184),
                  ),
                  primary: HexColor("#FFFFFF"),
                ),
                child: SizedBox(
                  width: 250,
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
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(
                    color: Color.fromARGB(255, 199, 184, 184),
                  ),
                  primary: HexColor("#FFFFFF"),
                ),
                child: SizedBox(
                  width: 250,
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
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(
                    color: const Color.fromARGB(255, 199, 184, 184),
                  ),
                  primary: HexColor("#FFFFFF"),
                ),
                child: SizedBox(
                  width: 250,
                  child: SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text("Double Crow Hop Distance"),
                    activeColor: HexColor("#30CED9"),
                    onChanged: (Value) => {
                      setState(
                        () => Dchd = Value,
                      )
                    },
                    value: Dchd,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(
                    color: Color.fromARGB(255, 199, 184, 184),
                  ),
                  primary: HexColor("#FFFFFF"),
                ),
                child: SizedBox(
                  width: 250,
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
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12, top: 7),
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
                      child: const Text("Update ")),
                ),
              ),
            ),
          ]),
        ),
      ),
      bottomNavigationBar: const bottomNavigaion(),
    );
  }
}
