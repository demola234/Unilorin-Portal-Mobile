import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:probitas_app/core/error/failures.dart';
import 'package:probitas_app/core/usecases/usecases.dart';
import 'package:probitas_app/features/authentication/domain/entites/auth.dart';
import 'package:probitas_app/features/authentication/domain/repository/auth_repository.dart';

class GetUserLoggedIn implements UseCase<Authentication, Params> {
  final AuthenticationRepository repository;

  GetUserLoggedIn(this.repository);

  @override
  Future<Either<Failure, Authentication>> call(Params params) async {
    return await repository.getUserAuthenticated(
        params.matricNo, params.password);
  }
}

class Params extends Equatable {
  final String matricNo;
  final String password;
  Params({required this.matricNo, required this.password});

  @override
  List<Object> get props => [matricNo, password];
}
