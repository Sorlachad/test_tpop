import 'package:flutter_test_tpop/data/datasources/home_datasource.dart';
import 'package:flutter_test_tpop/data/models/seat_model.dart';
import 'package:flutter_test_tpop/domain/repositories/home_repositort.dart';

class ReserveTicketRepositoryImp implements ReserveTicketRepository {
  final ReserveTicketDataSource dataSource;

  ReserveTicketRepositoryImp({required this.dataSource});

  @override
  Future<SeatModel?> getSeats() async {
    final response = await dataSource.getSeats();
    return response;
  }
}
