import 'package:connect/screens/Schedule/extension.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'widgets/add_event_widget.dart';
import 'widgets/edit_event_widget.dart';

class EditEventPage extends StatefulWidget {
  final bool withDuration;
  final String title;
  const EditEventPage({
    Key? key,
    this.withDuration = false,
    required this.title,
  }) : super(key: key);

  @override
  _EditEventPageState createState() => _EditEventPageState();
}

class _EditEventPageState extends State<EditEventPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
        centerTitle: true,
        title: const Text(
          "Edit Event",
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: context.pop,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: EditEventWidget(
          onEventAdd: context.pop,
          title: widget.title,
        ),
      ),
    );
  }
}
