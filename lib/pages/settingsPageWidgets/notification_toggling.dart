import 'package:flutter/material.dart';

/* displays notification toggling on/off within settings */
class NotificationToggle extends StatefulWidget {
  const NotificationToggle({super.key});

  @override
  State<NotificationToggle> createState() => _NotificationToggleState();
}

/* handles notification toggling on/off within settings */
class _NotificationToggleState extends State<NotificationToggle> {
  bool? notificationsOn = false;
  List<bool> notificationsOnOptions = [true, false];

  /* handles a toggle in notifications active */ // todo save updated value to async storage
  void _toggleNotificationsOn(bool? currentValue) {
    setState(() {
      notificationsOn = currentValue;
      print("notificationsOn: $notificationsOn");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
          Row(
            children: [
              Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Radio(
                        value: notificationsOnOptions[0],
                        groupValue: notificationsOn,
                        fillColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                          return const Color(0xFF1B5E20);
                        }),
                        onChanged: (value) {
                          _toggleNotificationsOn(value);
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
                        groupValue: notificationsOn,
                        fillColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                          return const Color(0xFF1B5E20);
                        }),
                        onChanged: (value) {
                          _toggleNotificationsOn(value);
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
          )
        ],
      ),
    );
  }
}
