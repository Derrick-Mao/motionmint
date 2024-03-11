import 'package:motionmint/bar%20graph/single_bar.dart';

class BarData {
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thuAmount;
  final double friAmount;
  final double satAmount;
  final double sunAmount;

  BarData({
    required this.monAmount,
    required this.tueAmount,
    required this.wedAmount,
    required this.thuAmount,
    required this.friAmount,
    required this.satAmount,
    required this.sunAmount,
  });

  List<SingleBar> barData = [];

  void initBarData() {
    barData = [
      // monday
      SingleBar(x: 0, y: monAmount),

      // tuesday
      SingleBar(x: 1, y: tueAmount),

      // wednesday
      SingleBar(x: 2, y: wedAmount),

      // thursday
      SingleBar(x: 3, y: thuAmount),

      // friday
      SingleBar(x: 4, y: friAmount),

      // saturday
      SingleBar(x: 5, y: satAmount),

      // sunday
      SingleBar(x: 6, y: sunAmount),
    ];
  }
}