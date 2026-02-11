import 'package:flutter/material.dart';
import '../models/status_type.dart';

class StatusCard extends StatefulWidget {
  final String title;
  final String value;
  final int valueInt;
  final StatusType type;

  const StatusCard({
    super.key,
    required this.title,
    required this.value,
    required this.valueInt,
    required this.type,
  });

  @override
  State<StatusCard> createState() => _StatusCardState();
}

class _StatusCardState extends State<StatusCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
      lowerBound: 0.95,
      upperBound: 1.05,
    );

    if (widget.type == StatusType.armed) {
      _pulseController.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  Color _backgroundColor() {
    switch (widget.type) {
      case StatusType.battery:
        if (widget.valueInt < 20) return Colors.red;
        if (widget.valueInt < 50) return Colors.orange;
        return Colors.green;

      case StatusType.signal:
        if (widget.valueInt < 30) return Colors.red;
        if (widget.valueInt < 60) return Colors.orange;
        return Colors.green;

      case StatusType.gps:
        return widget.valueInt < 6 ? Colors.red : Colors.green;

      case StatusType.armed:
        return widget.valueInt == 1 ? Colors.red : Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = _backgroundColor();

    final card = AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      padding: const EdgeInsets.all(12),
      width: 140,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(widget.title,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text(widget.value,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );

    if (widget.type == StatusType.armed && widget.valueInt == 1) {
      return ScaleTransition(
        scale: _pulseController,
        child: card,
      );
    }

    return card;
  }
}
