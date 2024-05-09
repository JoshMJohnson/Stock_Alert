import 'package:flutter/material.dart';
import 'package:stock_alert/helper_functions.dart';

class TODReminders extends StatelessWidget {
  final Function(int) changeTODHandler;
  final int? notificationQuantity;
  final TimeOfDay tod1;
  final TimeOfDay tod2;
  final TimeOfDay tod3;
  const TODReminders(
      {super.key,
      required this.changeTODHandler,
      required this.notificationQuantity,
      required this.tod1,
      required this.tod2,
      required this.tod3});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
        child: Column(children: [
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: todInstance(1)),
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: todInstance(2)),
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: todInstance(3))
        ]));
  }

  /* creates an intance of a daily notification display */
  Visibility todInstance(todID) {
    debugPrint('todID: $todID ... notificationQuantity: $notificationQuantity');

    return Visibility(
        visible: notificationQuantity! >= todID ? true : false,
        child: Row(
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
                    foregroundColor: const Color(0xFF228B22)),
                onPressed: () async {
                  changeTODHandler(todID);
                },
                child: getCurrentTOD(todID))
          ],
        ));
  }

  /* retrieves TODs from storage and adjusts for display */
  Text getCurrentTOD(int todID) {
    final HelperFunctions helperFunctions = HelperFunctions();
    late String standardTime;

    if (todID == 0) {
      standardTime = helperFunctions.standardTimeConvertionHandler(tod1);
    } else if (todID == 1) {
      standardTime = helperFunctions.standardTimeConvertionHandler(tod2);
    } else {
      standardTime = helperFunctions.standardTimeConvertionHandler(tod3);
    }

    Text displayedTime = Text(
      standardTime,
      style: const TextStyle(
          color: Color(0xFF1B5E20),
          fontSize: 20,
          fontWeight: FontWeight.normal),
    );

    return displayedTime;
  }
}
