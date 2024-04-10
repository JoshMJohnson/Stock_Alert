import 'package:flutter/material.dart';

class TODReminders extends StatefulWidget {
  const TODReminders({super.key});

  @override
  State<TODReminders> createState() => _TODRemindersState();
}

class _TODRemindersState extends State<TODReminders> {
  TimeOfDay tod1 = const TimeOfDay(hour: 8, minute: 45);
  TimeOfDay tod2 = const TimeOfDay(hour: 12, minute: 0);
  TimeOfDay tod3 = const TimeOfDay(hour: 14, minute: 15);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
        child: Column(children: [
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: todInstance(0)),
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: todInstance(1)),
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: todInstance(2))
        ]));
  }

  /* creates an intance of a daily notification display */
  Row todInstance(todID) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Daily Notification:',
          style: TextStyle(
              color: Color(0xFF1B5E20),
              fontSize: 20,
              fontWeight: FontWeight.w600),
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFA5D6A7),
                foregroundColor: const Color(0xFFFF0000)),
            onPressed: () async {
              changeTODHandler(todID);
            },
            child: getCurrentTOD(todID))
      ],
    );
  }

  /* adjusts and saves updated time of day reminders */
  changeTODHandler(int todID) async {
    late final TimeOfDay? todUpdated;

    if (todID == 0) {
      todUpdated = await showTimePicker(
          context: context,
          initialTime:
              tod1); // ! get saved time of TOD1 from storage as initialTime

      /* if no updated time was selected; cancel was pressed from within the selector */
      if (todUpdated == null) {
        return;
      }

      setState(() {
        tod1 = todUpdated!;
      });
    } else if (todID == 1) {
      todUpdated = await showTimePicker(
          context: context,
          initialTime:
              tod2); // ! get saved time of TOD2 from storage as initialTime

      /* if no updated time was selected; cancel was pressed from within the selector */
      if (todUpdated == null) {
        return;
      }

      setState(() {
        tod2 = todUpdated!;
      });
    } else {
      todUpdated = await showTimePicker(
          context: context,
          initialTime:
              tod3); // ! get saved time of TOD3 from storage as initialTime

      /* if no updated time was selected; cancel was pressed from within the selector */
      if (todUpdated == null) {
        return;
      }

      setState(() {
        tod3 = todUpdated!;
      });
    }
  }

  /* retrieves TODs from storage and adjusts for display */
  Text getCurrentTOD(int todID) {
    late int todHours;
    late int todMinutes;
    late String todMinutes2Digits;

    /* military -> standard variables */
    bool isAM = true;
    late String todTimeUpdated;

    if (todID == 0) {
      // todo get async value of TOD1 from storage
      todHours = tod1.hour;
      todMinutes = tod1.minute;
    } else if (todID == 1) {
      // todo get async value of TOD2 from storage
      todHours = tod2.hour;
      todMinutes = tod2.minute;
    } else {
      // todo get async value of TOD3 from storage
      todHours = tod3.hour;
      todMinutes = tod3.minute;
    }

    todMinutes2Digits = todMinutes.toString().padLeft(2, '0');

    /* military -> standard time */
    if (todHours > 11) {
      todHours -= 12;
      isAM = false;
    }

    todHours == 0 ? todHours = 12 : todHours;

    /* prepares string statement that displays the chosen time */
    if (isAM) {
      todTimeUpdated = '$todHours:$todMinutes2Digits am';
    } else {
      todTimeUpdated = '$todHours:$todMinutes2Digits pm';
    }

    debugPrint('todTimeUpdated: $todTimeUpdated');

    Text displayedTime = Text(
      todTimeUpdated,
      style: const TextStyle(
          color: Color(0xFF1B5E20),
          fontSize: 20,
          fontWeight: FontWeight.normal),
    );

    return displayedTime;
  }
}
