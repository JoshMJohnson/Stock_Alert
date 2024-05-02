import 'package:flutter/material.dart';

class NotificationToggle extends StatelessWidget {
  final bool? notificationToggledOn;
  const NotificationToggle({super.key, this.notificationToggledOn});

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
                  onChanged: (value) {},
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
                      onChanged: (value) {},
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
