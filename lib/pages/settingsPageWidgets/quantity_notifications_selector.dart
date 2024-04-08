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
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Row(
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
            items: dropdownOptions.map((String option) {
              return DropdownMenuItem(
                  value: option,
                  child: Text(
                    option,
                    style: const TextStyle(
                        color: Color(0xFF1B5E20),
                        fontSize: 20,
                        fontWeight: FontWeight.normal),
                  ));
            }).toList(),
            onChanged: (String? selectedValue) {
              _dropdownHandler(selectedValue);
            },
            value: currentOption,
            dropdownColor: const Color(0xFFA5D6A7),
            iconDisabledColor: const Color(0xFF1B5E20),
            iconEnabledColor: const Color(0xFF1B5E20),
            borderRadius: BorderRadius.circular(40),
          ),
        ],
      ),
    );
  }
}
