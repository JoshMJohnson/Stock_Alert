import 'package:flutter/material.dart';
import 'package:stock_alert/pages/settingsPageWidgets/tod_reminders.dart';

class QuantityNotificationsSelector extends StatefulWidget {
  const QuantityNotificationsSelector({super.key});

  @override
  State<QuantityNotificationsSelector> createState() =>
      _QuantityNotificationsSelectorState();
}

class _QuantityNotificationsSelectorState
    extends State<QuantityNotificationsSelector> {
  List<int> dropdownOptions = const [1, 2, 3];
  int? currentOption = 3;

  /* handles a change in dropdown box selection */
  void _dropdownHandler(int? selectedValue) {
    setState(() {
      currentOption = selectedValue;
      debugPrint("currentOption: $currentOption");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Quantity of\nDaily Notifications:',
                style: TextStyle(
                    color: Color(0xFF1B5E20),
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              DropdownButton(
                items: dropdownOptions.map((int option) {
                  return DropdownMenuItem<int>(
                      value: option,
                      child: Text(
                        option.toString(),
                        style: const TextStyle(
                            color: Color(0xFF1B5E20),
                            fontSize: 20,
                            fontWeight: FontWeight.normal),
                      ));
                }).toList(),
                onChanged: (int? selectedValue) {
                  _dropdownHandler(selectedValue);
                },
                value: currentOption,
                underline: Container(
                  width: 200,
                  height: 1,
                  color: const Color(0xFFFF0000),
                ),
                dropdownColor: const Color(0xFFA5D6A7),
                iconEnabledColor: const Color(0xFF1B5E20),
                borderRadius: BorderRadius.circular(40),
              ),
            ],
          ),
          const TODReminders()
        ]));
  }
}
