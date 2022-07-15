import 'package:connect/screens/Schedule/extension.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'widgets/add_event_widget.dart';

class CreateEventPage extends StatefulWidget {
  final bool withDuration;
  final List schedule;

  const CreateEventPage({
    Key? key,
    this.withDuration = false,
    required this.schedule,
  }) : super(key: key);

  @override
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
        ),
      ),
    );
  }
}
