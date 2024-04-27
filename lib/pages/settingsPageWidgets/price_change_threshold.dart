import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PriceChangeThreshold extends StatefulWidget {
  double thresholdValue;
  PriceChangeThreshold({super.key, required this.thresholdValue});

  @override
  State<PriceChangeThreshold> createState() => _PriceChangeThresholdState();
}

class _PriceChangeThresholdState extends State<PriceChangeThreshold> {
  double _currentValue = 5;

  /* handles the slider value changing */ // todo save updated value to async storage
  void sliderActionHandler(double currentSliderValue) {
    String roundedSliderValueString = currentSliderValue.toStringAsFixed(2);
    double roundedSliderValueDouble = double.parse(roundedSliderValueString);

    setState(() {
      _currentValue = roundedSliderValueDouble;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
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
          Column(
            children: [
              Slider(
                  value: _currentValue,
                  max: 10,
                  min: 2,
                  activeColor: const Color(0xFF1B5E20),
                  inactiveColor: const Color(0xFFCC0000),
                  onChanged: (value) {
                    sliderActionHandler(value);
                  }),
              Text(
                '$_currentValue',
                style: const TextStyle(
                    color: Color(0xFF1B5E20),
                    fontSize: 20,
                    fontWeight: FontWeight.normal),
              )
            ],
          )
        ],
      ),
    );
  }
}
