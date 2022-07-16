import 'package:connect/screens/Schedule/extension.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'widgets/add_event_widget.dart';
import 'widgets/edit_event_widget.dart';

class EditEventPage extends StatefulWidget {
  final bool withDuration;
  final String title;
  final List schedule;
  final String userId;
  final String desc;
  final String role;
  final String username;
  final int id;
  const EditEventPage({
    Key? key,
    required this.desc,
    required this.schedule,
    required this.role,
    required this.userId,
    required this.username,
    required this.id,
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
          username: widget.username,
          title: widget.title,
          role: widget.role,
          schedule: widget.schedule,
          userId: widget.userId,
          id: widget.id,
          desc: widget.desc,
        ),
      ),
    );
  }
}
