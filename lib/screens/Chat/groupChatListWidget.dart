import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class GroupChatListScreen extends StatefulWidget {
  const GroupChatListScreen({Key? key}) : super(key: key);

  @override
  State<GroupChatListScreen> createState() => _GroupChatListScreenState();
}

class _GroupChatListScreenState extends State<GroupChatListScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(
            Icons.group,
            size: 40,
          ),
          title: const Text('Etham, Adam'),
          subtitle: const Text('Hey when are you doing?'),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "9:45AM",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                  color: HexColor("#30CED9"),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    "10",
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
