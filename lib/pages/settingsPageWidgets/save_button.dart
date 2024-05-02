import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  final Function saveButtonHandler;
  const SaveButton({super.key, required this.saveButtonHandler});

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
