import 'package:calendar_view/calendar_view.dart';
import 'package:connect/screens/Schedule/extension.dart';
import 'package:flutter/material.dart';

import '../create_event_page.dart';
import '../model/event.dart';
import '../widgets/month_view_widget.dart';

class MonthViewPageDemo extends StatefulWidget {
  const MonthViewPageDemo({
    Key? key,
  }) : super(key: key);

  @override
  _MonthViewPageDemoState createState() => _MonthViewPageDemoState();
}

class _MonthViewPageDemoState extends State<MonthViewPageDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        elevation: 8,
        onPressed: _addEvent,
      ),
      body: const MonthViewWidget(),
    );
  }

  Future<void> _addEvent() async {
    final event = await context.pushRoute<CalendarEventData<Event>>(
      const CreateEventPage(
        withDuration: true,
      ),
    );
    if (event == null) return;
    // ignore: use_build_context_synchronously
    CalendarControllerProvider.of<Event>(context).controller.add(event);
  }
}
