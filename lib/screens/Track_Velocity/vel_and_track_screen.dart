import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'track_screen.dart';
import 'velocity_screen.dart';

class VelocityAndTrack extends StatefulWidget {
  const VelocityAndTrack({Key? key}) : super(key: key);

  @override
  State<VelocityAndTrack> createState() => _VelocityAndTrackState();
}

class _VelocityAndTrackState extends State<VelocityAndTrack> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
        centerTitle: true,
        title: const Text(
          "V&T",
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
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
        child: Column(
          children: [
            Card(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      primary: Colors.white),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const VelocityScreen(),
                      ),
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
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Card(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        primary: Colors.white),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TrackScreen(),
                        ),
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
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
