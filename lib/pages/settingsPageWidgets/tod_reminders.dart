import 'dart:async';

import 'package:flutter/material.dart';

class TODReminders extends StatefulWidget {
  const TODReminders({super.key});

  @override
  State<TODReminders> createState() => _TODRemindersState();
}

class _TODRemindersState extends State<TODReminders> {
  TimeOfDay tod1 = TimeOfDay.now();
  TimeOfDay tod2 = TimeOfDay.now();
  TimeOfDay tod3 = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Daily Notification 1:',
              style: TextStyle(
                  color: Color(0xFF1B5E20),
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
            ElevatedButton(
                onPressed: () async {
                  changeTODHandler(0);
                },
                child: getCurrentTOD1())
          ],
        ));
  }

  changeTODHandler(int todID) async {
    final TimeOfDay? todUpdated = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now()); // ! get saved time as initialTime

    /* if no updated time was selected; cancel was pressed from within the selector */
    if (todUpdated == null) {
      return;
    }

    /* determines which daily reminder is being changed */
    if (todID == 0) {
      // todo save TOD1 to storage

      setState(() {
        tod1 = todUpdated;
      });
    } else if (todID == 1) {
      // todo save TOD2 to storage

      setState(() {
        tod2 = todUpdated;
      });
    } else {
      // todo save TOD3 to storage

      setState(() {
        tod3 = todUpdated;
      });
    }
  }

  /* retrieve tod1 from storage */ // todo get async value of TOD1 from storage
  Text getCurrentTOD1() {
    int todHours = tod1.hour;
    int todMinutes = tod1.minute;

    String tod1Time = '$todHours:$todMinutes';
    Text displayedTime = Text(tod1Time);

    return displayedTime;
  }

  /* retrieve tod1 from storage */ // todo get async value of TOD1 from storage
  Text getCurrentTOD2() {
    String tod2Time = 'temp2:temp2';
    Text displayedTime = Text(tod2Time);

    return displayedTime;
  }

  /* retrieve tod1 from storage */ // todo get async value of TOD1 from storage
  Text getCurrentTOD3() {
    String tod3Time = 'temp3:temp3';
    Text displayedTime = Text(tod3Time);

    return displayedTime;
  }
}
