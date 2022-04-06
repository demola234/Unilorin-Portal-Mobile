import 'package:dartz/dartz.dart';
import 'package:probitas_app/core/error/failures.dart';
import 'package:probitas_app/features/authentication/domain/entites/auth.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, Authentication>> getUserAuthenticated(
      String matricNo, String password);
}
