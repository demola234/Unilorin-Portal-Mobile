import 'package:get_storage/get_storage.dart';
import 'package:probitas_app/features/authentication/data/model/user_request.dart';
import '../../core/error/exceptions.dart';
import '../../injection_container.dart';

abstract class Cache {
  Future<UserRequest> getUser();
  Future<String> getToken();
  Future clear();
  Future saveUser(UserRequest user);
  Future saveToken(String? token);

  static Cache get() => getIt<Cache>();
}

class CacheImpl implements Cache {
  final box = GetStorage();

  @override
  Future clear() async {
    box.remove('user');
    box.remove('token');
  }

  @override
  Future<String> getToken() async {
    return box.read("token");
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
  Future saveToken(String? token) {
    return box.write('token', token);
  }

  @override
  Future saveUser(UserRequest user) {
    return box.write('user', user.toJson());
  }
}
