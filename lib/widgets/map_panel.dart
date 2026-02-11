import 'package:flutter/material.dart';
import 'panel.dart';

class MapPanel extends StatelessWidget {
  const MapPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Panel(
      title: 'Map',
      child: Image.asset(
        'assets/images/static_map.png',
        fit: BoxFit.contain,
      ),
    );
  }
}
