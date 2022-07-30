// ignore_for_file: file_names

import 'package:flutter/material.dart';

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

class AlertDialogueCopy extends StatefulWidget {
  const AlertDialogueCopy({Key? key}) : super(key: key);

  @override
  State<AlertDialogueCopy> createState() => _AlertDialogueCopyState();
}

class _AlertDialogueCopyState extends State<AlertDialogueCopy> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      title: Column(
        children: const [
          Icon(
            Icons.file_copy,
            size: 30,
            color: Colors.red,
          )
        ],
      ),
      content: const Text(
        "Are you sure want to duplicate this?",
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
