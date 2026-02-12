import 'package:flutter/material.dart';
import 'package:gcs_app/widgets/dashboard_app_bar.dart';
import 'package:gcs_app/widgets/battery_indicator.dart';
import 'package:gcs_app/widgets/gps_indicator.dart';
import 'package:gcs_app/widgets/signal_indicator.dart';
import '../controllers/dashboard_controller.dart';
import '../widgets/armed_indicator.dart';
import '../widgets/controls_panel.dart';
import '../widgets/telemetry_panel.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final DashboardController controller = DashboardController();

  @override
  void initState() {
    super.initState();
    controller.start();
    controller.addListener(_updateState);
  }

  void _updateState() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    controller.removeListener(_updateState);
    controller.disposeController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final viewPadding = MediaQuery.of(context).viewPadding;
    const double appBarHeight = 40.0;

    // STRICT PHONE CHECK: shortestSide < 600 is standard for phones
    final bool isPhone = size.shortestSide < 600;
    final bool isLandscape = size.width > size.height;

    // Boundary calculation to keep panels on screen
    final double availableHeight = size.height - viewPadding.top - appBarHeight - 20;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: TransparentDashboardAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 3,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: GPSIndicator(gps: controller.gps),
              ),
            ),
            Flexible(
              flex: 2,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: ArmedIndicator(isArmed: controller.armed),
              ),
            ),
            Flexible(
              flex: 4,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerRight,
                child: Row(
                  children: [
                    SignalIndicator(
                        signalStrength: controller.rssi,
                        signalPercentage: controller.signal
                    ),
                    const SizedBox(width: 8),
                    BatteryIndicator(
                        batteryPercentage: controller.battery,
                        voltage: controller.voltage
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/images/static_map.png', fit: BoxFit.cover),
          ),

          // Telemetry Panel (Left) - Hugs content width
          Positioned(
            left: 10,
            top: viewPadding.top + appBarHeight + 10,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: availableHeight,
                maxWidth: isPhone ? 120 : 210, // Max bounds
              ),
              child: IntrinsicWidth(
                child: TelemetryPanel(controller: controller, forceSingleColumn: isPhone),
              ),
            ),
          ),

          // Controls Panel (Right) - Hugs content width
          Positioned(
            right: 10,
            top: viewPadding.top + appBarHeight + 10,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: availableHeight,
                maxWidth: isPhone ? 110 : 200,
              ),
              child: IntrinsicWidth(
                child: ControlsPanel(forceSingleColumn: isPhone),
              ),
            ),
          ),
        ],
      ),
    );
  }
}