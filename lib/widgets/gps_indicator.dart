import 'package:flutter/material.dart';

class GPSIndicator extends StatelessWidget {
  final int gps;

  const GPSIndicator({required this.gps, super.key});

  Color _getColor() {
    if (gps <= 5) return Colors.red;
    if (gps <= 9) return Colors.orange;
    if (gps <= 12) return Colors.yellow.shade700;
    return Colors.green;
  }

  String _getFixLabel() {
    if (gps <= 5) return "No Fix";
    if (gps <= 9) return "2D";
    return "3D";
  }

  @override
  Widget build(BuildContext context) {
    final color = _getColor();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.satellite_alt_rounded,
          color: color,
          size: 20,
        ),
        const SizedBox(width: 4),
        Text(
          "$gps sats • ${_getFixLabel()}",
          style: TextStyle(color: color),
        ),
      ],
    );
  }
}
