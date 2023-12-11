import 'package:flutter/material.dart';
import 'package:flutter_test_tpop/core/enum.dart';

class SeatStatusDetail {
  final String name;
  final Color color;
  final Icon? icon;

  SeatStatusDetail({required this.name, required this.color, this.icon});
}

final seatStatusDetail = {
  SeatStatus.available: SeatStatusDetail(
    name: SeatStatus.available.name,
    color: Colors.green,
  ),
  SeatStatus.unavailable: SeatStatusDetail(
    name: SeatStatus.unavailable.name,
    color: Colors.grey,
  ),
  SeatStatus.select: SeatStatusDetail(
    name: SeatStatus.select.name,
    color: Colors.blue.shade800,
    icon: const Icon(
      Icons.check,
      color: Colors.white,
    ),
  )
};
