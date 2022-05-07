import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:probitas_app/core/error/failures.dart';
import 'package:probitas_app/core/usecases/usecases.dart';
import 'package:probitas_app/features/authentication/domain/entites/auth_entity.dart';
import 'package:probitas_app/features/authentication/domain/repository/auth_repository.dart';

class LoginUser implements UseCase<AuthenticationEntity, Params> {
  final AuthenticationRepository repository;

  LoginUser(this.repository);

  @override
  Future<Either<Failure, AuthenticationEntity>> call(Params params) async {
    return await repository.getUserAuthenticated(
        params.matricNumber, params.password);
  }
}

class Params extends Equatable {
  final String matricNumber;
  final String password;
  Params({required this.matricNumber, required this.password});

  @override
  List<Object> get props => [matricNumber, password];
}
