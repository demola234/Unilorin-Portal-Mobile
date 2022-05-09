import 'package:probitas_app/data/remote/dashboard/dasboard_repository.dart';
import 'package:probitas_app/features/authentication/data/model/user_request.dart';
import '../../local/cache.dart';

abstract class DashBoardService {
  Future<UserRequest> fetchUsers(String token);
}

class DashBoardServiceImpl extends DashBoardService {
  DashboardRepository dashboardRepository;
  Cache cache;

  DashBoardServiceImpl(
      {required this.dashboardRepository, required this.cache});

  @override
  Future<UserRequest> fetchUsers(String token) async {
    return dashboardRepository.fetchUser(await cache.getToken());
  }
}