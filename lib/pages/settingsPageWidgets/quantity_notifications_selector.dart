import 'package:flutter/material.dart';
import 'package:stock_alert/pages/settingsPageWidgets/tod_reminders.dart';

class QuantityNotificationsSelector extends StatelessWidget {
  final Function(int) changeTODHandler;
  final Function(int) quantityNotificationDropdown;
  final List<int> dropdownOptions = const [1, 2, 3];
  final int? notificationQuantity;
  final TimeOfDay notification1;
  final TimeOfDay notification2;
  final TimeOfDay notification3;

  const QuantityNotificationsSelector(
      {super.key,
      required this.changeTODHandler,
      required this.quantityNotificationDropdown,
      this.notificationQuantity,
      required this.notification1,
      required this.notification2,
      required this.notification3});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Quantity of\nDaily Notifications:',
              textScaler: TextScaler.noScaling,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyMedium!.color,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            DropdownButton(
              items: dropdownOptions.map((int option) {
                return DropdownMenuItem<int>(
                  value: option,
                  child: Center(
                    child: Text(
                      option.toString(),
                      textScaler: TextScaler.noScaling,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyMedium!.color,
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                );
              }).toList(),
              onChanged: (int? selectedValue) {
                quantityNotificationDropdown(selectedValue!);
              },
              value: notificationQuantity,
              underline: Container(
                width: 200,
                height: 1,
                color: Theme.of(context)
                    .dropdownMenuTheme
                    .inputDecorationTheme!
                    .iconColor,
              ),
              dropdownColor: Theme.of(context)
                  .dropdownMenuTheme
                  .inputDecorationTheme!
                  .fillColor,
              iconEnabledColor: Theme.of(context)
                  .dropdownMenuTheme
                  .inputDecorationTheme!
                  .iconColor,
              borderRadius: BorderRadius.circular(40),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: Align(
            alignment: Alignment.bottomRight,
            child: Text(
              'Eastern Daylight Time (EDT)',
              textScaler: TextScaler.noScaling,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyMedium!.color,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        TODReminders(
          changeTODHandler: changeTODHandler,
          notificationQuantity: notificationQuantity,
          tod1: notification1,
          tod2: notification2,
          tod3: notification3,
        )
      ]),
    );
  }
}
