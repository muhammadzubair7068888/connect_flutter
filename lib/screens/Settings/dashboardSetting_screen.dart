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
  List all = [];
  List<String> name = [];
  List<int> groupValue = [];
  List<int> id = [];

  Future getPhyAsses() async {
    // await EasyLoading.show(
    //   status: 'Loading...',
    //   maskType: EasyLoadingMaskType.black,
    // );
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
        print(data);
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

  @override
  void initState() {
    super.initState();
    getPhyAsses();
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
                      // for (var i = 0; i < 1; i++) {
                      String key = data[i]["key"];
                      int val = int.parse(data[i]["status"]);
                      groupValue.add(val);
                      id.add(data[i]["id"]);
                      name.add(data[i]["name"]);
                      rowsAdd.add(
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    border: const OutlineInputBorder(),
                                    labelText: key,
                                  ),
                                  validator: (value) {
                                    if (value == null || value == "") {
                                      return "Required";
                                    }
                                    return null;
                                  },
                                  initialValue: name[i],
                                  onChanged: (value) {
                                    setState(() {
                                      name[i] = value;
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
                                      groupValue: groupValue[i],
                                      onChanged: (value) => {
                                        setState(
                                          () {
                                            groupValue[i] = 1;
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
                                      groupValue: groupValue[i],
                                      onChanged: (value) => {
                                        setState(
                                          () {
                                            groupValue[i] = 0;
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
                        print(name);
                        print(groupValue);
                        print(id);
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
