import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class GeneralSettingScreen extends StatefulWidget {
  const GeneralSettingScreen({Key? key}) : super(key: key);

  @override
  State<GeneralSettingScreen> createState() => _GeneralSettingScreenState();
}

class _GeneralSettingScreenState extends State<GeneralSettingScreen> {
  bool weight = true;
  @override
  Widget build(BuildContext context) {
    bool switchBtn = true;
    return Scaffold(
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.only(left: 10),
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
                ElevatedButton(
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
                const Text(
                  "No file chosen",
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {},
              child: const Text("Upload "),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
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
        ],
      ),
    );
  }
}
