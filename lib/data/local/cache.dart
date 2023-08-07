import 'package:get_storage/get_storage.dart';
import 'package:probitas_app/features/authentication/data/model/user_summary_request.dart';
import 'package:probitas_app/features/dashboard/data/model/user_request.dart';
import '../../core/error/exceptions.dart';
import '../../injection_container.dart';

abstract class Cache {
  Future<UserRequest> getUser();
  Future<UserSummaryRequest> getUserSummary();
  Future<String> getToken();
  Future clear();
  Future saveUserSummary(UserSummaryRequest userSummary);
  Future saveUser(UserRequest user);
  Future<bool> isFirstLoad();
  Future saveToken(String token);

  static Cache get() => getIt<Cache>();
}

class CacheImpl implements Cache {
  final box = GetStorage();

  @override
  Future clear() async {
    box.remove('user');
    box.remove('userSummary');
    box.remove('token');
  }

  @override
  Future<String> getToken() async {
    if (box.hasData("token")) {
      return box.read("token");
    }
    return "";
  }

  @override
  Future<UserRequest> getUser() async {
    var token = await getToken();
    if (token.isEmpty) {
      throw CustomException("Something went wrong");
    }
    return UserRequest.fromJson(box.read("user"));
  }

  @override
  Future<UserSummaryRequest> getUserSummary() async {
    var token = await getToken();
    if (token.isEmpty) {
      throw CustomException("Something went wrong");
    }
    return UserSummaryRequest.fromJson(box.read("userSummary"));
  }

  @override
  Future<bool> isFirstLoad() async {
    if (box.hasData("first")) {
      return false;
    }
    box.write("first", false);
    return true;
  }

  @override
  Future saveToken(String token) {
    return box.write('token', token);
  }

  @override
  Future saveUserSummary(UserSummaryRequest userSummary) {
    return box.write('userSummary', userSummary.toJson());
  }

  @override
  Future saveUser(UserRequest user) {
    return box.write('user', user.toJson());
  }
}
