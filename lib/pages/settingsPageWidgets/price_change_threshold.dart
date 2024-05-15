import 'package:flutter/material.dart';

class PriceChangeThreshold extends StatelessWidget {
  final Function(double) sliderActionHandler;
  final double thresholdValue;
  const PriceChangeThreshold(
      {super.key,
      required this.sliderActionHandler,
      required this.thresholdValue});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Day Change\nThreshold (%):',
            style: TextStyle(
                color: Theme.of(context).textTheme.displayMedium!.color,
                fontSize: 20,
                fontWeight: FontWeight.w600),
          ),
          Column(
            children: [
              Slider(
                  value: thresholdValue,
                  max: 10,
                  min: 2,
                  activeColor: const Color(0xFF1B5E20),
                  inactiveColor: const Color(0xFFCC0000),
                  onChanged: (value) {
                    sliderActionHandler(value);
                  }),
              Text(
                '$thresholdValue',
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
