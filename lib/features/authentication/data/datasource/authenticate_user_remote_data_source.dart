import 'package:probitas_app/core/network/network_info.dart';

abstract class AuthenticationRemoteDataSource {
  Future getUserAuthenticated(String username, String password);
}

class AuthenticationRemoteDataSourceImp extends BaseApi
    implements AuthenticationRemoteDataSource {
  @override
  Future getUserAuthenticated(String username, String password) async {
    return await post('user/auth/signin',
        data: {"username": username, "password": password});
  }
}
