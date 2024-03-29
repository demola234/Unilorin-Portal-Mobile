import 'package:get_it/get_it.dart';
import 'package:probitas_app/data/remote/assignment/assignment_repository.dart';
import 'package:probitas_app/data/remote/authentication/authentication_repository.dart';
import 'package:probitas_app/data/remote/authentication/authentication_service.dart';
import 'package:probitas_app/data/remote/dashboard/dashboard_repository.dart';
import 'package:probitas_app/data/remote/dashboard/dashboard_service.dart';
import 'package:probitas_app/data/remote/news/news_repository.dart';
import 'package:probitas_app/data/remote/news/news_service.dart';
import 'package:probitas_app/data/remote/posts/post_repository.dart';
import 'package:probitas_app/data/remote/posts/post_service.dart';
import 'package:probitas_app/data/remote/resources/resources_repository.dart';
import 'package:probitas_app/data/remote/result/result_repository.dart';
import 'package:probitas_app/data/remote/result/result_service.dart';
import 'data/local/cache.dart';
import 'data/remote/assignment/assignment_services.dart';
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

  ///Results
  getIt.registerLazySingleton<ResultRepository>(() => ResultRepositoryImpl());
  getIt.registerLazySingleton<ResultService>(
      () => ResultServiceImpl(cache: getIt(), resultRepository: getIt()));

  ///Assignment
  getIt.registerLazySingleton<AssignmentRepository>(
      () => AssignmentRepositoryImpl());
  getIt.registerLazySingleton<AssignmentService>(() =>
      AssignmentServiceImpl(assignmentRepository: getIt(), cache: getIt()));

  ///cache
  getIt.registerLazySingleton<Cache>(() => CacheImpl());
}
