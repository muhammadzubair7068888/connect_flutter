import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import '../../Globals/globals.dart';
import 'chat_screen.dart';
import 'createGroup_screen.dart';

class UserListScreen extends StatefulWidget {
  final String? urC;
  final String currentName;
  const UserListScreen({
    Key? key,
    required this.urC,
    required this.currentName,
  }) : super(key: key);

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  TextEditingController controller = TextEditingController();
  final storage = const FlutterSecureStorage();
  List<Widget> rowsAdd = <Widget>[];
  List data = [];
  List search = [];
  bool load = true;

  onSearch(String text) async {
    search.clear();
    if (text.isEmpty) {
      getUsers();
    }

    for (var f in data) {
      if (f["name"].contains(text)) {
        search.add(f);
      }
    }
    setState(
      () {
        if (search.isNotEmpty) {
          rowsAdd = [];
          for (var i = 0; i < search.length; i++) {
            rowsAdd.add(
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: ListTile(
                      leading: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color:
                                    HexColor("#30CED9"), // red as border color
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.transparent,
                              child: Padding(
                                padding: const EdgeInsets.all(1),
                                child: ClipOval(
                                  child: search[i]['avatar'] != null ||
                                          search[i]['avatar'] != ""
                                      ? Image.network(
                                          search[i]['avatar'],
                                          fit: BoxFit.cover,
                                          width: 60.0,
                                          height: 60.0,
                                        )
                                      : null,
                                ),
                              ),
                            ),
                          ),
                          const Positioned(
                            bottom: 5,
                            child: Icon(
                              Icons.circle,
                              color: Colors.green,
                              size: 12,
                            ),
                          ),
                        ],
                      ),
                      title: Text(search[i]['name']),
                    ),
                  ),
                ],
              ),
            );
          }
        }
      },
    );
  }

  Future getUsers() async {
    var url = Uri.parse('${apiURL}users-list');
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
        data = jsonData['data']["users"];
        rowsAdd = [];
        for (var i = 0; i < jsonData['data']["users"].length; i++) {
          rowsAdd.add(
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatScreen(
                            group: 0,
                            id: data[i]["id"].toString(),
                            urC: widget.urC,
                            isMyContact: false,
                            currentName: widget.currentName,
                          ),
                        ),
                      );
                    },
                    leading: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: HexColor("#30CED9"), // red as border color
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.transparent,
                            child: Padding(
                              padding: const EdgeInsets.all(1),
                              child: ClipOval(
                                child: jsonData['data']['users'][i]['avatar'] !=
                                            null ||
                                        jsonData['data']['users'][i]
                                                ['avatar'] !=
                                            ""
                                    ? Image.network(
                                        jsonData['data']['users'][i]['avatar'],
                                        fit: BoxFit.cover,
                                        width: 60.0,
                                        height: 60.0,
                                      )
                                    : null,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 5,
                          child: data[i]['is_online'] == 1
                              ? const Icon(
                                  Icons.circle,
                                  color: Colors.green,
                                  size: 12,
                                )
                              : const SizedBox(),
                        ),
                      ],
                    ),
                    title: Text(jsonData['data']['users'][i]['name']),
                  ),
                ),
              ],
            ),
          );
        }
        load = false;
      });
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

  @override
  void initState() {
    super.initState();
    getUsers();
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
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CreateGroupScreen(
                    imgUrl:
                        'http://192.168.1.30/connect_laravel/public/assets/chat/images/group-img.png',
                  ),
                ),
              );
            },
            icon: const Icon(Icons.group_add),
          ),
        ],
      ),
      body: load
          ? Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                ),
                const Center(
                  child: SizedBox(
                    width: 200,
                    height: 200,
                    child: CircularProgressIndicator(),
                  ),
                ),
              ],
            )
          : Column(
              children: [
                TextField(
                  controller: controller,
                  onChanged: onSearch,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    border: UnderlineInputBorder(),
                    label: Text("Search"),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: rowsAdd,
                )
              ],
            ),
    );
  }
}
