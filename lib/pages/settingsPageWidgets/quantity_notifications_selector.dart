import 'package:flutter/material.dart';

class QuantityNotificationsSelector extends StatefulWidget {
  const QuantityNotificationsSelector({super.key});

  @override
  State<QuantityNotificationsSelector> createState() =>
      _QuantityNotificationsSelectorState();
}

class _QuantityNotificationsSelectorState
    extends State<QuantityNotificationsSelector> {
  List<String> dropdownOptions = ['One', 'Two', 'Three'];
  String? currentOption = 'One';

  /* handles a change in dropdown box selection */
  void _dropdownHandler(String? selectedValue) {
    setState(() {
      currentOption = selectedValue;
      print("currentOption: $currentOption");
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
                'Quantitiy of\nDaily Notifications:',
                style: TextStyle(
                    color: Color(0xFF1B5E20),
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              )),
          Padding(
              padding: const EdgeInsets.all(10),
              child: DropdownButton(
                items: dropdownOptions.map((String option) {
                  return DropdownMenuItem(child: Text(option), value: option);
                }).toList(),
                onChanged: (String? selectedValue) {
                  _dropdownHandler(selectedValue);
                },
                value: currentOption,
              )),
        ],
      ),
    );
  }
}
