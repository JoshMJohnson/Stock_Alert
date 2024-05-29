import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  final Function() saveButtonHandler;
  const SaveButton(this.saveButtonHandler, {super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        saveButtonHandler();
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text(
              'Settings Saved',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).textTheme.headlineMedium!.color,
                fontSize: 28,
                fontWeight: FontWeight.w700,
              ),
            ),
            content: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(
                Icons.check_circle_outline,
                size: 55,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).buttonTheme.colorScheme!.background,
        foregroundColor: Theme.of(context).buttonTheme.colorScheme!.primary,
      ),
      child: Text(
        'Save\nSettings',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Theme.of(context).buttonTheme.colorScheme!.secondary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
