import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;

import '../../Globals/globals.dart';
import 'chat_screen.dart';

class SingleChatListScreen extends StatefulWidget {
  final String? urC;
  final String currentName;
  const SingleChatListScreen({
    Key? key,
    required this.urC,
    required this.currentName,
  }) : super(key: key);

  @override
  State<SingleChatListScreen> createState() => _SingleChatListScreenState();
}

class _SingleChatListScreenState extends State<SingleChatListScreen> {
  final storage = const FlutterSecureStorage();
  List<Widget> rowsAdd = <Widget>[];
  String text = "";
  String last = "";
  int online = 0;
  bool load = true;

  Future getConversations() async {
    var url = Uri.parse('${apiURL}conversations');
    String? token = await storage.read(key: "token");
    http.Response response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      var jsonBody = response.body;
      var jsonData = jsonDecode(jsonBody);
      var data = jsonData['data']["conversations"];
      if (mounted) {
        setState(() {
          rowsAdd = [];
          for (var i = 0; i < data.length; i++) {
            if (data[i]["group_id"] != "0") {
              text = data[i]["group"]["name"];
              for (var l = 0; l < data[i]["group"]["users"].length; l++) {
                if (data[i]["group"]["users"][l]["is_online"] == 1) {
                  setState(() {
                    online = 1;
                  });
                }
              }
            }
            String hello = TimeOfDay.fromDateTime(DateTime.now().subtract(
                    Duration(minutes: data[i]["time_from_now_in_min"])))
                .toString();
            String ello = hello.substring(10);
            last = ello.substring(0, ello.length - 1);
            rowsAdd.add(
              Column(
                children: [
                  data[i]["is_group"] == 0
                      ? ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatScreen(
                                  group: data[i]["is_group"],
                                  id: data[i]["user_id"],
                                  urC: widget.urC,
                                  isMyContact: data[i]["is_my_contact"],
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
                                    color: HexColor(
                                        "#30CED9"), // red as border color
                                  ),
                                ),
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.transparent,
                                  child: Padding(
                                    padding: const EdgeInsets.all(1),
                                    child: ClipOval(
                                      child: data[i]["user"]['avatar'] !=
                                                  null &&
                                              data[i]["user"]['avatar'] != ""
                                          ? Image.network(
                                              data[i]["user"]['avatar'],
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
                                child: data[i]["user"]['is_online'] == 1
                                    ? const Icon(
                                        Icons.circle,
                                        color: Colors.green,
                                        size: 12,
                                      )
                                    : const SizedBox(),
                              ),
                            ],
                          ),
                          title: Text(data[i]["user"]['name']),
                          subtitle: Text(data[i]["message"]),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                last,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              SizedBox(
                                child: data[i]["unread_count"] != "0" &&
                                        data[i]["unread_count"] != null
                                    ? Container(
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(20),
                                          ),
                                          color: HexColor("#30CED9"),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              8, 5, 8, 5),
                                          child: Text(
                                            "${data[i]["unread_count"]}",
                                            style: const TextStyle(
                                              fontSize: 10,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      )
                                    : null,
                              ),
                            ],
                          ),
                        )
                      : ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatScreen(
                                  group: data[i]["is_group"],
                                  id: data[i]["group_id"],
                                  urC: widget.urC,
                                  isMyContact: true,
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
                                    color: HexColor(
                                        "#30CED9"), // red as border color
                                  ),
                                ),
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.transparent,
                                  child: Padding(
                                    padding: const EdgeInsets.all(1),
                                    child: ClipOval(
                                      child: data[i]["group"]['avatar'] !=
                                                  null &&
                                              data[i]["group"]['avatar'] != ""
                                          ? Image.network(
                                              data[i]["group"]['avatar'],
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
                                child: online == 1
                                    ? const Icon(
                                        Icons.circle,
                                        color: Colors.green,
                                        size: 12,
                                      )
                                    : const SizedBox(),
                              ),
                            ],
                          ),
                          title: Text(text),
                          subtitle: Text(data[i]["message"]),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                last,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              SizedBox(
                                child: data[i]["unread_count"] != "0" &&
                                        data[i]["unread_count"] != null
                                    ? Container(
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(20),
                                          ),
                                          color: HexColor("#30CED9"),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              8, 5, 8, 5),
                                          child: Text(
                                            "${data[i]["unread_count"]}",
                                            style: const TextStyle(
                                              fontSize: 10,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      )
                                    : null,
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            );
          }
          load = false;
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

  @override
  void initState() {
    super.initState();
    getConversations();
  }

  @override
  Widget build(BuildContext context) {
    return load
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
            children: rowsAdd,
          );
  }
}
