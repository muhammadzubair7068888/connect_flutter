// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import '../../../Globals/globals.dart';

class DayPlanScreen extends StatefulWidget {
  final int id;
  const DayPlanScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<DayPlanScreen> createState() => _DayPlanScreenState();
}

class _DayPlanScreenState extends State<DayPlanScreen> {
  final storage = const FlutterSecureStorage();
  String title = '';
  String desc = '';
  String strength = '';
  String detailsId = '';
  List<Widget> wrapper = <Widget>[];
  bool load = true;

// --                                                               -- //
// --                          START                                -- //
// --                                                               -- //
  Future updateStrength(String strength, int id) async {
    var uri = Uri.parse('${apiURL}exercises/schedule/exercise/$id/strength');
    String? token = await storage.read(key: "token");
    http.Response response = await http.put(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, String?>{
        'strength': strength,
      }),
    );
    // var response = await request.send();
    // var responseDecode = await http.Response.fromStream(response);
    if (response.statusCode == 200) {
      // final result = jsonDecode(responseDecode.body);
      // final result = jsonDecode(responseDecode.body) as Map<String, dynamic>;
    } else {
      // await EasyLoading.dismiss();
      FocusManager.instance.primaryFocus?.unfocus();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.redAccent,
            dismissDirection: DismissDirection.vertical,
            content: Text('Server Error'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  Future getDetails() async {
    var url = Uri.parse('${apiURL}exercises/schedule/exercise/${widget.id}');
    String? token = await storage.read(key: "token");
    http.Response response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      var jsonBody = response.body;
      var jsonData = jsonDecode(jsonBody);
      if (mounted) {
        setState(
          () {
// detailsId=/
            var data = jsonData["exercise"];
            title = data[0]["name"];
            desc = data[0]["description"];
            for (var i = 0; i < data[0]["excercise_detail"].length; i++) {
              wrapper.add(
                Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Link: ",
                              style: TextStyle(
                                color: HexColor("#1C1C1C"),
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                              ),
                            ),
                            TextSpan(
                              text: data[0]["excercise_detail"][i]["link"],
                              style: TextStyle(
                                color: HexColor("#1777E3"),
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Notes: ",
                              style: TextStyle(
                                color: HexColor("#1C1C1C"),
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                              ),
                            ),
                            TextSpan(
                              text: data[0]["excercise_detail"][i]["notes"],
                              style: TextStyle(
                                color: HexColor("#1C1C1C"),
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Sets: ",
                              style: TextStyle(
                                color: HexColor("#161717"),
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                              ),
                            ),
                            TextSpan(
                              // ignore: prefer_if_null_operators
                              text: data[0]["excercise_detail"][i]["sets"] != ""
                                  ? data[0]["excercise_detail"][i]["sets"]
                                  : " n/a",
                              style: TextStyle(
                                color: HexColor("#161717"),
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Reps: ",
                              style: TextStyle(
                                color: HexColor("#161717"),
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                              ),
                            ),
                            TextSpan(
                              // ignore: prefer_if_null_operators
                              text: data[0]["excercise_detail"][i]["reps"] != ""
                                  ? data[0]["excercise_detail"][i]["reps"]
                                  : " n/a",
                              style: TextStyle(
                                color: HexColor("#161717"),
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: RichText(
                        text: TextSpan(
                          text: "Strength:",
                          style: TextStyle(
                            color: HexColor("#161717"),
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      autofocus: false,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10),
                        hintText: '0',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      initialValue:
                          data[0]["excercise_detail"][i]["strength"] != null
                              ? data[0]["excercise_detail"][i]["strength"]
                                  .toString()
                              : 0.toString(),
                      onChanged: (value) {
                        strength = value;
                        updateStrength(
                            strength, data[0]["excercise_detail"][i]["id"]);
                      },
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              );
            }
            load = false;
          },
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.redAccent,
            dismissDirection: DismissDirection.vertical,
            content: Text('Server Error'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }
// --                                                               -- //
// --                           END                                 -- //
// --                                                               -- //

  @override
  void initState() {
    super.initState();
    getDetails();
  }

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
          "Plan",
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: load
          ? const Center(
              child: SizedBox(
                width: 200,
                height: 200,
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      "Day Plan",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const Text(
                          "Title:",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          " $title",
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Description: ",
                              style: TextStyle(
                                color: HexColor("#1C1C1C"),
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                              ),
                            ),
                            TextSpan(
                              text: desc,
                              style: TextStyle(
                                color: HexColor("#1C1C1C"),
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Column(
                      children: wrapper,
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
