import 'dart:convert';
import 'dart:math';
import 'package:connect/screens/Chat/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import '../../Globals/globals.dart';
import 'model/message_model.dart';

class ChatScreen extends StatefulWidget {
  final String? urC;
  final int group;
  final String id;
  const ChatScreen({
    Key? key,
    required this.group,
    required this.id,
    required this.urC,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final storage = const FlutterSecureStorage();
  String name = "";
  final TextEditingController _textController = new TextEditingController();
  String ur = "";
  int online = 0;
  bool load = true;
  String last = "";
  String mess = "";
  int? currentUser;

  List<Message> messages = [];

  Future getChat() async {
    var url = Uri.parse('${apiURL}users/${widget.id}/conversation');
    String? token = await storage.read(key: "token");
    http.Response response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      var jsonBody = response.body;
      var jsonData = jsonDecode(jsonBody);
      var data = jsonData["data"];
      if (mounted) {
        setState(() {
          currentUser = data["user"]["id"];
          name = data["user"]["name"];
          online = data["user"]["is_online"];
          ur = data["user"]["avatar"];
          load = false;
          messages = [];
          for (var i = 0; i < data["conversations"].length; i++) {
            String hello = TimeOfDay.fromDateTime(DateTime.now().subtract(
                    Duration(
                        minutes: data["conversations"][i]
                            ["time_from_now_in_min"])))
                .toString();
            String ello = hello.substring(10);
            last = ello.substring(0, ello.length - 1);
            messages.add(
              Message(
                id: data["conversations"][i]["receiver"]["id"],
                imageUrl: data["conversations"][i]["sender"]["avatar"],
                time: last,
                text: data["conversations"][i]["message"],
              ),
            );
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

  Future getGroupChat() async {
    var url = Uri.parse('${apiURL}users/${widget.id}/conversation');
    String? token = await storage.read(key: "token");
    http.Response response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      var jsonBody = response.body;
      var jsonData = jsonDecode(jsonBody);
      var data = jsonData["data"];
      if (mounted) {
        setState(() {
          currentUser = data["group"]["created_by_user"]["id"];
          name = data["user"]["name"];
          online = data["user"]["is_online"];
          ur = data["user"]["avatar"];
          load = false;
          messages = [];
          for (var i = 0; i < data["conversations"].length; i++) {
            String hello = TimeOfDay.fromDateTime(DateTime.now().subtract(
                    Duration(
                        minutes: data["conversations"][i]
                            ["time_from_now_in_min"])))
                .toString();
            String ello = hello.substring(10);
            last = ello.substring(0, ello.length - 1);
            messages.add(
              Message(
                id: data["conversations"][i]["receiver"]["id"],
                imageUrl: data["conversations"][i]["sender"]["avatar"],
                time: last,
                text: data["conversations"][i]["message"],
              ),
            );
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

  Future addTrack() async {
    var uri = Uri.parse('${apiURL}send-message');
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
    request.fields['to_id'] = widget.id;
    request.fields['is_archive_chat'] = 0.toString();
    request.fields['message'] = mess;
    request.fields['is_my_contact'] = 1.toString();
    request.fields['is_group'] = 0.toString();
    request.fields['time'] = last;
    request.fields['senderName'] = name;
    request.fields['senderImg'] = widget.urC.toString();
    request.fields['randomMsgId'] = Random().nextInt(100).toString();
    request.fields['replyMessage'] = "";
    request.fields['receiverName'] = "";
    var response = await request.send();
    // var responseDecode = await http.Response.fromStream(response);
    if (response.statusCode == 200) {
      // final result = jsonDecode(responseDecode.body);
      // final result = jsonDecode(responseDecode.body) as Map<String, dynamic>;

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

  _chatBubble(Message message, bool isMe, bool isSameUser) {
    if (isMe) {
      return Column(
        children: [
          Container(
            alignment: Alignment.topRight,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.80,
              ),
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                  )
                ],
              ),
              child: Text(
                message.text,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          !isSameUser
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      message.time,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black45,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      decoration:
                          BoxDecoration(shape: BoxShape.circle, boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                        )
                      ]),
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(message.imageUrl),
                      ),
                    ),
                  ],
                )
              : Container(child: null),
        ],
      );
    } else {
      return Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.80,
              ),
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                  )
                ],
              ),
              child: Text(
                message.text,
                style: const TextStyle(
                  color: Colors.black54,
                ),
              ),
            ),
          ),
          !isSameUser
              ? Row(
                  children: [
                    Container(
                      decoration:
                          BoxDecoration(shape: BoxShape.circle, boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                        )
                      ]),
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(message.imageUrl),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      message.time,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black45,
                      ),
                    )
                  ],
                )
              : Container(child: null),
        ],
      );
    }
  }

  _sendMessageArea() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      height: 70,
      color: Colors.white,
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.file_open),
            iconSize: 25,
            color: Theme.of(context).primaryColor,
          ),
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: const InputDecoration.collapsed(
                  hintText: "Send a message .."),
              textCapitalization: TextCapitalization.sentences,
              onChanged: (value) {
                mess = value;
              },
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                _textController.clear();
                String hello = TimeOfDay.fromDateTime(
                        DateTime.now().subtract(const Duration(minutes: 1)))
                    .toString();
                String ello = hello.substring(10);
                last = ello.substring(0, ello.length - 1);
                messages.insert(
                  0,
                  Message(
                    id: currentUser!,
                    imageUrl: widget.urC!,
                    time: last,
                    text: mess,
                  ),
                );
                addTrack();
              });
            },
            icon: const Icon(Icons.send),
            iconSize: 25,
            color: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.group == 0) {
      getChat();
    } else {
      getGroupChat();
    }
  }

  @override
  Widget build(BuildContext context) {
    int? prevUserId;
    return load
        ? const Center(
            child: SizedBox(
              width: 200,
              height: 200,
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Colors.white, // red as border color
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.all(1),
                        child: ClipOval(
                          child: ur != null || ur != ""
                              ? Image.network(
                                  ur,
                                  fit: BoxFit.cover,
                                  width: 40.0,
                                  height: 40.0,
                                )
                              : null,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(name),
                  const SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    child: online == 1
                        ? const Icon(
                            Icons.circle,
                            color: Color.fromARGB(255, 4, 245, 12),
                            size: 10,
                          )
                        : null,
                  ),
                ],
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    padding: const EdgeInsets.all(20),
                    itemCount: messages.length,
                    itemBuilder: (BuildContext context, int index) {
                      final Message message = messages[index];
                      final bool isMe = message.id == currentUser;
                      final bool isSameUser = prevUserId == message.id;
                      prevUserId = message.id;
                      return _chatBubble(message, isMe, isSameUser);
                    },
                  ),
                ),
                _sendMessageArea(),
              ],
            ),
          );
  }
}

class Message {
  final String time;
  final String text;
  final int id;
  final String imageUrl;

  Message({
    required this.time,
    required this.text,
    required this.id,
    required this.imageUrl,
  });
}
