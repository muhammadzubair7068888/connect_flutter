import 'package:connect/screens/Exercises/exercises_type_screen.dart';
import 'package:connect/screens/Questionieries/questioneries_screen.dart';
import 'package:connect/screens/Track_Velocity/track_screen.dart';
import 'package:connect/screens/Track_Velocity/velocity_screen.dart';
import 'package:connect/screens/UserScreens/user_detail_screen.dart';
import 'package:connect/screens/leaderboard/leader_board_screen.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'screens/SignIn_TermConditions_Welcome/welcome_screen.dart';

// DateTime get _now => DateTime.now();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return
        // CalendarControllerProvider<Event>(
        //   controller: EventController<Event>()..addAll(_events),
        //   child:
        MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: HexColor("#FFFFFF"),
        errorColor: Colors.red,
        colorScheme:
            ThemeData().colorScheme.copyWith(primary: HexColor("#30CED9")),
      ),
      home: const WelcomeScreen(),
    );
    // );
  }
}

// This is the code that will be used to generate the events.
// List<CalendarEventData<Event>> _events = [
//   CalendarEventData(
//     date: _now,
//     event: const Event(title: "Joe's Birthday"),
//     title: "Project meeting",
//     description: "Today is project meeting.",
//     // startTime: DateTime(_now.year, _now.month, _now.day, 18, 30),
//     // endTime: DateTime(_now.year, _now.month, _now.day, 22),
//   ),
//   CalendarEventData(
//     date: _now.add(const Duration(days: 1)),
//     // startTime: DateTime(_now.year, _now.month, _now.day, 18),
//     // endTime: DateTime(_now.year, _now.month, _now.day, 19),
//     event: const Event(title: "Wedding anniversary"),
//     title: "Wedding anniversary",
//     description: "Attend uncle's wedding anniversary.",
//   ),
//   CalendarEventData(
//     date: _now,
//     // startTime: DateTime(_now.year, _now.month, _now.day, 14),
//     // endTime: DateTime(_now.year, _now.month, _now.day, 17),
//     event: const Event(title: "Football Tournament"),
//     title: "Football Tournament",
//     description: "Go to football tournament.",
//   ),
//   CalendarEventData(
//     date: _now.add(const Duration(days: 3)),
//     // startTime: DateTime(_now.add(Duration(days: 3)).year,
//     // _now.add(Duration(days: 3)).month, _now.add(Duration(days: 3)).day, 10),
//     // endTime: DateTime(_now.add(Duration(days: 3)).year,
//     // _now.add(Duration(days: 3)).month, _now.add(Duration(days: 3)).day, 14),
//     event: const Event(title: "Sprint Meeting."),
//     title: "Sprint Meeting.",
//     description: "Last day of project submission for last year.",
//   ),
//   CalendarEventData(
//     date: _now.subtract(const Duration(days: 2)),
//     // startTime: DateTime(
//     // _now.subtract(Duration(days: 2)).year,
//     // _now.subtract(Duration(days: 2)).month,
//     // _now.subtract(Duration(days: 2)).day,
//     // 14),
//     // endTime: DateTime(
//     // _now.subtract(Duration(days: 2)).year,
//     // _now.subtract(Duration(days: 2)).month,
//     // _now.subtract(Duration(days: 2)).day,
//     // 16),
//     event: const Event(title: "Team Meeting"),
//     title: "Team Meeting",
//     description: "Team Meeting",
//   ),
//   CalendarEventData(
//     date: _now.subtract(const Duration(days: 2)),
//     // startTime: DateTime(
//     // _now.subtract(Duration(days: 2)).year,
//     // _now.subtract(Duration(days: 2)).month,
//     // _now.subtract(Duration(days: 2)).day,
//     // 10),
//     // endTime: DateTime(
//     // _now.subtract(Duration(days: 2)).year,
//     // _now.subtract(Duration(days: 2)).month,
//     // _now.subtract(Duration(days: 2)).day,
//     // 12),
//     event: const Event(title: "Chemistry Viva"),
//     title: "Chemistry Viva",
//     description: "Today is Joe's birthday.",
//   ),
// ];
