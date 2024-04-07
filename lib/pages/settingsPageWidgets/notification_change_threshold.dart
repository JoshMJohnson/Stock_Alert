import 'package:flutter/material.dart';

class NotificationChangeThreshold extends StatefulWidget {
  const NotificationChangeThreshold({super.key});

  @override
  State<NotificationChangeThreshold> createState() =>
      _NotificationChangeThresholdState();
}

class _NotificationChangeThresholdState
    extends State<NotificationChangeThreshold> {
  double _currentValue = 5;

  /* handles the slider value changing */ // todo save updated value to async storage
  void sliderActionHandler(double currentSliderValue) {
    setState(() {
      _currentValue = currentSliderValue;
      print("slider value changed!... currentSliderValue: $currentSliderValue");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Day Change Threshold:',
                style: TextStyle(
                    color: Color(0xFF1B5E20),
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              )),
          Slider(
              value: _currentValue,
              max: 10,
              label: _currentValue.round().toString(),
              onChanged: (value) {
                sliderActionHandler(value);
              })
        ],
      ),
    );
  }
}
