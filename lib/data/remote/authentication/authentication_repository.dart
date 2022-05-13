import 'package:probitas_app/features/authentication/data/model/user_response.dart';

import '../../../core/network/base_api.dart';

abstract class AuthenticationRepository {
  Future<UserResponse> login(String matricNumber, String password);
}

class AuthenticationRepositoryImpl extends BaseApi
    implements AuthenticationRepository {
  @override
  Future<UserResponse> login(
    String matricNumber,
    String password,
  ) async {
    var data = await post(
      "auth/signin",
      data: {
        "matricNumber": matricNumber,
        "password": password,
      },
    );
    final s = UserResponse.fromJson(data);
    print(s.data!.token);
    return s;
  }
}
