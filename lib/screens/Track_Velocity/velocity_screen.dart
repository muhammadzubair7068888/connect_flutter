import 'dart:convert';

import 'package:date_field/date_field.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;

import '../../Globals/globals.dart';

class VelocityScreen extends StatefulWidget {
  const VelocityScreen({Key? key}) : super(key: key);

  @override
  State<VelocityScreen> createState() => _VelocityScreenState();
}

class _VelocityScreenState extends State<VelocityScreen> {
  final GlobalKey<FormState> _form = GlobalKey();
  late TextEditingController _controller;
  DateTime dateTime = DateTime.now();
  String velocity = "Weight";
  String values = "";
  List<String> velocities = [];
  bool filter = false;
  final storage = const FlutterSecureStorage();
  List<DataRow> rowsAdd = [];

  List data = [];
  List search = [];
  TextEditingController controller = TextEditingController();
  onSearch(String text) async {
    search.clear();
    if (text.isEmpty) {
      getUserVelocities();
    }

    for (var f in data) {
      if (f["value"].contains(text) ||
          f["date"].contains(text) ||
          f['velocity_type']['name'].contains(text)) {
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
                DataCell(Text(search[i]['date'])),
                DataCell(Text(search[i]['velocity_type']['name'])),
                DataCell(Text("${search[i]['value']}")),
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
                      },
                    );
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
  Future getVelocities() async {
    var url = Uri.parse('${apiURL}velocity/velocities');
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
          for (var i = 0; i < jsonData['data'].length; i++) {
            velocities.add(jsonData['data'][i]["name"]);
          }
        });
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

  Future getUserVelocities() async {
    await EasyLoading.show(
      status: 'Loading...',
      maskType: EasyLoadingMaskType.black,
    );
    var url = Uri.parse('${apiURL}velocity/user_velocities');
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
          data = jsonData['data'];
          rowsAdd = [];
          for (var i = 0; i < jsonData['data'].length; i++) {
            rowsAdd.add(
              DataRow(
                cells: [
                  DataCell(Text(jsonData['data'][i]['date'])),
                  DataCell(Text(jsonData['data'][i]['velocity_type']['name'])),
                  DataCell(Text("${jsonData['data'][i]['value']}")),
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
                                  delete(jsonData['data'][i]['id']);
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
                        },
                      );
                    },
                  ),
                ],
              ),
            );
          }
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

  Future delete(int id) async {
    var uri = Uri.parse('${apiURL}velocity/del');
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
    request.fields['velocity_id'] = id.toString();
    var response = await request.send();
    // var responseDecode = await http.Response.fromStream(response);
    if (response.statusCode == 200) {
      // final result = jsonDecode(responseDecode.body);
      // final result = jsonDecode(responseDecode.body) as Map<String, dynamic>;
      getUserVelocities();
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

  Future addVelocity() async {
    var uri = Uri.parse('${apiURL}velocity/index');
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
    request.fields['date'] = dateTime.toString();
    request.fields['velocity_type'] = velocity;
    request.fields['value'] = values;
    var response = await request.send();
    // var responseDecode = await http.Response.fromStream(response);
    if (response.statusCode == 200) {
      // final result = jsonDecode(responseDecode.body);
      // final result = jsonDecode(responseDecode.body) as Map<String, dynamic>;
      FocusManager.instance.primaryFocus?.unfocus();
      _resetForm();
      getUserVelocities();
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
// --                                                               -- //
// --                           END                                 -- //
// --                                                               -- //

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    getVelocities();
    getUserVelocities();
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
          "Velocity",
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              setState(() {
                filter = !filter;
              });
            },
          ),
        ],
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
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Velocity",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: HexColor("#222222"),
                          ),
                        ),
                      ),
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
                                labelText: 'Date',
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
                            child: DropdownSearch<String>(
                              dropdownDecoratorProps:
                                  const DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  hintStyle: TextStyle(color: Colors.black),
                                  errorStyle:
                                      TextStyle(color: Colors.redAccent),
                                  border: InputBorder.none,
                                  suffixIcon: Icon(Icons.arrow_drop_down_sharp),
                                  contentPadding:
                                      EdgeInsets.fromLTRB(20, 10, 20, 10),
                                  labelStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                  labelText: 'Velocity Type',
                                ),
                              ),
                              popupProps: const PopupProps.menu(
                                showSelectedItems: true,
                                // disabledItemFn: (String s) => s.startsWith('I'),
                              ),
                              items: velocities,
                              onChanged: (value) {
                                velocity = value!;
                              },
                              selectedItem: velocity,
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
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'Value',
                                contentPadding: EdgeInsets.only(left: 20),
                                border: InputBorder.none,
                              ),
                              controller: _controller,
                              validator: (value) {
                                if (value == null || value == "") {
                                  return "Please enter value";
                                }

                                return null;
                              },
                              onChanged: (value) {
                                values = value;
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
                              addVelocity();
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
                    label: Text("Date"),
                  ),
                  DataColumn(
                    label: Text("Velocity Type"),
                  ),
                  DataColumn(
                    label: Text("Value"),
                  ),
                  DataColumn(
                    label: Text("Action"),
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
