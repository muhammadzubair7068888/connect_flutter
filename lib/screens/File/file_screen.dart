import 'dart:io';

import 'package:connect/screens/Track_Velocity/alertDialogWidget.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../Globals/globals.dart';

class FileScreen extends StatefulWidget {
  const FileScreen({Key? key}) : super(key: key);

  @override
  State<FileScreen> createState() => _FileScreenState();
}

class _FileScreenState extends State<FileScreen> {
  final storage = const FlutterSecureStorage();
  PlatformFile? file;
  String fileName = "";
  String title = "";
  bool visible = false;

  Future addQs() async {
    var uri = Uri.parse('${apiURL}files/index');
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
    if (file != null) {
      request.files.add(await http.MultipartFile.fromPath('file', file!.path!));
    }
    // request.fields['question'] = question!;
    var response = await request.send();
    // var responseDecode = await http.Response.fromStream(response);
    if (response.statusCode == 200) {
      // final result = jsonDecode(responseDecode.body);
      // final result = jsonDecode(responseDecode.body) as Map<String, dynamic>;
      FocusManager.instance.primaryFocus?.unfocus();
      // _resetForm();
      // getQs();
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
          "Files",
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
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Visibility(
                    visible: visible,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(10),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  labelText: "Title",
                                ),
                                onChanged: (value) {
                                  title = value;
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(10),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  labelText: "File Name",
                                ),
                                enabled: false,
                                initialValue: fileName,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          final result = await FilePicker.platform
                              .pickFiles(type: FileType.any);
                          if (result == null) return;
                          setState(() {
                            file = result.files.first;
                            fileName = file!.name;
                            visible = true;
                          });
                          print(file!.path);
                          print(file!.name);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: HexColor("#13D13F"),
                        ),
                        child: const Text("Select File"),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(),
                        child: const Text("Upload File"),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Uploaded Files",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: HexColor("#222222"),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
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
                            contentPadding:
                                EdgeInsets.only(left: 20, top: 10, bottom: 10),
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            labelText: 'Select User',
                          ),
                        ),
                        popupProps: const PopupProps.menu(
                          showSelectedItems: true,
                          // disabledItemFn: (String s) => s.startsWith('I'),
                        ),
                        items: const [
                          "Adam",
                          "John",
                          "Katty",
                          'Ariana',
                        ],
                        onChanged: print,
                        selectedItem: "Adam",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                constraints: BoxConstraints(
                  minWidth:
                      MediaQuery.of(context).size.width * 1, // minimum width
                ),
                child: DataTable(
                  headingRowColor: MaterialStateColor.resolveWith(
                      (states) => HexColor("#30CED9")),
                  sortColumnIndex: 0,
                  sortAscending: true,
                  columns: const [
                    DataColumn(
                      label: Text("Title"),
                    ),
                    DataColumn(
                      label: Text("Filename"),
                    ),
                    DataColumn(
                      label: Text("  Action"),
                    ),
                  ],
                  rows: [
                    DataRow(
                      cells: [
                        const DataCell(Text("Test")),
                        const DataCell(Text("schedule.webm")),
                        DataCell(
                          Wrap(
                            alignment: WrapAlignment.start,
                            children: [
                              SizedBox(
                                width: 25,
                                child: IconButton(
                                  icon: const Icon(Icons.remove_red_eye),
                                  color: Colors.black,
                                  onPressed: () {},
                                ),
                              ),
                              SizedBox(
                                width: 25,
                                child: IconButton(
                                  icon: const Icon(Icons.delete),
                                  color: Colors.red,
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return const AlertDialogWidget();
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
                    DataRow(
                      cells: [
                        const DataCell(Text("Test")),
                        const DataCell(Text("schedule.webm")),
                        DataCell(
                          Wrap(
                            alignment: WrapAlignment.start,
                            children: [
                              SizedBox(
                                width: 25,
                                child: IconButton(
                                  icon: const Icon(Icons.remove_red_eye),
                                  color: Colors.black,
                                  onPressed: () {},
                                ),
                              ),
                              SizedBox(
                                width: 15,
                                child: IconButton(
                                  icon: const Icon(Icons.delete),
                                  color: Colors.red,
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return const AlertDialogWidget();
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
                    DataRow(
                      cells: [
                        const DataCell(Text("Test")),
                        const DataCell(Text("schedule.webm")),
                        DataCell(
                          Wrap(
                            alignment: WrapAlignment.start,
                            children: [
                              SizedBox(
                                width: 25,
                                child: IconButton(
                                  icon: const Icon(Icons.remove_red_eye),
                                  color: Colors.black,
                                  onPressed: () {},
                                ),
                              ),
                              SizedBox(
                                width: 15,
                                child: IconButton(
                                  icon: const Icon(Icons.delete),
                                  color: Colors.red,
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return const AlertDialogWidget();
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
                    DataRow(
                      cells: [
                        const DataCell(Text("Test")),
                        const DataCell(Text("schedule.webm")),
                        DataCell(
                          Wrap(
                            alignment: WrapAlignment.start,
                            children: [
                              SizedBox(
                                width: 25,
                                child: IconButton(
                                  icon: const Icon(Icons.remove_red_eye),
                                  color: Colors.black,
                                  onPressed: () {},
                                ),
                              ),
                              SizedBox(
                                width: 15,
                                child: IconButton(
                                  icon: const Icon(Icons.delete),
                                  color: Colors.red,
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return const AlertDialogWidget();
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
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void dropdownCallback(int? selectedValue) {
    if (selectedValue is int) {
      setState(() {});
      print(selectedValue);
    }
  }
}

// The "soruce" of the table
