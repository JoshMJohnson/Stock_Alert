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
      print("notificationsOn: $notificationsActive");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Notifications:',
                style: TextStyle(
                    color: Color(0xFF1B5E20),
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              )),
          Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
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
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'On',
                      style: TextStyle(
                          color: Color(0xFF1B5E20),
                          fontSize: 20,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              )),
          Padding(
              padding: const EdgeInsets.all(10),
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
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Off',
                      style: TextStyle(
                          color: Color(0xFF1B5E20),
                          fontSize: 20,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
