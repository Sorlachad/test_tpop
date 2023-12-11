import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test_tpop/core/constant.dart';

import 'package:flutter_test_tpop/presentation/reserve_ticket/reserve_ticket_controller.dart';
import 'package:flutter_test_tpop/presentation/reserve_ticket/widget/seatLayout.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zoom_widget/zoom_widget.dart';

class ReserveTicket extends StatefulWidget {
  final bool integrationTest;
  const ReserveTicket({super.key, this.integrationTest = false});

  @override
  State<ReserveTicket> createState() => _ReserveTicketState();
}

class _ReserveTicketState extends State<ReserveTicket> {
  final controller = Get.find<ReserveTicketController>();

  @override
  Widget build(BuildContext context) {
    if (widget.integrationTest) {
      ScreenUtil.init(context, designSize: const Size(600, 900));
    }
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "จองตั๋ว T-POP",
          key: Key('title'),
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Obx(
            () => Visibility(
              visible: controller.zone.isNotEmpty,
              child: GestureDetector(
                key: const Key('back_select_zone'),
                onTap: () {
                  controller.onTapBackSelectZone();
                },
                child: Container(
                  margin: EdgeInsets.only(right: 10.w),
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.w),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade900,
                    borderRadius: BorderRadius.circular(10.w),
                  ),
                  child: Text(
                    'Select Zone',
                    style: TextStyle(color: Colors.white, fontSize: 10.w),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            ListView(
              controller: controller.scrollController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                SizedBox(
                  key: controller.keySelectZone,
                  height: widget.integrationTest
                      ? null
                      : MediaQuery.of(context).size.height -
                          kToolbarHeight -
                          30.w,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30.w,
                      ),
                      Container(
                        key: const Key('zone_image'),
                        width: 1.sw,
                        height: 1.sh * 0.5,
                        color: Colors.black,
                        child: Visibility(
                          visible: widget.integrationTest == false,
                          child: Zoom(
                            initScale: 1,
                            maxZoomWidth: 1.sw,
                            maxZoomHeight: 1.sh * 0.5,
                            backgroundColor: Colors.black,
                            canvasColor: Colors.black,
                            colorScrollBars: Colors.deepPurple,
                            child: Image.network(
                              'https://m.thaiticketmajor.com/img_seat/prefix_1/0586/3586/3586-64910d5f99b26-s.png',
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        key: const Key('select_zone'),
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    color: Colors.black,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16.w),
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          key: const Key('ontap_done_zone'),
                                          onTap: () async {
                                            Navigator.pop(context);
                                            controller.onSelectZone();
                                          },
                                          child: const Text(
                                            "Done",
                                            style:
                                                TextStyle(color: Colors.blue),
                                          ),
                                        ),
                                        const Spacer(),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text(
                                            "Cancel",
                                            style:
                                                TextStyle(color: Colors.blue),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height:
                                        widget.integrationTest ? 300 : 300.w,
                                    key:
                                        const ValueKey("cupertino_select_zone"),
                                    child: CupertinoPicker(
                                      scrollController:
                                          controller.scrollSelectZoneController,
                                      backgroundColor: Colors.black,
                                      selectionOverlay: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        color: Colors.deepPurple.shade300
                                            .withOpacity(0.3),
                                      ),
                                      itemExtent: 30,
                                      onSelectedItemChanged: (value) {
                                        controller.zoneSelect = value == 0
                                            ? "Zone A"
                                            : value == 1
                                                ? "Zone B"
                                                : "Zone C";
                                      },
                                      children: const [
                                        Text(
                                          "Zone A",
                                          key: Key("zone_a"),
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Text(
                                          "Zone B",
                                          key: Key("zone_b"),
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Text(
                                          "Zone C",
                                          key: Key("zone_c"),
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 10.w),
                          margin: EdgeInsets.symmetric(horizontal: 16.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.w),
                            border:
                                Border.all(color: Colors.deepPurple.shade300),
                          ),
                          child: Center(
                            child: Obx(
                              () => Text(
                                controller.zone.value.isEmpty
                                    ? "Select Zone"
                                    : controller.zone.value,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 2,
                  color: Colors.deepPurple.shade300,
                ),
                IntrinsicHeight(
                  child: Container(
                    height: 1.sh,
                    key: controller.keySelectSeat,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    margin: EdgeInsets.only(top: 30.w),
                    child: Column(
                      children: [
                        Container(
                          key: const Key('stage'),
                          padding: EdgeInsets.symmetric(vertical: 10.w),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.red.shade500,
                            borderRadius: BorderRadius.circular(30.w),
                          ),
                          child: const Center(
                            child: Text(
                              "STAGE",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30.w,
                        ),
                        Obx(
                          () => Expanded(
                            child: seatLayout(),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            Obx(
              () => Visibility(
                visible: controller.cart.isNotEmpty,
                child: Positioned(
                  bottom: 0,
                  width: 1.sw,
                  child: cart(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget cart() {
    return Container(
      key: const Key('cart'),
      decoration: BoxDecoration(
        color: Colors.blue.shade900,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 16.w,
            ),
            child: Row(
              children: [
                Text(
                  "จำนวน ${controller.cart.length} ที่นั่ง",
                  key: Key('amount_ticket_${controller.cart.length}'),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.w,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    controller.setIsOpenCartDetail();
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.w, horizontal: 30.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.w),
                      border: Border.all(color: Colors.white),
                    ),
                    child: Text(
                      "Tap to detail",
                      style: TextStyle(color: Colors.white, fontSize: 10.w),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Obx(
            () => AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              height: controller.isOpenCartDetail.value ? 1.sh * 0.5 : 0,
              color: Colors.white,
              child: SafeArea(
                child: ListView(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.w),
                  children: [
                    Text(
                      'Zone A',
                      style: TextStyle(color: Colors.black, fontSize: 16.w),
                    ),
                    SizedBox(
                      height: 10.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 5.w),
                          child: Row(
                            children: [
                              Text(
                                'รอบการแสดง',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12.w,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                'Sun 10 Dec 2023 17:00',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12.w,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 5.w),
                          child: Row(
                            children: [
                              Text(
                                'โซนที่นั่ง',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12.w,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  controller.getCartSeatNumber(),
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 11.w,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 5.w),
                          child: Row(
                            children: [
                              Text(
                                'ราคาบัตร',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12.w,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                '3800',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12.w,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget seatLayout() {
    final value = controller.seat.value;
    if (value.seatLayout != null && value.seatLayout!.seats.isNotEmpty) {
      final rows = [];
      final positionCols = [];
      for (var i = 0; i < value.seatLayout!.seats.length; i++) {
        final widget = SeatRowLayout(i: i);
        final space = SizedBox(
          height: 16.w,
        );
        final positionCol = Expanded(
          child: Text(
            '${i + 1}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        );
        positionCols.add(positionCol);
        rows.addAll([widget, space]);
      }
      return Column(
        key: const Key('seat_layout'),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var element in seatStatusDetail.values) ...[
                Container(
                  width: 10.w,
                  height: 10.w,
                  decoration: BoxDecoration(
                    color: element.color,
                  ),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  key: Key(element.name),
                  element.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.w,
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
              ],
              GestureDetector(
                onTap: () {
                  controller.cart.clear();
                  controller.getSeats();
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                    ),
                  ),
                  child: Icon(
                    Icons.replay,
                    size: 18.w,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 16.w,
          ),
          Row(
            children: [
              SizedBox(
                width: 20.w,
                height: 20.w,
              ),
              ...positionCols
            ],
          ),
          SizedBox(
            height: 16.w,
          ),
          ...rows
        ],
      );
    }
    return const SizedBox();
  }
}
