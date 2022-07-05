import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;

import '../../Globals/globals.dart';

class DashboardSettingScreen extends StatefulWidget {
  const DashboardSettingScreen({Key? key}) : super(key: key);

  @override
  State<DashboardSettingScreen> createState() => _DashboardSettingScreenState();
}

class _DashboardSettingScreenState extends State<DashboardSettingScreen> {
  final storage = const FlutterSecureStorage();
  final GlobalKey<FormState> _form = GlobalKey();
  List data = [];
  List<Widget> rowsAdd = [];
  List<Object> list = [];

// --                                                               -- //
// --                          START                                -- //
// --                                                               -- //
  Future getGraphSettings() async {
    await EasyLoading.show(
      status: 'Loading...',
      maskType: EasyLoadingMaskType.black,
    );
    var url = Uri.parse('${apiURL}site/setting');
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
        for (var i = 0; i < data.length; i++) {
          list.add(
            Object(
              id: data[i]["id"],
              name: data[i]["name"],
              key: data[i]["key"],
              placeholder: data[i]["placeholder"],
              status: int.parse(data[i]["status"]),
              label: data[i]["label"],
            ),
          );
        }
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

  Future addTrack() async {
    await EasyLoading.show(
      status: 'Loading...',
      maskType: EasyLoadingMaskType.black,
    );
    var uri = Uri.parse('${apiURL}velocity/graph/settings');
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
    for (var i = 0; i < list.length; i++) {
      request.fields[list[i].label] = list[i].name;
      request.fields[list[i].key] = list[i].status.toString();
    }
    var response = await request.send();
    // var responseDecode = await http.Response.fromStream(response);
    if (response.statusCode == 200) {
      await EasyLoading.dismiss();
      // final result = jsonDecode(responseDecode.body);
      // final result = jsonDecode(responseDecode.body) as Map<String, dynamic>;
      FocusManager.instance.primaryFocus?.unfocus();
      // getTracks();
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
      await EasyLoading.dismiss();
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
    getGraphSettings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#FFFFFF"),
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
        centerTitle: true,
        title: const Text(
          "Settings",
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
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Dashboard Graphs",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                Column(
                  children: () {
                    rowsAdd.clear();
                    for (var i = 0; i < data.length; i++) {
                      rowsAdd.add(
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    border: const OutlineInputBorder(),
                                    labelText: list[i].placeholder,
                                  ),
                                  validator: (value) {
                                    if (value == null || value == "") {
                                      return "Required";
                                    }
                                    return null;
                                  },
                                  initialValue: list[i].name,
                                  onChanged: (value) {
                                    setState(() {
                                      list[i].name = value;
                                    });
                                  },
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text("Yes"),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: RadioButton(
                                      description: "",
                                      value: 1,
                                      groupValue: list[i].status,
                                      onChanged: (value) => {
                                        setState(
                                          () {
                                            list[i].status = 1;
                                          },
                                        ),
                                      },
                                      textPosition:
                                          RadioButtonTextPosition.right,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("No"),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: RadioButton(
                                      description: "",
                                      value: 0,
                                      groupValue: list[i].status,
                                      onChanged: (value) => {
                                        setState(
                                          () {
                                            list[i].status = 0;
                                          },
                                        ),
                                      },
                                      textPosition:
                                          RadioButtonTextPosition.right,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    return rowsAdd;
                  }(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: SizedBox(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(45),
                        primary: HexColor("#30CED9"),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      onPressed: () {
                        if (!(_form.currentState?.validate() ?? true)) {
                          return;
                        }
                        print(list.length);
                        addTrack();
                      },
                      child: const Text(
                        "Update",
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Object {
  late int id;
  late String name;
  late String key;
  late String label;
  late String placeholder;
  late int status;

  Object({
    required this.id,
    required this.name,
    required this.key,
    required this.label,
    required this.placeholder,
    required this.status,
  });

  @override
  String toString() {
    return '{id: $id, name: $name, key: $key, label: $label, placeholder: $placeholder, status: $status}';
  }
}
