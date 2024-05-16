import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  final Function saveButtonHandler;
  const SaveButton(this.saveButtonHandler, {super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        saveButtonHandler();
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.background,
          foregroundColor: Theme.of(context).colorScheme.primary),
      child: Text(
        'Save\nSettings',
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Theme.of(context).textTheme.displayMedium!.color,
            fontSize: 20,
            fontWeight: FontWeight.w600),
      ),
    );
  }
}
