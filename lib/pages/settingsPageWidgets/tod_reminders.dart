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
        margin: const EdgeInsets.symmetric(vertical: 20),
        child: Column(children: [
          Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: todInstance(context, 0)),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: todInstance(context, 1)),
          Padding(
              padding: const EdgeInsets.only(top: 10),
              child: todInstance(context, 2))
        ]));
  }

  /* creates an intance of a daily notification display */
  Visibility todInstance(BuildContext context, int todID) {
    return Visibility(
        visible: notificationQuantity! >= (todID + 1) ? true : false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Daily Notification:',
              textScaler: TextScaler.noScaling,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyMedium!.color,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Theme.of(context).buttonTheme.colorScheme!.background,
                foregroundColor:
                    Theme.of(context).buttonTheme.colorScheme!.primary,
              ),
              onPressed: () async {
                changeTODHandler(todID);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: getCurrentTOD(context, todID),
              ),
            )
          ],
        ));
  }

  /* retrieves TODs from storage and adjusts for display */
  Text getCurrentTOD(BuildContext context, int todID) {
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
      textScaler: TextScaler.noScaling,
      style: TextStyle(
          color: Theme.of(context).buttonTheme.colorScheme!.secondary,
          fontSize: 20,
          fontWeight: FontWeight.normal),
    );

    return displayedTime;
  }
}
