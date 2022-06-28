import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:http/http.dart' as http;
import 'package:hexcolor/hexcolor.dart';
import '../../Globals/globals.dart';

class AssessmentScreen extends StatefulWidget {
  const AssessmentScreen({Key? key}) : super(key: key);

  @override
  State<AssessmentScreen> createState() => _AssessmentScreenState();
}

class _AssessmentScreenState extends State<AssessmentScreen> {
  final GlobalKey<FormState> _form = GlobalKey();
  final storage = const FlutterSecureStorage();
  String? label;
  String? type = "Physical";
  List data = [];
  List<DataRow> rowsAdd = [];
  List<int> groupValue = [];
  List dataM = [];
  List<DataRow> rowsAddM = [];
  List<int> groupValueM = [];

  void _resetForm() {
    _form.currentState?.reset();
  }

// --                                                               -- //
// --                          START                                -- //
// --                                                               -- //
  Future addAsses() async {
    var uri = type == "Physical"
        ? Uri.parse('${apiURL}assessment/physical/add')
        : Uri.parse('${apiURL}assessment/mechanical/add');
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
    request.fields['label'] = label!;
    var response = await request.send();
    // var responseDecode = await http.Response.fromStream(response);
    if (response.statusCode == 200) {
      // final result = jsonDecode(responseDecode.body);
      // final result = jsonDecode(responseDecode.body) as Map<String, dynamic>;
      FocusManager.instance.primaryFocus?.unfocus();
      _resetForm();
      if (type == "Physical") {
        getPhyAsses("show");
      } else {
        getMechAsses("show");
      }
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

  Future getPhyAsses(String loading) async {
    await EasyLoading.show(
      status: 'Loading...',
      maskType: EasyLoadingMaskType.black,
    );
    var url = Uri.parse('${apiURL}assessment/physical/index');
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
          data = jsonData["data"];
        });
        if (loading == "show") {
          await EasyLoading.dismiss();
        }
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

  Future getMechAsses(String loading) async {
    if (loading == "show") {
      await EasyLoading.show(
        status: 'Loading...',
        maskType: EasyLoadingMaskType.black,
      );
    }
    var url = Uri.parse('${apiURL}assessment/mechanical/index');
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
          dataM = jsonData["data"];
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

  Future deletePhy(int id) async {
    var uri = Uri.parse('${apiURL}assessment/physical/del');
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
    request.fields['physical_id'] = id.toString();
    var response = await request.send();
    // var responseDecode = await http.Response.fromStream(response);
    if (response.statusCode == 200) {
      // final result = jsonDecode(responseDecode.body);
      // final result = jsonDecode(responseDecode.body) as Map<String, dynamic>;
      getPhyAsses("show");
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

  Future deleteMech(int id) async {
    var uri = Uri.parse('${apiURL}assessment/mechanical/del');
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
    request.fields['mechanical_id'] = id.toString();
    var response = await request.send();
    // var responseDecode = await http.Response.fromStream(response);
    if (response.statusCode == 200) {
      // final result = jsonDecode(responseDecode.body);
      // final result = jsonDecode(responseDecode.body) as Map<String, dynamic>;
      getMechAsses("show");
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
    getPhyAsses("hide");
    getMechAsses("hide");
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Form(
            key: _form,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 30, 15, 0),
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
                    child: DropdownSearch<String>(
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          hintStyle: TextStyle(color: Colors.black),
                          errorStyle: TextStyle(color: Colors.redAccent),
                          border: InputBorder.none,
                          suffixIcon: Icon(Icons.arrow_drop_down_sharp),
                          contentPadding: EdgeInsets.all(20),
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                          labelText: 'Select Type',
                        ),
                      ),
                      popupProps: const PopupProps.menu(
                        showSelectedItems: true,
                        // disabledItemFn: (String s) => s.startsWith('I'),
                      ),
                      items: const [
                        "Physical",
                        "Mechanical",
                      ],
                      selectedItem: type,
                      onChanged: (value) {
                        type = value;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 30, 15, 0),
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
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(20),
                        labelText: 'Enter label',
                      ),
                      validator: (value) {
                        if (value == null || value == "") {
                          return "Please enter label.";
                        }

                        return null;
                      },
                      onChanged: (value) {
                        label = value;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 30, 15, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Respond to button press
                          if (!(_form.currentState?.validate() ?? true)) return;
                          addAsses();
                        },
                        style: ElevatedButton.styleFrom(
                          maximumSize: const Size(150, 50),
                          minimumSize: const Size(150, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
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
                          FocusManager.instance.primaryFocus?.unfocus();
                          _resetForm();
                        },
                        style: ElevatedButton.styleFrom(
                          maximumSize: const Size(150, 50),
                          minimumSize: const Size(150, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
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
                      DataColumn(
                        label: Text("  Action"),
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
                              DataCell(
                                Wrap(
                                  alignment: WrapAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 25,
                                      child: IconButton(
                                        icon: const Icon(Icons.delete),
                                        color: Colors.red,
                                        onPressed: () {
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
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      deletePhy(data[i]['id']);
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text("Yes"),
                                                  ),
                                                  ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
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
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ],
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
                      DataColumn(
                        label: Text("  Action"),
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
                              DataCell(
                                Wrap(
                                  alignment: WrapAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 25,
                                      child: IconButton(
                                        icon: const Icon(Icons.delete),
                                        color: Colors.red,
                                        onPressed: () {
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
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      deleteMech(
                                                          dataM[i]['id']);
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text("Yes"),
                                                  ),
                                                  ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
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
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ],
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
        ],
      ),
    );
  }
}
