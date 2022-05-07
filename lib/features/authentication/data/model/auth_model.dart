import 'package:probitas_app/features/authentication/domain/entites/auth_entity.dart';

class UserModel extends AuthenticationEntity {
  UserModel({
    matricNumber,
    password,
  }) : super(
          matricNumber: matricNumber,
          password: password,
        );

  factory UserModel.fromEntity(AuthenticationEntity authenticationEntity) {
    return UserModel(
      matricNumber: authenticationEntity.matricNumber,
      password: authenticationEntity.password,
    );
  }
}
