import 'package:flutter_test_tpop/domain/entities/seat_entity.dart';

abstract class ReserveTicketRepository {
  Future<SeatEntity?> getSeats();
}
