import 'package:flutter/material.dart';
import 'package:flutter_test_tpop/core/constant.dart';
import 'package:flutter_test_tpop/presentation/reserve_ticket/reserve_ticket_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SeatRowLayout extends StatelessWidget {
  final int i;
  const SeatRowLayout({super.key, required this.i});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ReserveTicketController>();
    final value = controller.seat.value;

    Widget seat(j) {
      final status = value.seatLayout?.seats[i][j].status;
      final seatNumber = value.seatLayout?.seats[i][j].seatNumber;
      return Expanded(
        key: Key(seatNumber.toString()),
        child: Obx(
          () => GestureDetector(
            key: Key("onTap_$seatNumber"),
            onTap: () => controller.onSelectSeat(i, j),
            child: Container(
              height: 30.w,
              decoration: BoxDecoration(
                color: seatStatusDetail[status?.value]?.color,
                shape: BoxShape.circle,
              ),
              child: seatStatusDetail[status?.value]?.icon,
            ),
          ),
        ),
      );
    }

    Widget position() {
      return SizedBox(
        width: 20.w,
        height: 20.w,
        child: Text(
          "${value.seatLayout?.seats[i][0].seatNumber?[0]}",
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.w,
          ),
        ),
      );
    }

    return Row(
      children: [
        position(),
        for (var j = 0; j < value.seatLayout!.seats[i].length; j++) seat(j),
      ],
    );
  }
}
