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
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          'Day Change\nThreshold (%):',
          textScaler: TextScaler.noScaling,
          style: TextStyle(
              color: Theme.of(context).textTheme.bodyMedium!.color,
              fontSize: 20,
              fontWeight: FontWeight.w600),
        ),
        Column(children: [
          Slider(
              value: thresholdValue,
              max: 10,
              min: 2,
              thumbColor: Theme.of(context).sliderTheme.thumbColor,
              activeColor: Theme.of(context).sliderTheme.activeTrackColor,
              inactiveColor: Theme.of(context).sliderTheme.inactiveTrackColor,
              onChanged: (value) {
                sliderActionHandler(value);
              }),
          Text(
            '$thresholdValue',
            textScaler: TextScaler.noScaling,
            style: TextStyle(
                color: Theme.of(context).textTheme.bodyMedium!.color,
                fontSize: 20,
                fontWeight: FontWeight.normal),
          )
        ])
      ]),
    );
  }
}
