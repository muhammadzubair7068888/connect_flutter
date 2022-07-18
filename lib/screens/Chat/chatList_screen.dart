import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'singleChatListWidget.dart';
import 'userList_screen.dart';

class ChatListScreen extends StatefulWidget {
  final String? urC;
  final String currentName;
  const ChatListScreen({
    Key? key,
    required this.urC,
    required this.currentName,
  }) : super(key: key);

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: const Text("Messages"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserListScreen(
                    urC: widget.urC,
                    currentName: widget.currentName,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Column(
        children: [
          SingleChatListScreen(
            urC: widget.urC,
            currentName: widget.currentName,
          ),
        ],
      ),
    );
  }
}
