import 'package:flutter/material.dart';
import '../controllers/dashboard_controller.dart';
import '../widgets/status_card.dart';
import '../widgets/armed_indicator.dart';
import '../widgets/controls_panel.dart';
import '../widgets/telemetry_panel.dart';
import '../widgets/map_panel.dart';
import '../models/status_type.dart';

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
        backgroundColor: const Color(0xFF0066CC),
        foregroundColor: Colors.white,
        title: const Text('GCS Dashboard'),
        actions: [
          ArmedIndicator(isArmed: controller.armed),
          const SizedBox(width: 16),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(panelSpacing),
          child: Column(
            children: [
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  StatusCard(
                    title: 'Battery',
                    value: '${controller.battery}%',
                    valueInt: controller.battery,
                    type: StatusType.battery,
                  ),
                  StatusCard(
                    title: 'GPS',
                    value: '${controller.gps} sats',
                    valueInt: controller.gps,
                    type: StatusType.gps,
                  ),
                  StatusCard(
                    title: 'Signal',
                    value: '${controller.signal}%',
                    valueInt: controller.signal,
                    type: StatusType.signal,
                  ),
                ],
              ),
              const SizedBox(height: panelSpacing),
              Expanded(child: _responsiveBody(width)),
            ],
          ),
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

