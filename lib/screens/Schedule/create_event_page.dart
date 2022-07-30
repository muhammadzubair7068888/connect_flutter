import 'package:connect/screens/Schedule/extension.dart';
import 'package:flutter/material.dart';

import 'widgets/add_event_widget.dart';

class CreateEventPage extends StatefulWidget {
  final bool withDuration;
  final List schedule;
  final String userId;
  final String role;
  final String username;

  const CreateEventPage({
    Key? key,
    this.withDuration = false,
    required this.username,
    required this.schedule,
    required this.role,
    required this.userId,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CreateEventPageState createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
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
          "Add Event",
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: AddEventWidget(
          onEventAdd: context.pop,
          schedule: widget.schedule,
          userId: widget.userId,
          role: widget.role,
          username: widget.username,
        ),
      ),
    );
  }
}
