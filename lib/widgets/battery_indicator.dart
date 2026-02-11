import 'package:flutter/material.dart';

class BatteryIndicator extends StatelessWidget {
  final int batteryPercentage;
  final double voltage;

  const BatteryIndicator({required this.batteryPercentage, required this.voltage, super.key});

  @override
  Widget build(BuildContext context) {
    IconData icon;
    Color color;

    if (batteryPercentage >= 70) {
      icon = Icons.battery_full;
      color = Colors.green;
    } else if (batteryPercentage >= 50) {
      icon = Icons.battery_4_bar;
      color = Colors.green;
    } else if (batteryPercentage >= 20) {
      icon = Icons.battery_3_bar;
      color = Colors.orange;
    } else {
      icon = Icons.battery_1_bar;
      color = Colors.red;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$batteryPercentage %',
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w700
              ),
            ),
            Text(
              '${voltage.toStringAsFixed(2)}V',
              style: TextStyle(
                color: color,
                fontSize: 11,
                fontWeight: FontWeight.w500
              ),
            ),
          ],
        )
      ],
    );
  }
}
