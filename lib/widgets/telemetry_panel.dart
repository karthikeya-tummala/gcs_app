import 'package:flutter/material.dart';
import '../controllers/dashboard_controller.dart';
import 'panel.dart';
import 'telemetry_group.dart';

class TelemetryPanel extends StatelessWidget {
  final DashboardController controller;

  const TelemetryPanel({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Panel(
      title: 'Telemetry',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TelemetryGroup(
            title: 'Flight',
            items: [
              TelemetryItem(
                  'Altitude', '${controller.altitude.toStringAsFixed(1)} m'),
              TelemetryItem(
                  'Ground Speed',
                  '${controller.groundSpeed.toStringAsFixed(1)} m/s'),
              TelemetryItem(
                  'Vertical Speed',
                  '${controller.verticalSpeed.toStringAsFixed(1)} m/s'),
              TelemetryItem('Heading', '${controller.heading}°'),
            ],
          ),
          const SizedBox(height: 8),
          TelemetryGroup(
            title: 'Power',
            items: [
              TelemetryItem('Battery', '${controller.battery}%'),
              TelemetryItem(
                  'Voltage', '${controller.voltage.toStringAsFixed(2)} V'),
              TelemetryItem(
                  'Current', '${controller.current.toStringAsFixed(1)} A'),
              TelemetryItem(
                  'Consumed', '${controller.consumed.toStringAsFixed(2)} Ah'),
            ],
          ),
          const SizedBox(height: 8),
          TelemetryGroup(
            title: 'Link',
            items: [
              TelemetryItem('Signal', '${controller.signal}%'),
              TelemetryItem('RSSI', '${controller.rssi} dBm'),
              TelemetryItem('Latency', '${controller.latency} ms'),
            ],
          ),
        ],
      ),
    );
  }
}
