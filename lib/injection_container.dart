import 'package:get_it/get_it.dart';
import 'package:probitas_app/data/remote/authentication/authentication_repository.dart';
import 'package:probitas_app/data/remote/authentication/authentication_service.dart';
import 'package:probitas_app/data/remote/dashboard/dasboard_repository.dart';
import 'package:probitas_app/data/remote/dashboard/dashboard_service.dart';

import 'data/local/cache.dart';

final GetIt getIt = GetIt.instance;

Future<void> injector() async {
  ///Authentication
  getIt.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepositoryImpl());
  getIt.registerLazySingleton<AuthenticationService>(
      () => AuthenticationServiceImpl(repository: getIt(), cache: getIt()));

  ///Dashboard
  getIt.registerLazySingleton<DashboardRepository>(
      () => DashboardRepositoryImpl());
  getIt.registerLazySingleton<DashBoardService>(
      () => DashBoardServiceImpl(dashboardRepository: getIt(), cache: getIt()));

  ///cache
  getIt.registerLazySingleton<Cache>(() => CacheImpl());
}
