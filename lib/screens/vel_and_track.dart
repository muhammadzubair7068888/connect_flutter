import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 50,
                child: Card(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Velocity ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20),
                            ),
                            WidgetSpan(
                              child: Icon(Icons.arrow_forward_ios, size: 24),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: SizedBox(
                  height: 50,
                  child: Card(
                      color: HexColor("#30CED9"),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Track ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20),
                              ),
                              WidgetSpan(
                                child: Icon(Icons.arrow_forward_ios, size: 24),
                              ),
                            ],
                          ),
                        ),
                      )),
                ),
              ),
            ],
          ),
        ));
  }
}
