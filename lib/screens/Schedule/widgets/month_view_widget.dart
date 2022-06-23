// ignore_for_file: use_build_context_synchronously

import 'package:calendar_view/calendar_view.dart';
import 'package:connect/screens/Schedule/extension.dart';
import 'package:flutter/material.dart';

import '../edit_event_page.dart';
import '../model/event.dart';
import '../pages/dayPlan_screen.dart';

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
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              actionsAlignment: MainAxisAlignment.center,
              title: const Text(
                "Edit/Delete or View?",
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
                      // CalendarControllerProvider.of<Event>(context)
                      //     .controller
                      //     .remove(event);
                      // CalendarControllerProvider.of<Event>(context)
                      //     .controller
                      //     .add(events);
                      Navigator.pop(context);
                    }

                    _editEvent();
                  },
                  child: const Text("Edit"),
                ),
                ElevatedButton(
                  onPressed: () {
                    EventController<Event>().remove(event);
                    Navigator.pop(context);
                  },
                  child: const Text("Delete"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DayPlanScreen(),
                      ),
                    );
                  },
                  child: const Text("View"),
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
