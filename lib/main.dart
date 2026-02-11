import 'package:flutter/material.dart';
import 'screens/dashboard_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ground Control Station',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,

        colorScheme: const ColorScheme.light(
          surface: Color(0xFFF7F5F2), // subtle cream over white
        ),

        cardColor: const Color(0xFFF7F5F2),

        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          elevation: 2,
          foregroundColor: Colors.white,
          shadowColor: Colors.black12,
        ),

        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Color(0xFFF7F5F2),
        ),
      ),
      home: const DashboardScreen(),
    );
  }
}