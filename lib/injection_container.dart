import 'package:get_it/get_it.dart';
import 'package:probitas_app/data/remote/authentication/authentication_repository.dart';
import 'package:probitas_app/data/remote/authentication/authentication_service.dart';
import 'package:probitas_app/data/remote/dashboard/dashboard_repository.dart';
import 'package:probitas_app/data/remote/dashboard/dashboard_service.dart';
import 'package:probitas_app/data/remote/news/news_repository.dart';
import 'package:probitas_app/data/remote/news/news_service.dart';
import 'package:probitas_app/data/remote/posts/post_repository.dart';
import 'package:probitas_app/data/remote/posts/post_service.dart';
import 'package:probitas_app/data/remote/resources/resources_repository.dart';
import 'data/local/cache.dart';
import 'data/remote/resources/resources_services.dart';

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

  ///News
  getIt.registerLazySingleton<NewsRepository>(() => NewsRepositoryImpl());
  getIt.registerLazySingleton<NewsService>(
      () => NewsServiceImpl(cache: getIt(), newsRepository: getIt()));

  ///Post
  getIt.registerLazySingleton<PostRepository>(() => PostRepositoryImpl());
  getIt.registerLazySingleton<PostService>(
      () => PostServiceImpl(cache: getIt(), postRepository: getIt()));

  ///Resources
  getIt.registerLazySingleton<ResourceRepository>(
      () => ResourceRepositoryRepositoryImpl());
  getIt.registerLazySingleton<ResourcesService>(
      () => ResourcesServiceImpl(cache: getIt(), resourceRepository: getIt()));

  ///cache
  getIt.registerLazySingleton<Cache>(() => CacheImpl());
}
