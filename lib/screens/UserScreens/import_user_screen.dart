import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ImportUser extends StatefulWidget {
  const ImportUser({Key? key}) : super(key: key);

  @override
  State<ImportUser> createState() => _ImportUserState();
}

class _ImportUserState extends State<ImportUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.black,
        backgroundColor: HexColor("#F6F6F6"),
        title: const Text(
          "User",
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {},
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 50),
          const Padding(
            padding: EdgeInsets.only(left: 25.0),
            child: Text(
              "Import User",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30.0),
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
              height: 45,
              width: 120,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text("Upload"),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0))),
              ),
            ),
          )
        ],
      ),
    );
  }
}
