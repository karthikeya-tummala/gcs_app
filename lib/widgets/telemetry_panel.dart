import 'package:flutter/material.dart';
import '../controllers/dashboard_controller.dart';
import 'panel.dart';

class TelemetryPanel extends StatelessWidget {
  final DashboardController controller;
  final bool forceSingleColumn;

  const TelemetryPanel({super.key, required this.controller, required this.forceSingleColumn});

  @override
  Widget build(BuildContext context) {
    return Panel(
      title: 'Telemetry',
      child: SingleChildScrollView(
        child: Wrap(
          spacing: 12,
          runSpacing: 8,
          children: [
            _tile('ALTITUDE', '${controller.altitude.toStringAsFixed(1)}m'),
            _tile('G-SPEED', '${controller.groundSpeed.toStringAsFixed(1)}m/s'),
            _tile('V-SPEED', '${controller.verticalSpeed.toStringAsFixed(1)}m/s'),
            _tile('HEADING', '${controller.heading}°'),
            // _tile('BATTERY', '${controller.battery}%'),
            // _tile('VOLTAGE', '${controller.voltage.toStringAsFixed(1)}V'),
            _tile('CURRENT', '${controller.current.toStringAsFixed(1)}A'),
            _tile('RSSI', '${controller.rssi}dBm'),
          ],
        ),
      ),
    );
  }

  Widget _tile(String label, String value) {
    return SizedBox(
      // If forced, use full available width (1-col). Otherwise, use 85px (2-col).
      width: forceSingleColumn ? double.infinity : 85,
      child: Column(
        crossAxisAlignment: forceSingleColumn ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 8, color: Colors.grey)),
          Text(value, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, fontFamily: 'Monospace', color: Colors.white)),
        ],
      ),
    );
  }
}