import 'package:flutter/material.dart';
import 'panel.dart';

class ControlsPanel extends StatelessWidget {
  final bool forceSingleColumn;

  const ControlsPanel({super.key, required this.forceSingleColumn});

  @override
  Widget build(BuildContext context) {
    return Panel(
      title: 'Commands',
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionHeader('FLIGHT'),
            _adaptiveGrid([
              _cmdBtn(Icons.power_settings_new, 'ARM/\nDISARM', Colors.red),
              _cmdBtn(Icons.flight_takeoff, 'TAKEOFF', Colors.green),
              _cmdBtn(Icons.flight_land, 'LAND', Colors.orange),
              _cmdBtn(Icons.home, 'RTL', Colors.blue),
            ]),
            const SizedBox(height: 8),
            _sectionHeader('NAV'),
            _adaptiveGrid([
              _cmdBtn(Icons.add_location, 'WP', Colors.white),
              _cmdBtn(Icons.clear_all, 'CLR', Colors.white),
              _cmdBtn(Icons.pause, 'PAUSE', Colors.white),
              _cmdBtn(Icons.play_arrow, 'RES', Colors.white),
            ]),
            const SizedBox(height: 8),
            _sectionHeader('SYS'), // RESTORED
            _adaptiveGrid([
              _cmdBtn(Icons.settings_input_component, 'CALIB', Colors.white),
              _cmdBtn(Icons.restart_alt, 'REBOOT', Colors.redAccent),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader(String title) => Text(title, style: const TextStyle(fontSize: 9, color: Colors.blueAccent, fontWeight: FontWeight.bold));

  Widget _adaptiveGrid(List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Wrap(
        spacing: 6,
        runSpacing: 6,
        children: children.map((btn) => SizedBox(
          width: forceSingleColumn ? double.infinity : 85,
          child: btn,
        )).toList(),
      ),
    );
  }

  Widget _cmdBtn(IconData icon, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(height: 2),
          Text(label, textAlign: TextAlign.center, style: TextStyle(color: color, fontSize: 8, fontWeight: FontWeight.bold, height: 1.1)),
        ],
      ),
    );
  }
}