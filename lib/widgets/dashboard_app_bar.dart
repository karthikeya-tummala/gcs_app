// dashboard_app_bar.dart
import 'dart:ui';
import 'package:flutter/material.dart';

class TransparentDashboardAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget child;

  const TransparentDashboardAppBar({super.key, required this.child});

  @override
  // Reduced height for landscape optimization
  Size get preferredSize => const Size.fromHeight(40);

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          height: preferredSize.height + statusBarHeight,
          padding: EdgeInsets.only(top: statusBarHeight),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.10),
            border: const Border(
              bottom: BorderSide(color: Colors.white10, width: 0.5),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0), // Tighter horizontal
            child: child,
          ),
        ),
      ),
    );
  }
}