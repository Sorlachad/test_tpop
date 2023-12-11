import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_tpop/core/enum.dart';
import 'package:flutter_test_tpop/dependency_injection.dart';
import 'package:flutter_test_tpop/presentation/reserve_ticket/reserve_ticket_controller.dart';
import 'package:get/get.dart';

void main() {
  DependencyInjection().setup();
  final controller = Get.put(getIt<ReserveTicketController>());
  group('Reserve Ticket Unit Test', () {
    setUp(() {
      controller.resetSeat();
    });
    test('Select Zone', () async {
      controller.zoneSelect = 'Zone A';

      await controller.onSelectZone();

      expect(controller.zone.value, controller.zoneSelect);

      expect(controller.seat.value.seatLayout?.seats, isNotEmpty);
    });

    test('getSeat', () async {
      await controller.getSeats();

      expect(controller.seat.value.seatLayout, isNotNull);

      expect(controller.seat.value.seatLayout?.seats, isNotEmpty);

      expect(controller.seat.value.venue, isNotNull);

      expect(controller.seat.value.venue?.name, isNotNull);

      expect(controller.seat.value.venue?.capacity, greaterThan(0));

      expect(controller.seat.value.seatLayout?.seats[0], isNotEmpty);

      expect(
          controller.seat.value.seatLayout?.seats[0][0].seatNumber, isNotNull);

      expect(controller.seat.value.seatLayout?.seats[0][0].status, isNotNull);
    });

    group('Change SeatStatus', () {
      test('change Status to Select', () async {
        const col = 0;
        const row = 0;
        await controller.getSeats();

        controller.changeStatus(SeatStatus.select, col, row);

        expect(controller.seat.value.seatLayout?.seats[col][row].status?.value,
            SeatStatus.select);
      });

      test('change Status to Available', () async {
        const col = 0;
        const row = 0;

        await controller.getSeats();

        controller.changeStatus(SeatStatus.select, col, row);

        expect(controller.seat.value.seatLayout?.seats[col][row].status?.value,
            SeatStatus.select);

        controller.changeStatus(SeatStatus.available, col, row);

        expect(controller.seat.value.seatLayout?.seats[col][row].status?.value,
            SeatStatus.available);
      });
    });

    test('onSeatSelect Available', () async {
      const col = 0;
      const row = 0;
      await controller.getSeats();

      controller.onSelectSeat(col, row);
      final seat = controller.seat.value.seatLayout?.seats[col][row];
      expect(seat?.status?.value, SeatStatus.select);

      expect(controller.cart[0].seatNumber, seat?.seatNumber);
    });

    test('onSeatSelect Select', () async {
      const col = 0;
      const row = 0;
      await controller.getSeats();

      controller.onSelectSeat(col, row);

      final seat = controller.seat.value.seatLayout?.seats[col][row];
      expect(seat?.status?.value, SeatStatus.select);

      expect(controller.cart[0].seatNumber, seat?.seatNumber);

      controller.onSelectSeat(col, row);

      expect(seat?.status?.value, SeatStatus.available);

      expect(controller.cart, isEmpty);
    });
  });
}
