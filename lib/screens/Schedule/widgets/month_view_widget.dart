import 'package:calendar_view/calendar_view.dart';
import 'package:connect/screens/Schedule/extension.dart';
import 'package:flutter/material.dart';

import '../edit_event_page.dart';
import '../model/event.dart';

class MonthViewWidget extends StatefulWidget {
  final GlobalKey<MonthViewState>? state;
  final double? width;

  const MonthViewWidget({
    Key? key,
    this.state,
    this.width,
  }) : super(key: key);

  @override
  State<MonthViewWidget> createState() => _MonthViewWidgetState();
}

class _MonthViewWidgetState extends State<MonthViewWidget> {
  @override
  Widget build(BuildContext context) {
    return MonthView<Event>(
      key: widget.state,
      width: widget.width,
      onEventTap: (event, date) {
        print(event.date);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              actionsAlignment: MainAxisAlignment.center,
              title: const Text(
                "Edit or Delete Event?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Future<void> _editEvent() async {
                      final events =
                          await context.pushRoute<CalendarEventData<Event>>(
                        EditEventPage(
                          withDuration: true,
                          title: event.title,
                        ),
                      );
                      if (events == null) return;
                      CalendarControllerProvider.of<Event>(context)
                          .controller
                          .remove(event);
                      CalendarControllerProvider.of<Event>(context)
                          .controller
                          .add(events);
                      Navigator.pop(context);
                    }

                    _editEvent();
                  },
                  child: const Text("Edit"),
                ),
                ElevatedButton(
                  onPressed: () {
                    CalendarControllerProvider.of<Event>(context)
                        .controller
                        .remove(event);
                    Navigator.pop(context);
                  },
                  child: const Text("Delete"),
                ),
              ],
              elevation: 24,
            );
          },
        );
      },
    );
  }
}
