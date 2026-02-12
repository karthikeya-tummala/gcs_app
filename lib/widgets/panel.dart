import 'dart:ui';
import 'package:flutter/material.dart';

class Panel extends StatelessWidget {
  final String title;
  final Widget child;
  final double padding;

  const Panel({super.key, required this.title, required this.child, this.padding = 10});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          padding: EdgeInsets.all(padding),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start, // Fix: Hugs content
            children: [
              Text(title.toUpperCase(), style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.blueAccent)),
              const SizedBox(height: 4),
              Flexible(child: child),
            ],
          ),
        ),
      ),
    );
  }
}