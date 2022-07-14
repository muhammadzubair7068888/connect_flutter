import 'dart:convert';

import 'package:connect/screens/Track_Velocity/alertDialogWidget.dart';
import 'package:date_field/date_field.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;

import '../../Globals/globals.dart';

class LeaderBoard extends StatefulWidget {
  const LeaderBoard({Key? key}) : super(key: key);

  @override
  State<LeaderBoard> createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  final GlobalKey<FormState> _form = GlobalKey();
  late TextEditingController _controller;
  DateTime dateTime = DateTime.now();
  DateTime? dateTimeEnd;
  String wgh = "";
  String armP = "";
  String pDVel = "";
  String mTVel = "";
  String pD3 = "";
  String pD4 = "";
  String pD5 = "";
  String pD6 = "";
  String pD7 = "";
  String lTDist = "";
  String p7Lab = "";
  String p5Lab = "";
  String p3 = "";
  String ben = "";
  String sqt = "";
  String dLift = "";
  String vJump = "";
  bool filter = false;
  final storage = const FlutterSecureStorage();
  List<DataRow> rowsAdd = [];

  List data = [];
  List search = [];
  TextEditingController controller = TextEditingController();
  onSearch(String text) async {
    search.clear();
    if (text.isEmpty) {
      getLeaderBoard();
    }

    for (var f in data) {
      if (f["name"].contains(text)) {
        search.add(f);
      }
    }
    setState(() {
      if (search.isNotEmpty) {
        rowsAdd = [];
        for (var i = 0; i < search.length; i++) {
          rowsAdd.add(
            DataRow(
              cells: [
                DataCell(Text(search[i]["name"])),
                DataCell(Text("${search[i]["weight"]}")),
                DataCell(Text("${search[i]["arm_pain"]}")),
                DataCell(Text("${search[i]["pull_down_velocity"]}")),
                DataCell(Text("${search[i]["mound_throws_velocity"]}")),
                DataCell(Text("${search[i]["pull_down_3"]}")),
                DataCell(Text("${search[i]["pull_down_4"]}")),
                DataCell(Text("${search[i]["pull_down_5"]}")),
                DataCell(Text("${search[i]["pull_down_6"]}")),
                DataCell(Text("${search[i]["pull_down_7"]}")),
                DataCell(Text("${search[i]["long_toss_distance"]}")),
                DataCell(Text("${search[i]["pylo_7"]}")),
                DataCell(Text("${search[i]["pylo_5"]}")),
                DataCell(Text("${search[i]["pylo_3"]}")),
                DataCell(Text("${search[i]["bench"]}")),
                DataCell(Text("${search[i]["squat"]}")),
                DataCell(Text("${search[i]["deadlift"]}")),
                DataCell(Text("${search[i]["vertical_jump"]}")),
              ],
            ),
          );
        }
      }
    });
  }

  void _resetForm() {
    _form.currentState?.reset();
  }

// --                                                               -- //
// --                          START                                -- //
// --                                                               -- //
  // Future filterL() async {
  //   var uri = Uri.parse('${apiURL}users/leaderboard/filter');
  //   String? token = await storage.read(key: "token");
  //   Map<String, String> headers = {
  //     'Content-Type': 'multipart/form-data',
  //     'Accept': 'application/json',
  //     'Authorization': 'Bearer $token',
  //   };
  //   var request = http.MultipartRequest(
  //     'POST',
  //     uri,
  //   )..headers.addAll(headers);
  //   request.fields['start'] = dateTime.toString();
  //   request.fields['end'] = dateTimeEnd.toString();
  //   var response = await request.send();
  //   // var responseDecode = await http.Response.fromStream(response);
  //   if (response.statusCode == 200) {
  //     // final result = jsonDecode(responseDecode.body);
  //     // final result = jsonDecode(responseDecode.body) as Map<String, dynamic>;
  //     FocusManager.instance.primaryFocus?.unfocus();
  //     _resetForm();
  //     getLeaderBoard();
  //     if (mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           backgroundColor: HexColor("#30CED9"),
  //           dismissDirection: DismissDirection.vertical,
  //           content: const Text('Added successfully'),
  //           duration: const Duration(seconds: 2),
  //         ),
  //       );
  //     }
  //   } else {
  //     // await EasyLoading.dismiss();
  //     FocusManager.instance.primaryFocus?.unfocus();
  //     if (mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           backgroundColor: Colors.redAccent,
  //           dismissDirection: DismissDirection.vertical,
  //           content: Text('Server Error'),
  //           duration: Duration(seconds: 2),
  //         ),
  //       );
  //     }
  //   }
  // }

  Future getLeaderBoard() async {
    await EasyLoading.show(
      status: 'Loading...',
      maskType: EasyLoadingMaskType.black,
    );
    var url = Uri.parse('${apiURL}users/leaderboard');
    String? token = await storage.read(key: "token");
    http.Response response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      var jsonBody = response.body;
      var jsonData = jsonDecode(jsonBody);
      setState(() {
        data = jsonData['uservelocity'];
        var outputList = jsonData["velocitynames"] as List;
        var filteredList;
        filteredList = outputList.where((e) => e["key"] == "weight").toList();
        wgh = filteredList[0]["name"];
        filteredList = outputList.where((e) => e["key"] == "arm_pain").toList();
        armP = filteredList[0]["name"];
        filteredList =
            outputList.where((e) => e["key"] == "pull_down_velocity").toList();
        pDVel = filteredList[0]["name"];
        filteredList = outputList
            .where((e) => e["key"] == "mound_throws_velocity")
            .toList();
        mTVel = filteredList[0]["name"];
        filteredList =
            outputList.where((e) => e["key"] == "pull_down_3").toList();
        pD3 = filteredList[0]["name"];
        filteredList =
            outputList.where((e) => e["key"] == "pull_down_4").toList();
        pD4 = filteredList[0]["name"];
        filteredList =
            outputList.where((e) => e["key"] == "pull_down_5").toList();
        pD5 = filteredList[0]["name"];
        filteredList =
            outputList.where((e) => e["key"] == "pull_down_6").toList();
        pD6 = filteredList[0]["name"];
        filteredList =
            outputList.where((e) => e["key"] == "pull_down_7").toList();
        pD7 = filteredList[0]["name"];
        filteredList =
            outputList.where((e) => e["key"] == "long_toss_distance").toList();
        lTDist = filteredList[0]["name"];
        filteredList = outputList.where((e) => e["key"] == "pylo_7").toList();
        p7Lab = filteredList[0]["name"];
        filteredList = outputList.where((e) => e["key"] == "pylo_5").toList();
        p5Lab = filteredList[0]["name"];
        filteredList = outputList.where((e) => e["key"] == "pylo_3").toList();
        p3 = filteredList[0]["name"];
        filteredList = outputList.where((e) => e["key"] == "bench").toList();
        ben = filteredList[0]["name"];
        filteredList = outputList.where((e) => e["key"] == "squat").toList();
        sqt = filteredList[0]["name"];
        filteredList = outputList.where((e) => e["key"] == "deadlift").toList();
        dLift = filteredList[0]["name"];
        filteredList =
            outputList.where((e) => e["key"] == "vertical_jump").toList();
        vJump = filteredList[0]["name"];
        rowsAdd = [];
        for (var i = 0; i < jsonData['uservelocity'].length; i++) {
          rowsAdd.add(
            DataRow(
              cells: [
                DataCell(Text(jsonData['uservelocity'][i]["name"])),
                DataCell(Text("${jsonData['uservelocity'][i]["weight"]}")),
                DataCell(Text("${jsonData['uservelocity'][i]["arm_pain"]}")),
                DataCell(Text(
                    "${jsonData['uservelocity'][i]["pull_down_velocity"]}")),
                DataCell(Text(
                    "${jsonData['uservelocity'][i]["mound_throws_velocity"]}")),
                DataCell(Text("${jsonData['uservelocity'][i]["pull_down_3"]}")),
                DataCell(Text("${jsonData['uservelocity'][i]["pull_down_4"]}")),
                DataCell(Text("${jsonData['uservelocity'][i]["pull_down_5"]}")),
                DataCell(Text("${jsonData['uservelocity'][i]["pull_down_6"]}")),
                DataCell(Text("${jsonData['uservelocity'][i]["pull_down_7"]}")),
                DataCell(Text(
                    "${jsonData['uservelocity'][i]["long_toss_distance"]}")),
                DataCell(Text("${jsonData['uservelocity'][i]["pylo_7"]}")),
                DataCell(Text("${jsonData['uservelocity'][i]["pylo_5"]}")),
                DataCell(Text("${jsonData['uservelocity'][i]["pylo_3"]}")),
                DataCell(Text("${jsonData['uservelocity'][i]["bench"]}")),
                DataCell(Text("${jsonData['uservelocity'][i]["squat"]}")),
                DataCell(Text("${jsonData['uservelocity'][i]["deadlift"]}")),
                DataCell(
                    Text("${jsonData['uservelocity'][i]["vertical_jump"]}")),
              ],
            ),
          );
        }
      });
      await EasyLoading.dismiss();
    } else {
      await EasyLoading.dismiss();
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
    _controller = TextEditingController();
    getLeaderBoard();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
        centerTitle: true,
        title: const Text(
          "LeaderBoard",
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.filter_list),
        //     onPressed: () {
        //       setState(() {
        //         filter = !filter;
        //       });
        //     },
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Visibility(
              visible: filter,
              child: Form(
                key: _form,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 2.0,
                                    spreadRadius: 0.4)
                              ],
                            ),
                            child: DateTimeFormField(
                              decoration: const InputDecoration(
                                hintStyle: TextStyle(color: Colors.black),
                                errorStyle: TextStyle(color: Colors.redAccent),
                                border: InputBorder.none,
                                suffixIcon: Icon(Icons.arrow_drop_down_sharp),
                                contentPadding: EdgeInsets.all(20),
                                labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                labelText: 'Start Date',
                              ),
                              initialValue: dateTime,
                              mode: DateTimeFieldPickerMode.date,
                              autovalidateMode: AutovalidateMode.always,
                              onDateSelected: (DateTime value) {
                                // dt = DateTime.parse(formatted);
                                dateTime = value;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 2.0,
                                    spreadRadius: 0.4)
                              ],
                            ),
                            child: DateTimeFormField(
                              decoration: const InputDecoration(
                                hintStyle: TextStyle(color: Colors.black),
                                errorStyle: TextStyle(color: Colors.redAccent),
                                border: InputBorder.none,
                                suffixIcon: Icon(Icons.arrow_drop_down_sharp),
                                contentPadding: EdgeInsets.all(20),
                                labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                labelText: 'End Date',
                              ),
                              initialValue: dateTimeEnd,
                              mode: DateTimeFieldPickerMode.date,
                              autovalidateMode: AutovalidateMode.always,
                              validator: (value) {
                                if (value == null || value == "") {
                                  return "Enter end date";
                                }

                                return null;
                              },
                              onDateSelected: (DateTime value) {
                                // dt = DateTime.parse(formatted);
                                dateTimeEnd = value;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 40,
                        ),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            onPressed: () {
                              if (!(_form.currentState?.validate() ?? true)) {
                                return;
                              }
                              // filterL();
                            },
                            child: const Text("Submit"),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            onPressed: () {
                              _resetForm();
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                            child: const Text("Clear"),
                          ),
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "History",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: HexColor("#222222"),
                        ),
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      Flexible(
                        child: TextField(
                          controller: controller,
                          onChanged: onSearch,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            label: const Text("Search"),
                          ),
                          // onChanged: searchBook,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowColor: MaterialStateColor.resolveWith(
                    (states) => HexColor("#30CED9")),
                sortColumnIndex: 0,
                sortAscending: true,
                columns: [
                  const DataColumn(
                    label: Text("Name"),
                  ),
                  DataColumn(
                    label: Text(wgh),
                  ),
                  DataColumn(
                    label: Text(armP),
                  ),
                  DataColumn(
                    label: Text(pDVel),
                  ),
                  DataColumn(
                    label: Text(mTVel),
                  ),
                  DataColumn(
                    label: Text(pD3),
                  ),
                  DataColumn(
                    label: Text(pD4),
                  ),
                  DataColumn(
                    label: Text(pD5),
                  ),
                  DataColumn(
                    label: Text(pD6),
                  ),
                  DataColumn(
                    label: Text(pD7),
                  ),
                  DataColumn(
                    label: Text(lTDist),
                  ),
                  DataColumn(
                    label: Text(p7Lab),
                  ),
                  DataColumn(
                    label: Text(p5Lab),
                  ),
                  DataColumn(
                    label: Text(p3),
                  ),
                  DataColumn(
                    label: Text(ben),
                  ),
                  DataColumn(
                    label: Text(sqt),
                  ),
                  DataColumn(
                    label: Text(dLift),
                  ),
                  DataColumn(
                    label: Text(vJump),
                  ),
                ],
                rows: rowsAdd,
              ),
            )
          ],
        ),
      ),
    );
  }
}
