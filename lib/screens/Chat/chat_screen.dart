import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_pusher_client/flutter_pusher.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:laravel_echo/laravel_echo.dart';
import '../../Globals/api_constants.dart';
import '../../Globals/globals.dart';

class ChatScreen extends StatefulWidget {
  final String? urC;
  final bool isMyContact;
  final int group;
  final String id;
  final String currentName;
  final String? token;
  final String? currentid;
  const ChatScreen({
    Key? key,
    required this.group,
    required this.isMyContact,
    required this.id,
    required this.currentName,
    required this.urC,
    required this.token,
    required this.currentid,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final storage = const FlutterSecureStorage();
  String name = "";
  String senderName = "";
  final TextEditingController _textController = TextEditingController();
  String ur = "";
  int online = 0;
  bool load = true;
  bool read = true;
  String last = "";
  String mess = "";
  int? currentUser;

  var ids = [];
  List<Message> messages = [];

  late FlutterPusher pusherClient;
  late Echo echo;

  void onConnectionStateChange(ConnectionStateChange event) {
    print("STATE:${event.currentState}");
    if (event.currentState == 'CONNECTED') {
      print('connected');
    } else if (event.currentState == 'DISCONNECTED') {
      print('disconnected');
    }
  }

  void _setUpEcho() {
    // final token = Prefer.prefs.getString('token');

    pusherClient = getPusherClient(widget.token!);

    echo = echoSetup(widget.token!, pusherClient);

    pusherClient.connect(onConnectionStateChange: onConnectionStateChange);

    echo.private("user.${widget.currentid}").listen(
          "UserEvent",
          (e) => {
            if (e["type"] == 2)
              {
                print("e.message"),
                print(e),
                if (mounted)
                  {
                    setState(() {
                      ids.add(e["id"]);
                      String hello = TimeOfDay.fromDateTime(DateTime.now()
                              .subtract(
                                  Duration(minutes: e["time_from_now_in_min"])))
                          .toString();
                      String ello = hello.substring(10);
                      last = ello.substring(0, ello.length - 1);
                      messages.insert(
                        0,
                        Message(
                          id: e["from_id"],
                          imageUrl: e["sender"]["avatar"].toString(),
                          time: last.toString(),
                          text: e["message"].toString(),
                        ),
                      );
                      readMessages(true);
                    })
                  }
              }

            // getConversations(),
          },
        );
  }

  Future getChat() async {
    var url = Uri.parse('${apiURL}users/${widget.id}/conversation');
    String? token = await storage.read(key: "token");
    String? id = await storage.read(key: "id");
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
          currentUser = int.parse(id!);
          name = data["user"]["name"];
          online = data["user"]["is_online"];
          ur = data["user"]["avatar"];

          messages = [];
          for (var i = 0; i < data["conversations"].length; i++) {
            ids.add(data["conversations"][i]["id"]);
            String hello = TimeOfDay.fromDateTime(
              DateTime.now().subtract(
                Duration(
                  minutes: data["conversations"][i]["time_from_now_in_min"],
                ),
              ),
            ).toString();
            String ello = hello.substring(10);
            last = ello.substring(0, ello.length - 1);
            messages.add(
              Message(
                id: data["conversations"][i]["sender"]["id"],
                imageUrl: data["conversations"][i]["sender"]["avatar"],
                time: last,
                text: data["conversations"][i]["message"],
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

  Future getGroupChat() async {
    var url = Uri.parse('${apiURL}users/${widget.id}/conversation?is_group=1');
    String? token = await storage.read(key: "token");
    String? id = await storage.read(key: "id");
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
          currentUser = int.parse(id!);
          name = data["group"]["name"];
          for (var l = 0; l < data["group"]["users"].length; l++) {
            if (data["group"]["users"][l]["is_online"] == 1) {
              setState(() {
                online = 1;
              });
            }
          }

          ur = data["group"]["avatar"];
          messages = [];
          for (var i = 0; i < data["conversations"].length; i++) {
            ids.add(data["conversations"][i]["id"]);
            if (data["conversations"][i]["from_id"] != null) {
              String hello = TimeOfDay.fromDateTime(
                DateTime.now().subtract(
                  Duration(
                    minutes: data["conversations"][i]["time_from_now_in_min"],
                  ),
                ),
              ).toString();
              String ello = hello.substring(10);
              last = ello.substring(0, ello.length - 1);
              messages.add(
                Message(
                  id: data["conversations"][i]["sender"]["id"],
                  imageUrl: data["conversations"][i]["sender"]["avatar"],
                  time: last,
                  text: data["conversations"][i]["message"],
                ),
              );
            } else {}
          }
          print(ids);
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

  Future readMessages(bool read) async {
    if (read) {
      var uri = Uri.parse('${apiURL}read-message');
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
      for (int item in ids) {
        request.files
            .add(http.MultipartFile.fromString('ids[]', item.toString()));
      }
      request.fields['is_group'] = widget.group.toString();
      request.fields['group_id'] = widget.id;
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
  }

  Future sendMessage() async {
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
    // widget.isMyContact bool value is passed statically from group chat list and user list
    request.fields['is_my_contact'] = widget.isMyContact.toString();
    request.fields['is_group'] = widget.group.toString();
    request.fields['time'] = last;
    request.fields['senderName'] = widget.currentName;
    request.fields['senderImg'] = widget.urC.toString();
    request.fields['randomMsgId'] = (Random().nextInt(9000) + 1000).toString();
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
            child: FocusScope(
              child: Focus(
                onFocusChange: (focus) {
                  readMessages(read);
                  if (mounted) {
                    setState(() {
                      read = false;
                    });
                  }
                },
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
            ),
          ),
          IconButton(
            onPressed: () {
              if (mounted) {
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
                  sendMessage();
                });
              }
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
    _setUpEcho();
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
