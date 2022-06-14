import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class VelocityAndTrack extends StatefulWidget {
  const VelocityAndTrack({Key? key}) : super(key: key);

  @override
  State<VelocityAndTrack> createState() => _VelocityAndTrackState();
}

class _VelocityAndTrackState extends State<VelocityAndTrack> {
  Color color = Colors.white;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          foregroundColor: Colors.black,
          backgroundColor: HexColor("#F6F6F6"),
          title: Text(
            "V&T",
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
          ),
          leading: Icon(Icons.arrow_back_ios),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.menu_sharp),
            )
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 8, right: 8),
            child: Column(
              children: [
                Card(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size.fromHeight(50),
                          primary: Colors.white),
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Velocity",
                            style: TextStyle(
                              color: HexColor("#161717"),
                            ),
                          ),
                          Icon(
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
                            minimumSize: Size.fromHeight(50),
                            primary: Colors.white),
                        onPressed: () {
                          setState(() {
                            HexColor("#30CED9");
                          });
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
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.black,
                            )
                          ],
                        )),
                  ),
                ),
              ],
            )));
  }
}
