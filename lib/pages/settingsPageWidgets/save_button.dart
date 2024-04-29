import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SaveButton extends StatefulWidget {
  Function saveButtonHandler;
  SaveButton({super.key, required this.saveButtonHandler});

  @override
  // ignore: no_logic_in_create_state
  State<SaveButton> createState() => _SaveButtonState(saveButtonHandler);
}

class _SaveButtonState extends State<SaveButton> {
  Function saveButtonHandler;
  _SaveButtonState(this.saveButtonHandler);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        saveButtonHandler();
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFA5D6A7),
          foregroundColor: const Color(0xFF228B22)),
      child: const Text(
        'Save\nSettings',
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Color(0xFF1B5E20),
            fontSize: 20,
            fontWeight: FontWeight.w600),
      ),
    );
  }
}
