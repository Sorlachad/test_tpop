import 'package:flutter_test_tpop/core/enum.dart';
import 'package:get/get.dart';

class SeatEntity {
  VenueEntity? venue;
  SeatLayoutEntity? seatLayout;

  SeatEntity({
    this.venue,
    this.seatLayout,
  });
}

class VenueEntity {
  String? name;
  int? capacity;

  VenueEntity({
    this.name,
    this.capacity,
  });
}

class SeatLayoutEntity {
  int? rows;
  int? columns;
  List<List<SeatPositionEntity>> seats;
  SeatLayoutEntity({
    this.rows,
    this.columns,
    required this.seats,
  });
}

class SeatPositionEntity {
  String? seatNumber;
  Rx<SeatStatus>? status;

  SeatPositionEntity({
    this.seatNumber,
    this.status,
  });
}
