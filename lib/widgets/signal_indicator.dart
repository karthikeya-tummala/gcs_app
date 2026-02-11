import 'package:flutter/material.dart';

class SignalIndicator extends StatelessWidget{

  final int signalStrength;
  final int signalPercentage;

  const SignalIndicator({required this.signalStrength, required this.signalPercentage, super.key});

  @override
  Widget build(BuildContext context) {
    IconData icon;
    Color color;

    if (signalPercentage >= 70) {
      icon = Icons.signal_cellular_alt_rounded;
      color = Colors.green;
    } else if (signalPercentage >= 50) {
      icon = Icons.signal_cellular_alt_2_bar_rounded;
      color = Colors.yellow;
    } else {
      icon = Icons.signal_cellular_alt_1_bar_rounded;
      color = Colors.red;
    }

    return Row(
      children: [
        Icon(icon, color: color),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '${signalPercentage}%',
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              '${signalStrength}dBm',
              style: TextStyle(
                color: color,
                fontSize: 11,
              ),
            )
          ],
        )
      ],
    );
  }
}