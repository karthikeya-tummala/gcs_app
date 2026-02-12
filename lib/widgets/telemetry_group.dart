import 'package:flutter/material.dart';

class TelemetryGroup extends StatelessWidget {
  final String title;
  final List<TelemetryItem> items;

  const TelemetryGroup({super.key, required this.title, required this.items});

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

class TelemetryItem extends StatelessWidget {
  final String label;
  final String value;

  const TelemetryItem(this.label, this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: const TextStyle(fontSize: 10, color: Colors.grey),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: 'Monospace',
          ),
        ),
      ],
    );
  }
}
