// ignore_for_file: file_names

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class ShareDialogWidget extends StatefulWidget {
  const ShareDialogWidget({Key? key}) : super(key: key);

  @override
  State<ShareDialogWidget> createState() => _ShareDialogWidgetState();
}

class _ShareDialogWidgetState extends State<ShareDialogWidget> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      title: Column(
        children: const [
          Text(
            "Share Exercise",
            textAlign: TextAlign.center,
          ),
        ],
      ),
      content: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: const [
            BoxShadow(color: Colors.grey, blurRadius: 2.0, spreadRadius: 0.4)
          ],
        ),
        child: DropdownSearch<String>(
          dropdownDecoratorProps: const DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              hintStyle: TextStyle(color: Colors.black),
              errorStyle: TextStyle(color: Colors.redAccent),
              border: InputBorder.none,
              suffixIcon: Icon(Icons.arrow_drop_down_sharp),
              contentPadding: EdgeInsets.all(10),
              labelStyle:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              labelText: 'Select User',
            ),
          ),
          popupProps: const PopupProps.menu(
            showSelectedItems: true,
            // disabledItemFn: (String s) => s.startsWith('I'),
          ),
          items: const [
            "Adam",
            "John",
            "Katty",
            'Ariana',
          ],
          onChanged: print,
          // selectedItem: "Brazil",
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {},
          child: const Text("Save"),
        ),
        ElevatedButton(
          onPressed: () {},
          child: const Text("Close"),
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
