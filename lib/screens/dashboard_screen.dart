import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  static const double panelPadding = 16.0;
  static const double panelSpacing = 8.0;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0066CC),
        foregroundColor: Colors.white,
        title: const Text('GCS Dashboard'),
        actions: const [
          _StatusIndicator(label: 'CONNECTED', color: Colors.green),
          SizedBox(width: 12),
          _StatusIndicator(label: 'BATTERY 35%', color: Colors.orange),
          SizedBox(width: 16),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(panelSpacing),
          child: _buildResponsiveBody(width),
        ),
      ),
    );
  }

  Widget _buildResponsiveBody(double width) {
    if (width >= 1024) {
      return _desktopLayout();
    } else if (width >= 600) {
      return _tabletLayout();
    } else {
      return _mobileLayout();
    }
  }

  Widget _desktopLayout() {
    return Row(
      children: [
        Expanded(flex: 2, child: _controlsPanel()),
        const SizedBox(width: panelSpacing),
        Expanded(flex: 5, child: _mapPanel()),
        const SizedBox(width: panelSpacing),
        Expanded(flex: 2, child: _telemetryPanel()),
      ],
    );
  }

  Widget _tabletLayout() {
    return Row(
      children: [
        Expanded(flex: 2, child: _controlsPanel()),
        const SizedBox(width: panelSpacing),
        Expanded(flex: 4, child: _mapPanel()),
        const SizedBox(width: panelSpacing),
        Expanded(flex: 2, child: _telemetryPanel()),
      ],
    );
  }

  Widget _mobileLayout() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _mapPanel(),
          const SizedBox(height: panelSpacing),
          _controlsPanel(),
          const SizedBox(height: panelSpacing),
          _telemetryPanel(),
        ],
      ),
    );
  }

  // ---------- Panels ----------

  Widget _controlsPanel() {
    return _Panel(
      title: 'Controls',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          _ControlGroup(
            title: 'Flight',
            children: [
              _ControlItem('Arm / Disarm'),
              _ControlItem('Takeoff'),
              _ControlItem('Land'),
              _ControlItem('Return to Home'),
            ],
          ),
          SizedBox(height: 8),
          _ControlGroup(
            title: 'Navigation',
            children: [
              _ControlItem('Set Waypoint'),
              _ControlItem('Clear Mission'),
              _ControlItem('Pause Mission'),
              _ControlItem('Resume Mission'),
            ],
          ),
          SizedBox(height: 8),
          _ControlGroup(
            title: 'System',
            children: [
              _ControlItem('Calibrate Sensors'),
              _ControlItem('Failsafe Settings'),
              _ControlItem('Reboot Vehicle'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _mapPanel() {
    return _Panel(
      title: 'Map',
      child: Container(
        color: Colors.grey.shade300,
        child: Image.asset('assets/images/static_map.png', fit: BoxFit.contain),
      ),
    );
  }

  Widget _telemetryPanel() {
    return _Panel(
      title: 'Telemetry',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          _TelemetryGroup(
            title: 'Flight',
            items: [
              _TelemetryItem('Altitude', '120 m'),
              _TelemetryItem('Ground Speed', '7 m/s'),
              _TelemetryItem('Vertical Speed', '-0.3 m/s'),
              _TelemetryItem('Heading', '245°'),
            ],
          ),
          SizedBox(height: 8),
          _TelemetryGroup(
            title: 'Power',
            items: [
              _TelemetryItem('Battery', '35%'),
              _TelemetryItem('Voltage', '14.8 V'),
              _TelemetryItem('Current', '9.2 A'),
              _TelemetryItem('Consumed', '1.6 Ah'),
            ],
          ),
          SizedBox(height: 8),
          _TelemetryGroup(
            title: 'Link',
            items: [
              _TelemetryItem('Signal Strength', 'Strong'),
              _TelemetryItem('RSSI', '-62 dBm'),
              _TelemetryItem('Latency', '120 ms'),
            ],
          ),
        ],
      ),
    );
  }
}

class _Panel extends StatelessWidget {
  final String title;
  final Widget child;

  const _Panel({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(DashboardScreen.panelPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch, // IMPORTANT
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _TelemetryGroup extends StatelessWidget {
  final String title;
  final List<_TelemetryItem> items;

  const _TelemetryGroup({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 6),
        ...items,
      ],
    );
  }
}

class _TelemetryItem extends StatelessWidget {
  final String label;
  final String value;

  const _TelemetryItem(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}

class _ControlGroup extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _ControlGroup({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      title: Text(title, style: Theme.of(context).textTheme.titleSmall),
      children: children,
    );
  }
}

class _ControlItem extends StatelessWidget {
  final String label;

  const _ControlItem(this.label);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          const Icon(Icons.chevron_right, size: 16),
          const SizedBox(width: 6),
          Text(label),
        ],
      ),
    );
  }
}

class _StatusIndicator extends StatelessWidget {
  final String label;
  final Color color;

  const _StatusIndicator({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.circle, color: color, size: 10),
        const SizedBox(width: 6),
        Text(label),
      ],
    );
  }
}
