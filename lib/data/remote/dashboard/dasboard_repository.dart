import '../../../core/error/exceptions.dart';
import '../../../core/network/base_api.dart';
import '../../../features/authentication/data/model/user_request.dart';
import '../../../features/dashboard/data/model/user_response.dart';

abstract class DashboardRepository {
  Future<UserResponses> fetchUser(String token);
}

class DashboardRepositoryImpl extends BaseApi implements DashboardRepository {
  @override
  Future<UserResponses> fetchUser(String token) async {
    try {
      var data = await get("auth/me", headers: getHeader(token));
      final s = UserResponses.fromJson(data);
      return s;
    } catch (err) {
      if (err is RequestException) {
        throw CustomException(err.message);
      }
      throw CustomException("Something went wrong");
    }
  }
}
