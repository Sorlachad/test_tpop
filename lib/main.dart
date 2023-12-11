import 'package:flutter/material.dart';
import 'package:flutter_test_tpop/dependency_injection.dart';
import 'package:flutter_test_tpop/presentation/reserve_ticket/reserve_ticket.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test_tpop/presentation/reserve_ticket/reserve_ticket_controller.dart';
import 'package:get/get.dart';

void main() async {
  await DependencyInjection().setup();
  Get.lazyPut(
    () => getIt<ReserveTicketController>(),
    fenix: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: GetMaterialApp(
        title: 'test T-POP',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          appBarTheme: AppBarTheme(backgroundColor: Colors.deepPurple.shade300),
        ),
        home: const ReserveTicket(),
      ),
    );
  }
}
