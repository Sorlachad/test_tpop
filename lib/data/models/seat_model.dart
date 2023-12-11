import 'package:flutter_test_tpop/domain/entities/seat_entity.dart';
import 'package:collection/collection.dart';
import 'package:flutter_test_tpop/core/enum.dart';
import 'package:get/get.dart';

class SeatModel extends SeatEntity {
  SeatModel({VenueModel? venue, SeatLayoutModel? seatLayout})
      : super(venue: venue, seatLayout: seatLayout);

  factory SeatModel.fromJson(Map<String, dynamic> json) {
    return SeatModel(
      venue: VenueModel.froJson(json['venue']),
      seatLayout: SeatLayoutModel.froJson(json['seatLayout']),
    );
  }
}

class VenueModel extends VenueEntity {
  VenueModel({String? name, int? capacity})
      : super(name: name, capacity: capacity);

  factory VenueModel.froJson(Map<String, dynamic> json) {
    return VenueModel(
      name: json['name'],
      capacity: json['capacity'],
    );
  }
}

class SeatLayoutModel extends SeatLayoutEntity {
  SeatLayoutModel({
    int? rows,
    int? columns,
    required List<List<SeatPositionModel>> seats,
  }) : super(columns: columns, rows: rows, seats: seats);

  factory SeatLayoutModel.froJson(Map<String, dynamic> json) {
    final col = <List<SeatPositionModel>>[];

    if (json['seats'] is List) {
      var nameCol = '';
      var rows = <SeatPositionModel>[];
      (json['seats'] as List).forEachIndexed((index, element) {
        if (nameCol.isEmpty) {
          nameCol = element['seatNumber'][0];
          rows.add(SeatPositionModel.fromJson(element));
        } else if (index == json['seats'].length - 1) {
          rows.add(SeatPositionModel.fromJson(element));
          col.add(rows);
        } else if (nameCol == element['seatNumber'][0]) {
          rows.add(SeatPositionModel.fromJson(element));
        } else {
          col.add(rows);
          rows = [];
          nameCol = element['seatNumber'][0];
          rows.add(SeatPositionModel.fromJson(element));
        }
      });
    }
    return SeatLayoutModel(
      rows: json['rows'],
      columns: json['columns'],
      seats: col,
    );
  }
}

class SeatPositionModel extends SeatPositionEntity {
  SeatPositionModel({
    String? seatNumber,
    Rx<SeatStatus>? status,
  }) : super(seatNumber: seatNumber, status: status);

  factory SeatPositionModel.fromJson(Map<String, dynamic> json) {
    return SeatPositionModel(
      seatNumber: json['seatNumber'],
      status: Rx((json['status'] as String).toSeatStatus()),
    );
  }
}
