import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_tpop/core/enum.dart';
import 'package:flutter_test_tpop/dependency_injection.dart';
import 'package:flutter_test_tpop/presentation/reserve_ticket/reserve_ticket.dart';
import 'package:flutter_test_tpop/presentation/reserve_ticket/reserve_ticket_controller.dart';
import 'package:get/get.dart';
import 'package:integration_test/integration_test.dart';

class Wrapper extends StatelessWidget {
  final Widget child;
  Wrapper(this.child);
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(100, 200));
    return child;
  }
}

Widget testableWidget({required Widget child}) {
  return MediaQuery(
    data: const MediaQueryData(),
    child: CupertinoApp(
      home: Scaffold(body: Wrapper(child)),
    ),
  );
}

Future<void> waitValue(WidgetTester widgetTester, Finder finder) async {
  final timer = Timer(const Duration(seconds: 10), () {});
  while (true) {
    await widgetTester.pump(const Duration(milliseconds: 500));
    final found = widgetTester.any(finder);

    if (found || !timer.isActive) return;
  }
}

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  await DependencyInjection().setup();
  final controller = Get.put(getIt<ReserveTicketController>());

  group('Reserve Ticket Integration Test', () {
    testWidgets('Select Zone', (widgetTester) async {
      await widgetTester.pumpWidget(
        testableWidget(
          child: const GetMaterialApp(
            home: ReserveTicket(
              integrationTest: true,
            ),
          ),
        ),
      );
      // await widgetTester.pumpWidget(
      //   ScreenUtilInit(
      //     child: GetMaterialApp(
      //       home: Wrapper(
      //         const ReserveTicket(
      //           integrationTest: true,
      //         ),
      //       ),
      //     ),
      //   ),
      // );

      final title = find.byKey(const Key('title'));
      final backSelectZone = find.byKey(const Key('back_select_zone'));
      final zoneImage = find.byKey(const Key('zone_image'));
      final selectZone = find.byKey(const Key('select_zone'));

      expect(title, findsWidgets);

      expect(backSelectZone, findsNothing);
      expect(zoneImage, findsWidgets);
      expect(selectZone, findsWidgets);
    });

    testWidgets('Cupertino Zone', (widgetTester) async {
      await widgetTester.pumpWidget(
        testableWidget(
          child: const GetMaterialApp(
            home: ReserveTicket(
              integrationTest: true,
            ),
          ),
        ),
      );

      final selectZone = find.byKey(const Key('select_zone'));
      final cupertinoSelectZone =
          find.byKey(const Key('cupertino_select_zone'));

      final zoneA = find.byKey(const Key('zone_a'));
      final ontapDoneZone = find.byKey(const Key('ontap_done_zone'));

      expect(selectZone, findsWidgets);

      await widgetTester.tap(selectZone);

      await widgetTester.pumpAndSettle();

      expect(ontapDoneZone, findsWidgets);

      expect(cupertinoSelectZone, findsWidgets);

      await widgetTester.dragUntilVisible(
          zoneA, cupertinoSelectZone, Offset(0, 1000.w));

      controller.zoneSelect = "Zone A";

      await widgetTester.tap(ontapDoneZone);

      expect(controller.zone.value, controller.zoneSelect);
    });

    testWidgets('select seat', (widgetTester) async {
      await widgetTester.pumpWidget(
        testableWidget(
          child: const GetMaterialApp(
            home: ReserveTicket(
              integrationTest: true,
            ),
          ),
        ),
      );

      final selectZone = find.byKey(const Key('select_zone'));

      await widgetTester.tap(selectZone);

      await widgetTester.pumpAndSettle();

      final ontapDoneZone = find.byKey(const Key('ontap_done_zone'));

      await widgetTester.tap(ontapDoneZone);

      final stage = find.byKey(const Key('stage'));

      expect(stage, findsOneWidget);

      final seatLayout = find.byKey(const Key('seat_layout'));

      await waitValue(widgetTester, seatLayout);

      final backSelectZone = find.byKey(const Key('back_select_zone'));
      final available = find.byKey(const Key('available'));
      final unavailable = find.byKey(const Key('unavailable'));
      final select = find.byKey(const Key('select'));

      final seats = controller.seat.value.seatLayout?.seats;

      final seatValue = controller.seat.value.seatLayout?.seats.last.last;

      final seat = find.byKey(Key(seatValue!.seatNumber.toString()));

      expect(backSelectZone, findsOneWidget);
      expect(available, findsOneWidget);
      expect(unavailable, findsOneWidget);
      expect(select, findsOneWidget);

      expect(seat, findsOneWidget);

      final onTapSeat = find.byKey(Key("onTap_${seatValue.seatNumber}"));

      final cart = find.byKey(const Key('cart'));

      expect(onTapSeat, findsOneWidget);

      await controller.onSelectSeat(
        seats!.length - 1,
        seats.last.length - 1,
      );

      expect(seatValue.status?.value, SeatStatus.select);

      if (controller.cart.isNotEmpty) {
        print("CART SHOW");
        await widgetTester.pumpAndSettle();
        expect(cart, findsOneWidget);
        expect(
          find.byKey(Key('amount_ticket_${controller.cart.length}')),
          findsOneWidget,
        );
      }

      await controller.onSelectSeat(
        seats.length - 1,
        seats.last.length - 1,
      );

      controller.cart
          .removeWhere((element) => element.seatNumber == seatValue.seatNumber);

      if (controller.cart.isEmpty) {
        print("CART HIDE");
        await widgetTester.pumpAndSettle();
        expect(cart, findsNothing);
      }

      controller.zone.value = '';

      await widgetTester.pumpAndSettle();

      expect(backSelectZone, findsNothing);
    });
  });
}
