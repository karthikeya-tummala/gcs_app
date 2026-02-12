import 'package:flutter/material.dart';

class ArmedIndicator extends StatefulWidget {
  final bool isArmed;

  const ArmedIndicator({required this.isArmed, super.key});

  @override
  State<ArmedIndicator> createState() => _ArmedIndicatorState();
}

class _ArmedIndicatorState extends State<ArmedIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
      lowerBound: 0.8,
      upperBound: 0.9,
    );

    // Start animation immediately if initialized as armed
    if (widget.isArmed) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(covariant ArmedIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isArmed) {
      _controller.repeat(reverse: true);
    } else {
      _controller.stop();
      _controller.value = 1.0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Determine styles based on state
    final mainColor = widget.isArmed ? Colors.redAccent : Colors.green;
    final bgColor = widget.isArmed ?
      Colors.red.withValues(alpha: 0.15) : Colors.green.withValues(alpha: 0.15);
    final icon = widget.isArmed ? Icons.warning_rounded : Icons.check_circle_outline;
    final text = widget.isArmed ? 'ARMED' : 'DISARMED';

    // The glowing status badge
    final styledIndicator = Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(
          color: mainColor,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: mainColor.withValues(alpha: 0.3),
            blurRadius: 8.0,
            spreadRadius: 1.0,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: mainColor, size: 16),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: mainColor,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );

    // If armed, wrap it in the pulsing ScaleTransition
    if (widget.isArmed) {
      return Center( // Center helps keep the scaling balanced within the AppBar
        child: ScaleTransition(
          scale: _controller,
          child: styledIndicator,
        ),
      );
    }

    // If disarmed, just return the static green badge
    return Center(child: styledIndicator);
  }
}