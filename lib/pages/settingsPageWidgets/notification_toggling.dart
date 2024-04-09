import 'package:flutter/material.dart';

class NotificationToggle extends StatefulWidget {
  const NotificationToggle({super.key});

  @override
  State<NotificationToggle> createState() => _NotificationToggleState();
}

class _NotificationToggleState extends State<NotificationToggle> {
  bool? notificationsActive = false;
  List<bool> notificationsOnOptions = [true, false];

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
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
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
