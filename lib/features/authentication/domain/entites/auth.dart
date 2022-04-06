import 'package:equatable/equatable.dart';

class Authentication extends Equatable {
  final String matricNo;
  final String password;

  Authentication({
    required this.matricNo,
    required this.password,
  });

  @override
  List<Object?> get props => [matricNo, password];
}
