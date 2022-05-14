import 'package:probitas_app/data/remote/dashboard/dashboard_repository.dart';
import '../../../features/dashboard/data/model/user_response.dart';
import '../../local/cache.dart';

abstract class DashBoardService {
  Future<UserResponses> fetchUsers();
}

class DashBoardServiceImpl extends DashBoardService {
  DashboardRepository dashboardRepository;
  Cache cache;

  DashBoardServiceImpl(
      {required this.dashboardRepository, required this.cache});

  @override
  Future<UserResponses> fetchUsers() async {
    return dashboardRepository.fetchUser(await cache.getToken());
  }
}
