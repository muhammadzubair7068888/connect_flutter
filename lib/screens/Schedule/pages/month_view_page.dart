import 'package:calendar_view/calendar_view.dart';
import 'package:connect/screens/Schedule/extension.dart';
import 'package:date_field/date_field.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../create_event_page.dart';
import '../model/event.dart';
import '../widgets/month_view_widget.dart';

DateTime get _now => DateTime.now();

class MonthViewPageDemo extends StatefulWidget {
  const MonthViewPageDemo({
    Key? key,
  }) : super(key: key);

  @override
  _MonthViewPageDemoState createState() => _MonthViewPageDemoState();
}

class _MonthViewPageDemoState extends State<MonthViewPageDemo> {
  final List<CalendarEventData<Event>> _events = [
    CalendarEventData(
      date: _now,
      event: const Event(title: "Joe's Birthday"),
      title: "Project meeting",
      description: "Today is project meeting.",
      // startTime: DateTime(_now.year, _now.month, _now.day, 18, 30),
      // endTime: DateTime(_now.year, _now.month, _now.day, 22),
    ),
    CalendarEventData(
      date: _now.add(const Duration(days: 1)),
      // startTime: DateTime(_now.year, _now.month, _now.day, 18),
      // endTime: DateTime(_now.year, _now.month, _now.day, 19),
      event: const Event(title: "Wedding anniversary"),
      title: "Wedding anniversary",
      description: "Attend uncle's wedding anniversary.",
    ),
    CalendarEventData(
      date: _now,
      // startTime: DateTime(_now.year, _now.month, _now.day, 14),
      // endTime: DateTime(_now.year, _now.month, _now.day, 17),
      event: const Event(title: "Football Tournament"),
      title: "Football Tournament",
      description: "Go to football tournament.",
    ),
    CalendarEventData(
      date: _now.add(const Duration(days: 3)),
      // startTime: DateTime(_now.add(Duration(days: 3)).year,
      // _now.add(Duration(days: 3)).month, _now.add(Duration(days: 3)).day, 10),
      // endTime: DateTime(_now.add(Duration(days: 3)).year,
      // _now.add(Duration(days: 3)).month, _now.add(Duration(days: 3)).day, 14),
      event: const Event(title: "Sprint Meeting."),
      title: "Sprint Meeting.",
      description: "Last day of project submission for last year.",
    ),
    CalendarEventData(
      date: _now.subtract(const Duration(days: 2)),
      // startTime: DateTime(
      // _now.subtract(Duration(days: 2)).year,
      // _now.subtract(Duration(days: 2)).month,
      // _now.subtract(Duration(days: 2)).day,
      // 14),
      // endTime: DateTime(
      // _now.subtract(Duration(days: 2)).year,
      // _now.subtract(Duration(days: 2)).month,
      // _now.subtract(Duration(days: 2)).day,
      // 16),
      event: const Event(title: "Team Meeting"),
      title: "Team Meeting",
      description: "Team Meeting",
    ),
    CalendarEventData(
      date: _now.subtract(const Duration(days: 2)),
      // startTime: DateTime(
      // _now.subtract(Duration(days: 2)).year,
      // _now.subtract(Duration(days: 2)).month,
      // _now.subtract(Duration(days: 2)).day,
      // 10),
      // endTime: DateTime(
      // _now.subtract(Duration(days: 2)).year,
      // _now.subtract(Duration(days: 2)).month,
      // _now.subtract(Duration(days: 2)).day,
      // 12),
      event: const Event(title: "Chemistry Viva"),
      title: "Chemistry Viva",
      description: "Today is Joe's birthday.",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return CalendarControllerProvider<Event>(
      controller: EventController<Event>()..addAll(_events),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: HexColor("#30CED9"),
          elevation: 8,
          onPressed: _addEvent,
          child: const Icon(Icons.add),
        ),
        body: const MonthViewWidget(),
      ),
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
    // CalendarControllerProvider.of<Event>(context).controller.add(event);
    print(event);
  }
}
