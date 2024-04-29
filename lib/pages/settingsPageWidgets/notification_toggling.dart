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
  bool notificationToggledOn;
  _NotificationToggleState(this.notificationToggledOn);

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
                  value: true,
                  groupValue: notificationToggledOn,
                  fillColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    return const Color(0xFF1B5E20);
                  }),
                  onChanged: (value) {
                    setState(() {
                      notificationToggledOn = value!;
                    });
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
                      value: false,
                      groupValue: notificationToggledOn,
                      fillColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        return const Color(0xFF1B5E20);
                      }),
                      onChanged: (value) {
                        setState(() {
                          notificationToggledOn = value!;
                        });
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
