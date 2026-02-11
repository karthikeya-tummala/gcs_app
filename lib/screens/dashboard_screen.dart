import 'package:flutter/material.dart';
import 'package:gcs_app/widgets/battery_indicator.dart';
import 'package:gcs_app/widgets/gps_indicator.dart';
import 'package:gcs_app/widgets/signal_indicator.dart';
import '../controllers/dashboard_controller.dart';
import '../widgets/armed_indicator.dart';
import '../widgets/controls_panel.dart';
import '../widgets/telemetry_panel.dart';
import '../widgets/map_panel.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  static const double panelSpacing = 8.0;
  final controller = DashboardController();

  @override
  void initState() {
    super.initState();
    controller.start();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.disposeController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.cell_tower_rounded, size: 40),
        title: const Text('GCS Dashboard'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: ArmedIndicator(isArmed: controller.armed),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: SignalIndicator(signalStrength: controller.rssi, signalPercentage: controller.signal)
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: BatteryIndicator(batteryPercentage: controller.battery, voltage: controller.voltage)
          ),
          Padding(
              padding: const EdgeInsets.only(right: 16),
              child: GPSIndicator(gps: controller.gps),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(panelSpacing),
          child: _responsiveBody(width),
        ),
      ),
    );
  }

  Widget _responsiveBody(double width) {
    if (width >= 1024) {
      return Row(
        children: [
          const Expanded(flex: 2, child: ControlsPanel()),
          const SizedBox(width: panelSpacing),
          const Expanded(flex: 5, child: MapPanel()),
          const SizedBox(width: panelSpacing),
          Expanded(
            flex: 2,
            child: TelemetryPanel(controller: controller),
          ),
        ],
      );
    } else if (width >= 600) {
      return Row(
        children: [
          const Expanded(flex: 2, child: ControlsPanel()),
          const SizedBox(width: panelSpacing),
          const Expanded(flex: 4, child: MapPanel()),
          const SizedBox(width: panelSpacing),
          Expanded(
            flex: 2,
            child: TelemetryPanel(controller: controller),
          ),
        ],
      );
    } else {
      return SingleChildScrollView(
        child: Column(
          children: [
            const MapPanel(),
            const SizedBox(height: panelSpacing),
            const ControlsPanel(),
            const SizedBox(height: panelSpacing),
            TelemetryPanel(controller: controller),
          ],
        ),
      );
    }
  }
}

