import 'package:flutter_test_tpop/core/use_case.dart';
import 'package:flutter_test_tpop/domain/entities/seat_entity.dart';
import 'package:flutter_test_tpop/domain/repositories/home_repositort.dart';

class GetSeatsUseCase implements UseEmptyParam<SeatEntity?> {
  final ReserveTicketRepository reserveTicketRepository;

  GetSeatsUseCase(this.reserveTicketRepository);

  @override
  Future<SeatEntity?> call() {
    final response = reserveTicketRepository.getSeats();
    return response;
  }
}
