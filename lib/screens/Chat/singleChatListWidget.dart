import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class SingleChatListScreen extends StatefulWidget {
  const SingleChatListScreen({Key? key}) : super(key: key);

  @override
  State<SingleChatListScreen> createState() => _SingleChatListScreenState();
}

class _SingleChatListScreenState extends State<SingleChatListScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Stack(
            children: const [
              CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(
                    'https://www.woolha.com/media/2020/03/eevee.png'),
              ),
              Positioned(
                bottom: 0,
                child: Icon(
                  Icons.circle,
                  color: Colors.green,
                  size: 10,
                ),
              ),
            ],
          ),
          title: const Text('Etham Walker'),
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
