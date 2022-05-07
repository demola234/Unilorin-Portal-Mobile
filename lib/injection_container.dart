import 'package:get_it/get_it.dart';
import 'package:probitas_app/data/remote/authentication/authentication_repository.dart';
import 'package:probitas_app/data/remote/authentication/authentication_service.dart';

final GetIt getIt = GetIt.instance;

Future<void> init() async {
  ///Authentication
  getIt.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepositoryImpl());
  getIt.registerLazySingleton<AuthenticationService>(
      () => AuthenticationServiceImpl(repository: getIt()));
}
