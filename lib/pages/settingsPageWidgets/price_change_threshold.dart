import 'package:flutter/material.dart';

class PriceChangeThreshold extends StatefulWidget {
  const PriceChangeThreshold({super.key});

  @override
  State<PriceChangeThreshold> createState() => _PriceChangeThresholdState();
}

class _PriceChangeThresholdState extends State<PriceChangeThreshold> {
  double _currentValue = 5;

  /* handles the slider value changing */ // todo save updated value to async storage
  void sliderActionHandler(double currentSliderValue) {
    String roundedSliderValueString = currentSliderValue.toStringAsFixed(2);
    double roundedSliderValueDouble = double.parse(roundedSliderValueString);

    debugPrint("Slider updated value: $roundedSliderValueDouble");

    setState(() {
      _currentValue = roundedSliderValueDouble;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 10, 10, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Day Change\nThreshold (%):',
            style: TextStyle(
                color: Color(0xFF1B5E20),
                fontSize: 20,
                fontWeight: FontWeight.w600),
          ),
          Slider(
              value: _currentValue,
              max: 10,
              min: 2,
              activeColor: const Color(0xFF1B5E20),
              inactiveColor: const Color(0xFFFF0000),
              onChanged: (value) {
                sliderActionHandler(value);
              })
        ],
      ),
    );
  }
}
