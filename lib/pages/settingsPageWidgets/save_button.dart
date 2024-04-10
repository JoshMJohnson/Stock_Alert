import 'package:flutter/material.dart';

class SaveButton extends StatefulWidget {
  const SaveButton({super.key});

  @override
  State<SaveButton> createState() => _SaveButtonState();
}

class _SaveButtonState extends State<SaveButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        saveButtonHandler();
      },
      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFA5D6A7)),
      child: const Text(
        'Save',
        style: TextStyle(
            color: Color(0xFF1B5E20),
            fontSize: 20,
            fontWeight: FontWeight.w600),
      ),
    );
  }

  saveButtonHandler() async {
    debugPrint('Save button pressed');
  }
}
