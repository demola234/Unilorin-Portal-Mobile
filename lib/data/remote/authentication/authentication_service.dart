import 'package:probitas_app/data/remote/authentication/authentication_repository.dart';
import '../../../features/authentication/data/model/user_request.dart';
import '../../local/cache.dart';

abstract class AuthenticationService {
  Future<UserRequest?> login(String matricNumber, String password);
}

class AuthenticationServiceImpl extends AuthenticationService {
  AuthenticationRepository repository;
  Cache cache;

  AuthenticationServiceImpl({required this.repository, required this.cache});

  @override
  Future<UserRequest?> login(String matricNumber, String password) async {
    var response = await repository.login(matricNumber, password);
    cache.saveUser(response.data);
    cache.saveToken(response.data.token);
    return response.data;
  }
}
