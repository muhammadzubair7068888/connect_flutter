import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class VelocityAndTrack extends StatefulWidget {
  const VelocityAndTrack({Key? key}) : super(key: key);

  @override
  State<VelocityAndTrack> createState() => _VelocityAndTrackState();
}

class _VelocityAndTrackState extends State<VelocityAndTrack> {
  bool pressed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.black,
        backgroundColor: HexColor("#F6F6F6"),
        title: const Text(
          "V&T",
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
        ),
        leading: const Icon(Icons.arrow_back_ios),
        // ignore: prefer_const_literals_to_create_immutables
        actions: [
          const Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(Icons.menu_sharp),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0, left: 8, right: 8),
        child: Column(
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                minimumSize: Size.fromHeight(50),
                primary: pressed ? Colors.white : HexColor("#30CED9"),
              ),
              onPressed: () {
                setState(
                  () {
                    pressed = !pressed;
                  },
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Velocity",
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
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  minimumSize: const Size.fromHeight(50),
                  primary: !pressed ? Colors.white : HexColor("#30CED9"),
                ),
                onPressed: () {
                  setState(
                    () {
                      pressed = !pressed;
                    },
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Track",
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
    );
  }
}
