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
              changeTODHandler(todID);
            },
            child: getCurrentTOD(todID))
      ],
    );
  }

  /* adjusts and saves updated time of day 1 reminder */
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

  /* adjusts and saves updated time of day 2 reminder */
  changeTOD2Handler() async {
    final TimeOfDay? tod2Updated = await showTimePicker(
        context: context,
        initialTime:
            tod2); // ! get saved time of TOD2 from storage as initialTime

    /* if no updated time was selected; cancel was pressed from within the selector */
    if (tod2Updated == null) {
      return;
    }

    setState(() {
      tod2 = tod2Updated;
    });
  }

  /* adjusts and saves updated time of day 3 reminder */
  changeTOD3Handler() async {
    final TimeOfDay? tod3Updated = await showTimePicker(
        context: context,
        initialTime:
            tod3); // ! get saved time of TOD3 from storage as initialTime

    /* if no updated time was selected; cancel was pressed from within the selector */
    if (tod3Updated == null) {
      return;
    }

    setState(() {
      tod3 = tod3Updated;
    });
  }

  /* retrieves TODs from storage and adjusts for display */
  Text getCurrentTOD(int todID) {
    late int todHours;
    late int todMinutes;

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

    print(
        'todMinutes: $todMinutes'); // ! runs through all 3 notificaions when changing 1

    /* military -> standard time */
    if (todHours > 11) {
      todHours -= 12;
      isAM = false;
    }

    todHours == 0 ? todHours = 12 : todHours;

    /* prepares string statement that displays the chosen time */
    if (isAM) {
      todTimeUpdated = '$todHours:$todMinutes am';
    } else {
      todTimeUpdated = '$todHours:$todMinutes pm';
    }

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
