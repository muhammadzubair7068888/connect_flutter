// ignore_for_file: unnecessary_const

import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../Globals/globals.dart';
import 'questAns_screen.dart';

class Questioneries extends StatefulWidget {
  const Questioneries({Key? key}) : super(key: key);

  @override
  State<Questioneries> createState() => _QuestioneriesState();
}

class _QuestioneriesState extends State<Questioneries> {
  final GlobalKey<FormState> _form = GlobalKey();
  late TextEditingController _controller;
  final storage = const FlutterSecureStorage();
  String? question;
  List<DataRow> rowsAdd = [];

  List data = [];
  List search = [];
  TextEditingController controller = TextEditingController();
  List<bool> groupValue = [];
  bool isSwitched = false;
  onSearch(String text) async {
    search.clear();
    if (text.isEmpty) {
      getQs();
    }

    for (var f in data) {
      if (f["name"].contains(text)) {
        search.add(f);
      }
    }
    setState(() {
      if (search.isNotEmpty) {
        rowsAdd.clear();
        for (var i = 0; i < search.length; i++) {
          rowsAdd.add(
            DataRow(
              cells: [
                DataCell(
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuestionAnswer(
                            id: search[i]["id"],
                            question: search[i]["name"],
                          ),
                        ),
                      );
                    },
                    child: Wrap(
                      children: [
                        Text(search[i]["name"]),
                      ],
                    ),
                  ),
                ),
                DataCell(
                  Wrap(
                    children: [
                      Switch(
                        value: groupValue[i],
                        onChanged: (value) {
                          setState(() {
                            groupValue[i] = value;
                            if (groupValue[i]) {
                              updateStatus(search[i]["id"], 1);
                            } else {
                              updateStatus(search[i]["id"], 0);
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),
                DataCell(
                  const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            actionsAlignment: MainAxisAlignment.center,
                            title: Column(
                              children: const [
                                Image(
                                  image: AssetImage("images/delete.png"),
                                  width: 30,
                                  height: 30,
                                ),
                              ],
                            ),
                            content: const Text(
                              "Are you sure want to delete?",
                              textAlign: TextAlign.center,
                            ),
                            actions: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                onPressed: () {
                                  delete(search[i]['id']);
                                  Navigator.pop(context);
                                },
                                child: const Text("Yes"),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("No"),
                              ),
                            ],
                            elevation: 24,
                          );
                        });
                  },
                ),
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
  Future addQs() async {
    var uri = Uri.parse('${apiURL}questionnaire/save');
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
    request.fields['question'] = question!;
    var response = await request.send();
    // var responseDecode = await http.Response.fromStream(response);
    if (response.statusCode == 200) {
      // final result = jsonDecode(responseDecode.body);
      // final result = jsonDecode(responseDecode.body) as Map<String, dynamic>;
      FocusManager.instance.primaryFocus?.unfocus();
      _resetForm();
      getQs();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: HexColor("#30CED9"),
            dismissDirection: DismissDirection.vertical,
            content: const Text('Added successfully'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
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

  Future updateStatus(int id, int status) async {
    var uri = Uri.parse('${apiURL}questionnaire/status');
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
      FocusManager.instance.primaryFocus?.unfocus();
      _resetForm();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: HexColor("#30CED9"),
            dismissDirection: DismissDirection.vertical,
            content: const Text('Updated successfully'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
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

  Future delete(int id) async {
    var uri = Uri.parse('${apiURL}questionnaire/del/$id');
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
    var response = await request.send();
    // var responseDecode = await http.Response.fromStream(response);
    if (response.statusCode == 200) {
      // final result = jsonDecode(responseDecode.body);
      // final result = jsonDecode(responseDecode.body) as Map<String, dynamic>;
      getQs();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: HexColor("#30CED9"),
            dismissDirection: DismissDirection.vertical,
            content: const Text('Deleted successfully'),
            duration: const Duration(seconds: 2),
          ),
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

  Future getQs() async {
    await EasyLoading.show(
      status: 'Loading...',
      maskType: EasyLoadingMaskType.black,
    );
    var url = Uri.parse('${apiURL}questionnaire/index');
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
          data = [];
          groupValue = [];
          rowsAdd = [];
          data = jsonData['data'];
        });
      }
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
    getQs();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
          "Questionnaire",
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "New Question",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Form(
              key: _form,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: "Question",
                  ),
                  controller: _controller,
                  validator: (value) {
                    if (value == null || value == "") {
                      return "Please enter weight";
                    }

                    return null;
                  },
                  onChanged: (value) {
                    question = value;
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Respond to button press
                      if (!(_form.currentState?.validate() ?? true)) {
                        return;
                      }
                      addQs();
                    },
                    style: ElevatedButton.styleFrom(
                      maximumSize: const Size(150, 50),
                      minimumSize: const Size(150, 50),
                      primary: HexColor("#31D858"),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Respond to button press
                      _resetForm();
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    style: ElevatedButton.styleFrom(
                      maximumSize: const Size(150, 50),
                      minimumSize: const Size(150, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Clear',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
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
                ],
              ),
            ),
            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                constraints: BoxConstraints(
                  minWidth:
                      MediaQuery.of(context).size.width * 1, // minimum width
                ),
                child: DataTable(
                  headingRowColor: MaterialStateColor.resolveWith(
                    (states) => HexColor("#30CED9"),
                  ),
                  sortColumnIndex: 0,
                  sortAscending: true,
                  columns: const [
                    DataColumn(
                      label: Text("Question"),
                    ),
                    DataColumn(
                      label: Text("Ans on Daily / One time"),
                    ),
                    DataColumn(
                      label: Text("Action"),
                    ),
                  ],
                  rows: () {
                    // groupValue.clear();
                    rowsAdd.clear();
                    for (var i = 0; i < data.length; i++) {
                      int val = int.parse(data[i]["status"]);
                      groupValue.add(val == 1 ? true : false);
                      rowsAdd.add(
                        DataRow(
                          cells: [
                            DataCell(
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => QuestionAnswer(
                                        id: data[i]["id"],
                                        question: data[i]["name"],
                                      ),
                                    ),
                                  );
                                },
                                child: Wrap(
                                  children: [
                                    Text(
                                      data[i]["name"],
                                      style:
                                          const TextStyle(color: Colors.blue),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            DataCell(
                              Wrap(
                                children: [
                                  Switch(
                                    value: groupValue[i],
                                    onChanged: (value) {
                                      setState(() {
                                        groupValue[i] = value;
                                        if (groupValue[i]) {
                                          updateStatus(data[i]["id"], 1);
                                        } else {
                                          updateStatus(data[i]["id"], 0);
                                        }
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            DataCell(
                              const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        actionsAlignment:
                                            MainAxisAlignment.center,
                                        title: Column(
                                          children: const [
                                            Image(
                                              image: AssetImage(
                                                  "images/delete.png"),
                                              width: 30,
                                              height: 30,
                                            ),
                                          ],
                                        ),
                                        content: const Text(
                                          "Are you sure want to delete?",
                                          textAlign: TextAlign.center,
                                        ),
                                        actions: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                            ),
                                            onPressed: () {
                                              delete(data[i]['id']);
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Yes"),
                                          ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text("No"),
                                          ),
                                        ],
                                        elevation: 24,
                                      );
                                    });
                              },
                            ),
                          ],
                        ),
                      );
                    }
                    return rowsAdd;
                  }(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
