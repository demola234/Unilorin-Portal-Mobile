import 'package:probitas_app/data/remote/authentication/authentication_repository.dart';
import 'package:probitas_app/features/authentication/data/model/user_summary_request.dart';
import '../../../features/authentication/data/model/user_request.dart';
import '../../local/cache.dart';

abstract class AuthenticationService {
  Future<UserSummaryRequest> login(String matricNumber, String password);
}

class AuthenticationServiceImpl extends AuthenticationService {
  AuthenticationRepository repository;
  Cache cache;

  AuthenticationServiceImpl({required this.repository, required this.cache});

  @override
  Future<UserSummaryRequest> login(String matricNumber, String password) async {
    var response = await repository.login(matricNumber, password);
    cache.saveUserSummary(response.data!);
    cache.saveToken(response.data!.token!);
    return response.data!;
  }
}
