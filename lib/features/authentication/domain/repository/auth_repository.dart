import 'package:dartz/dartz.dart';
import 'package:probitas_app/core/error/failures.dart';
import 'package:probitas_app/features/authentication/domain/entites/auth_entity.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, AuthenticationEntity>> getUserAuthenticated(
      String matricNumber, String password);
}
 