import 'package:probitas_app/features/authentication/data/model/user_summary_response.dart';

import '../../../core/network/base_api.dart';

abstract class AuthenticationRepository {
  Future<UserSummaryResponse> login(String matricNumber, String password);
}

class AuthenticationRepositoryImpl extends BaseApi
    implements AuthenticationRepository {
  @override
  Future<UserSummaryResponse> login(
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
    final s = UserSummaryResponse.fromJson(data);
    return s;
  }
}
