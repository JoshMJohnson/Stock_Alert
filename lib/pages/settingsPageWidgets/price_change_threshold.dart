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
              min: 2,
              activeColor: const Color(0xFF1B5E20),
              inactiveColor: const Color(0xFFA5D6A7),
              onChanged: (value) {
                sliderActionHandler(value);
              })
        ],
      ),
    );
  }
}
