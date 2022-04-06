import 'package:probitas_app/features/authentication/domain/entites/auth.dart';

class AuthenticationModel extends Authentication {
  AuthenticationModel({
    required String matricNo,
    required String password,
  }) : super(matricNo: matricNo, password: password);

  Map<String, dynamic> toJson() {
    return {
      "matricNo": matricNo,
      "password": password,
    };
  }
}
