import 'package:flutter_test_tpop/api_service.dart';
import 'package:flutter_test_tpop/data/models/seat_model.dart';

abstract class ReserveTicketDataSource {
  Future<SeatModel?> getSeats();
}

class ReserveTicketDataSourceImp extends ReserveTicketDataSource {
  final apiService = ApiService();

  @override
  Future<SeatModel?> getSeats() async {
    try {
      final response = await apiService.dioClient.get('test/seating.json');
      // response.data = {
      //   "venue": {"name": "Sample Venue", "capacity": 25},
      //   "seatLayout": {
      //     "rows": 5,
      //     "columns": 5,
      //     "seats": [
      //       {"seatNumber": "A1", "status": "available"},
      //       {"seatNumber": "A2", "status": "available"},
      //       {"seatNumber": "A3", "status": "available"},
      //       {"seatNumber": "A4", "status": "unavailable"},
      //       {"seatNumber": "A5", "status": "unavailable"},
      //       {"seatNumber": "B1", "status": "available"},
      //       {"seatNumber": "B2", "status": "available"},
      //       {"seatNumber": "B3", "status": "unavailable"},
      //       {"seatNumber": "B4", "status": "available"},
      //       {"seatNumber": "B5", "status": "unavailable"},
      //       {"seatNumber": "C1", "status": "available"},
      //       {"seatNumber": "C2", "status": "available"},
      //       {"seatNumber": "C3", "status": "available"},
      //       {"seatNumber": "C4", "status": "available"},
      //       {"seatNumber": "C5", "status": "available"},
      //       {"seatNumber": "D1", "status": "available"},
      //       {"seatNumber": "D2", "status": "available"},
      //       {"seatNumber": "D3", "status": "available"},
      //       {"seatNumber": "D4", "status": "available"},
      //       {"seatNumber": "D5", "status": "available"},
      //       {"seatNumber": "E1", "status": "available"},
      //       {"seatNumber": "E2", "status": "available"},
      //       {"seatNumber": "E3", "status": "available"},
      //       {"seatNumber": "E4", "status": "available"},
      //       {"seatNumber": "E5", "status": "available"}
      //     ]
      //   }
      // };

      if (response.statusCode == 200) {
        return SeatModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
