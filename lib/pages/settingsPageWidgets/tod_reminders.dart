import 'package:flutter/material.dart';

class TODReminders extends StatefulWidget {
  const TODReminders({super.key});

  @override
  State<TODReminders> createState() => _TODRemindersState();
}

class _TODRemindersState extends State<TODReminders> {
  TimeOfDay tod1 = const TimeOfDay(hour: 8, minute: 45);
  TimeOfDay tod2 = const TimeOfDay(hour: 12, minute: 0);
  TimeOfDay tod3 = const TimeOfDay(hour: 14, minute: 45);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
        child: Column(children: [
          Row(
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
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFA5D6A7),
                      foregroundColor: const Color(0xFFFF0000)),
                  onPressed: () async {
                    changeTODHandler(0);
                  },
                  child: getCurrentTOD(0))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Daily Notification 2:',
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
                    changeTODHandler(1);
                  },
                  child: getCurrentTOD(1))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Daily Notification 3:',
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
                    changeTODHandler(2);
                  },
                  child: getCurrentTOD(2))
            ],
          )
        ]));
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

  /* retrieve tod1 from storage */
  Text getCurrentTOD(int todID) {
    late int todHours;
    late int todMinutes;

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

    String todTimeUpdated = '$todHours:$todMinutes';
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
