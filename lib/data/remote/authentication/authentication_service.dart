import 'package:probitas_app/data/remote/authentication/authentication_repository.dart';
import '../../../features/authentication/data/model/user_request.dart';

abstract class AuthenticationService {
  Future<UserRequest> login(String matricNumber, String password);
}

class AuthenticationServiceImpl extends AuthenticationService {
  AuthenticationRepository repository;

  AuthenticationServiceImpl({required this.repository});

  @override
  Future<UserRequest> login(String matricNumber, String password) async {
    var response = await repository.login(matricNumber, password);
    return response.userRequest;
  }
}
