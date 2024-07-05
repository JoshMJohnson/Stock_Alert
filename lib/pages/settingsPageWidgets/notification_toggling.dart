import 'package:flutter/material.dart';

class NotificationToggle extends StatelessWidget {
  final Function(bool) updateNotificationToggle;
  final bool? notificationToggledOn;
  const NotificationToggle(
      {super.key,
      required this.updateNotificationToggle,
      this.notificationToggledOn});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Notifications:',
            textScaler: TextScaler.noScaling,
            style: TextStyle(
                color: Theme.of(context).textTheme.bodyMedium!.color,
                fontSize: 20,
                fontWeight: FontWeight.w600),
          ),
          Row(children: [
            Row(
              children: [
                Radio(
                  value: true,
                  groupValue: notificationToggledOn,
                  fillColor: Theme.of(context).radioTheme.fillColor,
                  onChanged: (isToggledOn) {
                    updateNotificationToggle(isToggledOn!);
                  },
                ),
                Text(
                  'On',
                  textScaler: TextScaler.noScaling,
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodyMedium!.color,
                      fontSize: 20,
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Row(
                  children: [
                    Radio(
                      value: false,
                      groupValue: notificationToggledOn,
                      fillColor: Theme.of(context).radioTheme.fillColor,
                      onChanged: (isToggledOn) {
                        updateNotificationToggle(isToggledOn!);
                      },
                    ),
                    Text(
                      'Off',
                      textScaler: TextScaler.noScaling,
                      style: TextStyle(
                          color: Theme.of(context).textTheme.bodyMedium!.color,
                          fontSize: 20,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ))
          ])
        ],
      ),
    );
  }
}
