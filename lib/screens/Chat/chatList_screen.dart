// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'package:connect/screens/BottomNavBar/bottomNavBar_screen.dart';

import 'singleChatListWidget.dart';
import 'userList_screen.dart';

class ChatListScreen extends StatefulWidget {
  final String? token;
  final String? id;
  final String? urC;
  final String currentName;
  final String role;
  final int? index;
  final String? i;
  final String? u;
  const ChatListScreen({
    Key? key,
    required this.token,
    required this.id,
    required this.urC,
    required this.currentName,
    required this.role,
    required this.index,
    required this.i,
    required this.u,
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
            // Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BottomNavBar(
                  i: widget.i,
                  index: widget.index,
                  role: widget.role,
                  u: widget.u,
                ),
              ),
            );
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
                    id: widget.id,
                    token: widget.token,
                    urC: widget.urC,
                    currentName: widget.currentName,
                    i: widget.i,
                    index: widget.index,
                    role: widget.role,
                    u: widget.u,
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
            id: widget.id,
            token: widget.token,
          ),
        ],
      ),
    );
  }
}
