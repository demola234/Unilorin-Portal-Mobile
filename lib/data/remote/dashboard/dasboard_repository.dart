import '../../../core/error/exceptions.dart';
import '../../../core/network/base_api.dart';
import '../../../features/authentication/data/model/user_request.dart';

abstract class DashboardRepository {
  Future<UserRequest> fetchUser(String token);
}

class DashboardRepositoryImpl extends BaseApi implements DashboardRepository {
  @override
  Future<UserRequest> fetchUser(String token) async {
    try {
      var data = await get("auth/me", headers: getHeader(token));

      return UserRequest.fromJson(data['user']);
    } catch (err) {
      if (err is RequestException) {
        throw CustomException(err.message);
      }
      throw CustomException("Something went wrong");
    }
  }
}