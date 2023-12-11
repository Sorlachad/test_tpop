import 'package:flutter_test_tpop/data/datasources/home_datasource.dart';
import 'package:flutter_test_tpop/data/repositories/home_repository_imp.dart';
import 'package:flutter_test_tpop/domain/repositories/home_repositort.dart';
import 'package:flutter_test_tpop/domain/usecases/get_seat.dart';
import 'package:flutter_test_tpop/presentation/reserve_ticket/reserve_ticket_controller.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class DependencyInjection {
  Future<void> setup() async {
    //Controllers
    getIt.registerFactory<ReserveTicketController>(
      () => ReserveTicketController(getIt<GetSeatsUseCase>()),
    );

    //Repositories
    getIt.registerFactory<ReserveTicketRepository>(() =>
        ReserveTicketRepositoryImp(
            dataSource: getIt<ReserveTicketDataSource>()));

    //Usecases
    getIt.registerFactory<GetSeatsUseCase>(
        () => GetSeatsUseCase(getIt<ReserveTicketRepository>()));

    //Datasources
    getIt.registerFactory<ReserveTicketDataSource>(
        () => ReserveTicketDataSourceImp());
  }
}
