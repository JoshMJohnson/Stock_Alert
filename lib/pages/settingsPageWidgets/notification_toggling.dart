import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NotificationToggle extends StatefulWidget {
  bool notificationToggledOn;
  NotificationToggle({super.key, required this.notificationToggledOn});

  @override
  State<NotificationToggle> createState() =>
      // ignore: no_logic_in_create_state
      _NotificationToggleState(notificationToggledOn);
}

class _NotificationToggleState extends State<NotificationToggle> {
  bool? notificationsActive = false;
  List<bool> notificationsOnOptions = [true, false];

  _NotificationToggleState(notificationToggledOn);

  /* handles a toggle in notifications is_active */ // todo save updated value to async storage
  void _toggleNotificationsActive(bool? currentValue) {
    setState(() {
      notificationsActive = currentValue;
      debugPrint("notificationsOn: $notificationsActive");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Notifications:',
            style: TextStyle(
                color: Color(0xFF1B5E20),
                fontSize: 20,
                fontWeight: FontWeight.w600),
          ),
          Row(children: [
            Row(
              children: [
                Radio(
                  value: notificationsOnOptions[0],
                  groupValue: notificationsActive,
                  fillColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    return const Color(0xFF1B5E20);
                  }),
                  onChanged: (value) {
                    _toggleNotificationsActive(value);
                  },
                ),
                const Text(
                  'On',
                  style: TextStyle(
                      color: Color(0xFF1B5E20),
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
                      value: notificationsOnOptions[1],
                      groupValue: notificationsActive,
                      fillColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        return const Color(0xFF1B5E20);
                      }),
                      onChanged: (value) {
                        _toggleNotificationsActive(value);
                      },
                    ),
                    const Text(
                      'Off',
                      style: TextStyle(
                          color: Color(0xFF1B5E20),
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
