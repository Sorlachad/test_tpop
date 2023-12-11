import 'package:flutter/material.dart';
import 'package:flutter_test_tpop/core/enum.dart';
import 'package:flutter_test_tpop/data/models/seat_model.dart';
import 'package:flutter_test_tpop/domain/usecases/get_seat.dart';
import 'package:get/get.dart';

class ReserveTicketController extends GetxController {
  final GetSeatsUseCase _getSeatsUseCase;
  ReserveTicketController(this._getSeatsUseCase) {
    //getSeats();
  }

  final seat = SeatModel().obs;
  final scrollController = ScrollController();
  final scrollSelectZoneController = FixedExtentScrollController();
  final keySelectZone = GlobalKey(debugLabel: 'select_seat');
  final keySelectSeat = GlobalKey(debugLabel: 'select_seat');

  final isOpenCartDetail = false.obs;
  final cart = <SeatPositionModel>[].obs;
  final zone = ''.obs;
  var zoneSelect = '';

  setIsOpenCartDetail() {
    isOpenCartDetail.value = !isOpenCartDetail.value;
  }

  resetSeat() {
    seat.value = SeatModel();
  }

  getSeats() async {
    final response = await _getSeatsUseCase.call();

    if (response != null) {
      seat.value = response as SeatModel;
    }
  }

  changeStatus(SeatStatus status, indexCol, indexRow) {
    seat.value.seatLayout?.seats[indexCol][indexRow].status?.value = status;
  }

  onSelectZone() async {
    if (zoneSelect.isEmpty) {
      zone.value = "Zone A";
    } else {
      zone.value = zoneSelect;
    }
    await Future.delayed(const Duration(milliseconds: 500));

    if (keySelectSeat.currentContext != null) {
      Scrollable.ensureVisible(
        keySelectSeat.currentContext!,
        duration: const Duration(milliseconds: 500),
      );
    }

    await getSeats();
  }

  onSelectSeat(indexCol, indexRow) {
    final value = seat.value.seatLayout?.seats[indexCol][indexRow];
    switch (value?.status?.value) {
      case SeatStatus.available:
        changeStatus(SeatStatus.select, indexCol, indexRow);
        cart.add(value as SeatPositionModel);
        break;
      case SeatStatus.select:
        changeStatus(SeatStatus.available, indexCol, indexRow);
        cart.removeWhere((element) => element.seatNumber == value?.seatNumber);
        break;
      default:
    }
  }

  getCartSeatNumber() {
    return cart.map((e) => e.seatNumber).join(',');
  }

  onTapBackSelectZone() {
    zone.value = '';
    if (keySelectZone.currentContext != null) {
      Scrollable.ensureVisible(
        keySelectZone.currentContext!,
        duration: const Duration(seconds: 1),
      ).then(
        (value) => resetSeat(),
      );
    }
  }
}
