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
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: false,
        leading: IconButton(
          onPressed: context.pop,
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.black,
          ),
        ),
        title: const Text(
          "Edit Event",
          style: TextStyle(
            color: AppColors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
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
