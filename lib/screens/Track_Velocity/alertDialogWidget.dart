import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AlertDialogWidget extends StatefulWidget {
  const AlertDialogWidget({Key? key}) : super(key: key);

  @override
  State<AlertDialogWidget> createState() => _AlertDialogWidgetState();
}

class _AlertDialogWidgetState extends State<AlertDialogWidget> {
  @override
  Widget build(BuildContext context) {
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
          onPressed: () {},
          child: const Text("Yes"),
        ),
        ElevatedButton(
          onPressed: () {},
          child: const Text("No"),
        ),
      ],
      elevation: 24,
    );
  }
}
