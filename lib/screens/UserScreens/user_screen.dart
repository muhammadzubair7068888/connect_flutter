import 'dart:convert';

import 'package:connect/screens/BottomNavBar/bottomNavBar_screen.dart';
import 'package:connect/screens/UserScreens/viewUserDetail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;

import '../../Globals/globals.dart';
import '../Track_Velocity/alertDialogWidget.dart';
import 'add_user_screen.dart';
import 'edit_user_screen.dart';

class UserDetail extends StatefulWidget {
  final String role;
  final bool removed;
  const UserDetail({
    Key? key,
    required this.role,
    required this.removed,
  }) : super(key: key);

  @override
  State<UserDetail> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  final storage = const FlutterSecureStorage();
  List<DataRow> rowsAdd = [];
  String? userName;
// --                                                               -- //
// --                          START                                -- //
// --                                                               -- //

  Future delete(int id) async {
    var uri = Uri.parse('${apiURL}users/delete/$id');
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
      getUsers();
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

  Future getUsers() async {
    await EasyLoading.show(
      status: 'Loading...',
      maskType: EasyLoadingMaskType.black,
    );
    var url = Uri.parse('${apiURL}users/all');
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
        rowsAdd = [];
        if (jsonData["data"] == []) {
          userName!.isEmpty;
        } else {
          userName = jsonData['user_name'];
        }
        for (var i = 0; i < jsonData['data'].length; i++) {
          if (jsonData['data'][i]['last_login'] == null) {
            jsonData['data'][i]['last_login'] = "";
          }
          rowsAdd.add(
            DataRow(
              cells: [
                //  DataCell(Text("${jsonData['data'][i]['id']}")),
                DataCell(Text(jsonData['data'][i]['name'])),
                DataCell(Text(jsonData['data'][i]['role'])),
                DataCell(Text(userName!)),
                DataCell(Text(jsonData['data'][i]['height'])),
                DataCell(Text(jsonData['data'][i]['starting_weight'])),
                DataCell(Text(jsonData['data'][i]['last_login'])),
                DataCell(
                  Wrap(
                    alignment: WrapAlignment.start,
                    children: [
                      SizedBox(
                        width: 30,
                        child: IconButton(
                          icon: const Icon(Icons.remove_red_eye),
                          color: Colors.black,
                          iconSize: 18,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ViewUserDetailScreen(
                                  age: jsonData['data'][i]['age'],
                                  email: jsonData['data'][i]['email'],
                                  handedness: jsonData['data'][i]['handedness'],
                                  height: jsonData['data'][i]['height'],
                                  imgUrl: jsonData['data'][i]['avatar'],
                                  lvl: jsonData['data'][i]['level'],
                                  name: jsonData['data'][i]['name'],
                                  school: jsonData['data'][i]['school'],
                                  strWeight: jsonData['data'][i]
                                      ['starting_weight'],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        width: 30,
                        child: IconButton(
                          icon: const Icon(Icons.edit),
                          color: Colors.black,
                          iconSize: 18,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditUserScreen(
                                  age: jsonData['data'][i]['age'],
                                  email: jsonData['data'][i]['email'],
                                  handedness: jsonData['data'][i]['handedness'],
                                  height: jsonData['data'][i]['height'],
                                  imgUrl: jsonData['data'][i]['avatar'],
                                  lvl: jsonData['data'][i]['level'],
                                  name: jsonData['data'][i]['name'],
                                  school: jsonData['data'][i]['school'],
                                  strWeight: jsonData['data'][i]
                                      ['starting_weight'],
                                  id: jsonData['data'][i]['id'],
                                  status:
                                      int.parse(jsonData['data'][i]['status']),
                                  role: widget.role,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        width: 30,
                        child: IconButton(
                          icon: const Icon(Icons.delete),
                          color: Colors.red,
                          iconSize: 18,
                          onPressed: () {
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
                                          borderRadius:
                                              BorderRadius.circular(10.0),
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
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
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
    getUsers();
  }

  @override
  void dispose() {
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
          "User",
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: widget.removed
              ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BottomNavBar(
                        role: widget.role,
                      ),
                    ),
                  );
                }
              : () {
                  Navigator.pop(context);
                },
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.1,
              ),

              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    maximumSize: const Size(150, 50),
                    minimumSize: const Size(150, 50),
                    primary: HexColor("#31D858"),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddUser(
                          role: widget.role,
                        ),
                      ),
                    );
                  },
                  child: const Text("Add New"),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.2,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
              ),
              // Expanded(
              //   child: ElevatedButton(
              //     style: ElevatedButton.styleFrom(
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(10.0),
              //       ),
              //     ),
              //     onPressed: () {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => const ImportUser(),
              //         ),
              //       );
              //     },
              //     child: const Text("Import CSV"),
              //   ),
              // ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.1,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      child: TextField(
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
          const SizedBox(
            height: 10,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor: MaterialStateColor.resolveWith(
                  (states) => HexColor("#30CED9")),
              sortColumnIndex: 0,
              sortAscending: true,
              columns: const [
                // DataColumn(
                //   label: Text("S.No"),
                // ),
                DataColumn(
                  label: Text("Name"),
                ),
                DataColumn(
                  label: Text("Role"),
                ),
                DataColumn(
                  label: Text("Added By"),
                ),
                DataColumn(
                  label: Text("Height"),
                ),
                DataColumn(
                  label: Text("Starting Weight"),
                ),
                DataColumn(
                  label: Text("Last Login"),
                ),
                DataColumn(
                  label: Text("  Action"),
                ),
              ],
              rows: rowsAdd,
            ),
          ),
        ],
      ),
    );
  }
}
