import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'groupChatListWidget.dart';
import 'singleChatListWidget.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({Key? key}) : super(key: key);

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  int _selecIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    const SingleChatListScreen(),
    const GroupChatListScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              // Navigator.pop(context);
            },
          ),
          flexibleSpace: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                decoration: _selecIndex == 0
                    ? BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 3,
                            color: HexColor("#BEEFF2"),
                          ),
                        ),
                      )
                    : null,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _selecIndex = 0;
                    });
                  },
                  child: const Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        "Messages",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                decoration: _selecIndex == 1
                    ? BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 3,
                            color: HexColor("#BEEFF2"),
                          ),
                        ),
                      )
                    : null,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _selecIndex = 1;
                    });
                  },
                  child: const Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        "Group",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          _widgetOptions[_selecIndex],
        ],
      ),
    );
  }
}
