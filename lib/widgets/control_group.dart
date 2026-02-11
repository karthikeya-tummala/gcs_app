import 'package:flutter/material.dart';

class ControlGroup extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const ControlGroup({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall,
      ),
      children: children,
    );
  }
}

class ControlItem extends StatelessWidget {
  final String label;

  const ControlItem(this.label, {super.key});

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
