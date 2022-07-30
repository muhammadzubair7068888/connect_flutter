// ignore_for_file: file_names, must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;

import '../../Globals/globals.dart';

class ViewUserDetailScreen extends StatefulWidget {
  final String? imgUrl;
  String name;
  String height;
  String email;
  String strWeight;
  String handedness;
  int age;
  int id;
  String school;
  String lvl;
  ViewUserDetailScreen({
    Key? key,
    required this.imgUrl,
    required this.name,
    required this.id,
    required this.height,
    required this.email,
    required this.strWeight,
    required this.handedness,
    required this.age,
    required this.school,
    required this.lvl,
  }) : super(key: key);

  @override
  State<ViewUserDetailScreen> createState() => _ViewUserDetailScreenState();
}

class _ViewUserDetailScreenState extends State<ViewUserDetailScreen> {
  final storage = const FlutterSecureStorage();
  List<DataRow> rowsAdd = [];
  List<DataRow> rowsAddQ = [];
  List<DataRow> rowsAddM = [];
  List data = [];
  List dataM = [];
  List<int> groupValue = [];
  List<int> groupValueM = [];

// --                                                               -- //
// --                          START                                -- //
// --                                                               -- //
  Future getPhyAsses() async {
    await EasyLoading.show(
      status: 'Loading...',
      maskType: EasyLoadingMaskType.black,
    );
    var url = Uri.parse('${apiURL}users/view/${widget.id}');
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
        setState(() {
          rowsAddQ = [];
          data = jsonData["data"]["physical_assessment"];
          dataM = jsonData["data"]["mechanical_assessment"];
          for (var i = 0; i < jsonData['data']["question"].length; i++) {
            rowsAddQ.add(
              DataRow(
                cells: [
                  DataCell(
                    Wrap(
                      children: [
                        Text(jsonData['data']["question"][i]["name"]),
                      ],
                    ),
                  ),
                  DataCell(
                    Wrap(
                      children: const [
                        Text(""),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        });
        await EasyLoading.dismiss();
      }
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

  Future updatePhyAss(int id, int status) async {
    var uri = Uri.parse('${apiURL}assessment/physical/update');
    String? token = await storage.read(key: "token");
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var request = http.MultipartRequest(
      'POST',
      uri,
    )..headers.addAll(headers);
    request.fields['id'] = id.toString();
    request.fields['status'] = status.toString();
    var response = await request.send();
    // var responseDecode = await http.Response.fromStream(response);
    if (response.statusCode == 200) {
      // final result = jsonDecode(responseDecode.body);
      // final result = jsonDecode(responseDecode.body) as Map<String, dynamic>;
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

  Future updateMechAss(int id, int status) async {
    var uri = Uri.parse('${apiURL}assessment/mechanical/update');
    String? token = await storage.read(key: "token");
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var request = http.MultipartRequest(
      'POST',
      uri,
    )..headers.addAll(headers);
    request.fields['id'] = id.toString();
    request.fields['status'] = status.toString();
    var response = await request.send();
    // var responseDecode = await http.Response.fromStream(response);
    if (response.statusCode == 200) {
      // final result = jsonDecode(responseDecode.body);
      // final result = jsonDecode(responseDecode.body) as Map<String, dynamic>;
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
    getPhyAsses();
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
          "User",
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: widget.imgUrl == null
                        ? CircleAvatar(
                            radius: 60.0,
                            backgroundColor: Colors.grey[300],
                          )
                        : CircleAvatar(
                            radius: 60.0,
                            child: ClipOval(
                              child: Image.network(
                                // '$publicUrl${widget.imgUrl}',
                                '${widget.imgUrl}',
                                width: 120.0,
                                height: 120.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: SizedBox(
                          width: 120,
                          child: TextField(
                            enabled: false,
                            controller: TextEditingController()
                              ..text = widget.name.toString(),
                            onChanged: (value) {
                              widget.name = value;
                            },
                            autofocus: false,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10),
                              labelText: 'Name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 120,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          enabled: false,
                          controller: TextEditingController()
                            ..text = widget.height.toString(),
                          onChanged: (value) {
                            widget.height = value;
                          },
                          decoration: InputDecoration(
                            labelText: "Height",
                            contentPadding: const EdgeInsets.all(10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: TextField(
                      enabled: false,
                      controller: TextEditingController()
                        ..text = widget.email.toString(),
                      onChanged: (value) {
                        widget.email = value;
                      },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "Email",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 140,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            enabled: false,
                            controller: TextEditingController()
                              ..text = widget.strWeight.toString(),
                            onChanged: (value) {
                              widget.strWeight = value;
                            },
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelText: "Starting Weight",
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 140,
                          child: TextField(
                            enabled: false,
                            controller: TextEditingController()
                              ..text = widget.handedness.toString(),
                            onChanged: (value) {
                              widget.handedness = value;
                            },
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelText: "Handedness",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 140,
                          child: TextField(
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelText: "Age",
                            ),
                            keyboardType: TextInputType.number,
                            enabled: false,
                            controller: TextEditingController()
                              ..text = widget.age.toString(),
                            onChanged: (value) {
                              widget.age = value as int;
                            },
                          ),
                        ),
                        SizedBox(
                          width: 140,
                          child: TextField(
                            enabled: false,
                            controller: TextEditingController()
                              ..text = widget.school.toString(),
                            onChanged: (value) {
                              widget.school = value;
                            },
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelText: "School",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: TextField(
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "Level",
                      ),
                      keyboardType: TextInputType.number,
                      enabled: false,
                      controller: TextEditingController()
                        ..text = widget.lvl.toString(),
                      onChanged: (value) {
                        widget.lvl = value;
                      },
                    ),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
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
                              "Physical Assessment",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                                color: HexColor("#222222"),
                              ),
                            ),
                          ],
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
                      columns: const [
                        DataColumn(
                          label: Text("Assessments"),
                        ),
                        DataColumn(
                          label: Text("Acceptable"),
                        ),
                        DataColumn(
                          label: Text("Caution"),
                        ),
                        DataColumn(
                          label: Text("Opportunity"),
                        ),
                      ],
                      rows: () {
                        rowsAdd.clear();
                        for (var i = 0; i < data.length; i++) {
                          String name = data[i]["name"];
                          int val = int.parse(data[i]["status"]);
                          groupValue.add(val);
                          rowsAdd.add(
                            DataRow(
                              cells: [
                                DataCell(Text(name)),
                                DataCell(
                                  RadioButton(
                                    description: "",
                                    value: 1,
                                    groupValue: groupValue[i],
                                    onChanged: (value) => {
                                      setState(
                                        () {
                                          groupValue[i] = 1;
                                        },
                                      ),
                                      updatePhyAss(data[i]["id"], 1),
                                    },
                                    textPosition: RadioButtonTextPosition.right,
                                  ),
                                ),
                                DataCell(
                                  RadioButton(
                                    description: "",
                                    value: 2,
                                    groupValue: groupValue[i],
                                    onChanged: (value) => {
                                      setState(
                                        () => groupValue[i] = 2,
                                      ),
                                      updatePhyAss(data[i]["id"], 2),
                                    },
                                    textPosition: RadioButtonTextPosition.right,
                                  ),
                                ),
                                DataCell(
                                  RadioButton(
                                    description: "",
                                    value: 3,
                                    groupValue: groupValue[i],
                                    onChanged: (value) => {
                                      setState(
                                        () => groupValue[i] = 3,
                                      ),
                                      updatePhyAss(data[i]["id"], 3),
                                    },
                                    textPosition: RadioButtonTextPosition.right,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        return rowsAdd;
                      }(),
                    ),
                  )
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
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
                              "Mechanical Assessments",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                                color: HexColor("#222222"),
                              ),
                            ),
                          ],
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
                      columns: const [
                        DataColumn(
                          label: Text("Assessments"),
                        ),
                        DataColumn(
                          label: Text("Acceptable"),
                        ),
                        DataColumn(
                          label: Text("Caution"),
                        ),
                        DataColumn(
                          label: Text("Opportunity"),
                        ),
                      ],
                      rows: () {
                        rowsAddM.clear();
                        for (var i = 0; i < dataM.length; i++) {
                          String name = dataM[i]["name"];
                          int val = int.parse(dataM[i]["status"]);
                          groupValueM.add(val);
                          rowsAddM.add(
                            DataRow(
                              cells: [
                                DataCell(Text(name)),
                                DataCell(
                                  RadioButton(
                                    description: "",
                                    value: 1,
                                    groupValue: groupValueM[i],
                                    onChanged: (value) => {
                                      setState(
                                        () {
                                          groupValueM[i] = 1;
                                        },
                                      ),
                                      updateMechAss(dataM[i]["id"], 1),
                                    },
                                    textPosition: RadioButtonTextPosition.right,
                                  ),
                                ),
                                DataCell(
                                  RadioButton(
                                    description: "",
                                    value: 2,
                                    groupValue: groupValueM[i],
                                    onChanged: (value) => {
                                      setState(
                                        () => groupValueM[i] = 2,
                                      ),
                                      updateMechAss(dataM[i]["id"], 2),
                                    },
                                    textPosition: RadioButtonTextPosition.right,
                                  ),
                                ),
                                DataCell(
                                  RadioButton(
                                    description: "",
                                    value: 3,
                                    groupValue: groupValueM[i],
                                    onChanged: (value) => {
                                      setState(
                                        () => groupValueM[i] = 3,
                                      ),
                                      updateMechAss(dataM[i]["id"], 3),
                                    },
                                    textPosition: RadioButtonTextPosition.right,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        return rowsAddM;
                      }(),
                    ),
                  )
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
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
                              "Questionnaire",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                                color: HexColor("#222222"),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      constraints: BoxConstraints(
                        minWidth: MediaQuery.of(context).size.width *
                            1, // minimum width
                      ),
                      child: DataTable(
                        headingRowColor: MaterialStateColor.resolveWith(
                            (states) => HexColor("#30CED9")),
                        sortColumnIndex: 0,
                        sortAscending: true,
                        columns: const [
                          DataColumn(
                            label: Text("Question"),
                          ),
                          DataColumn(
                            label: Text("Answer"),
                          ),
                        ],
                        rows: rowsAddQ,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
