import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class DashboardController extends ChangeNotifier {
  final Random _random = Random();
  late Timer _timer;

  int battery = 75;
  int gps = 10;
  int signal = 80;
  bool armed = false;

  double altitude = 120;
  double groundSpeed = 7;
  double verticalSpeed = -0.3;
  int heading = 245;

  double voltage = 14.8;
  double current = 9.2;
  double consumed = 1.6;

  int rssi = -62;
  int latency = 120;

  void start() {
    _timer = Timer.periodic(const Duration(seconds: 2), (_) {
      battery = (battery + _random.nextInt(11) - 5).clamp(0, 100);
      gps = 6 + _random.nextInt(10);
      signal = (signal + _random.nextInt(15) - 7).clamp(0, 100);
      armed = _random.nextBool();

      altitude += _random.nextDouble() * 4 - 2;
      groundSpeed = (groundSpeed + _random.nextDouble() - 0.5).clamp(0, 50);
      verticalSpeed = _random.nextDouble() * 2 - 1;
      heading = (heading + _random.nextInt(20) - 10) % 360;

      voltage = 14.0 + _random.nextDouble();
      current = 8 + _random.nextDouble() * 4;
      consumed += 0.05;

      rssi = -70 + _random.nextInt(15);
      latency = 100 + _random.nextInt(50);

      notifyListeners();
    });
  }

  void disposeController() {
    _timer.cancel();
  }
}
