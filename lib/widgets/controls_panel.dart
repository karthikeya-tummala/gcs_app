import 'package:flutter/material.dart';
import 'panel.dart';
import 'control_group.dart';

class ControlsPanel extends StatelessWidget {
  const ControlsPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return const Panel(
      title: 'Controls',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ControlGroup(
            title: 'Flight',
            children: [
              ControlItem('Arm / Disarm'),
              ControlItem('Takeoff'),
              ControlItem('Land'),
              ControlItem('Return to Home'),
            ],
          ),
          SizedBox(height: 8),
          ControlGroup(
            title: 'Navigation',
            children: [
              ControlItem('Set Waypoint'),
              ControlItem('Clear Mission'),
              ControlItem('Pause Mission'),
              ControlItem('Resume Mission'),
            ],
          ),
          SizedBox(height: 8),
          ControlGroup(
            title: 'System',
            children: [
              ControlItem('Calibrate Sensors'),
              ControlItem('Failsafe Settings'),
              ControlItem('Reboot Vehicle'),
            ],
          ),
        ],
      ),
    );
  }
}
