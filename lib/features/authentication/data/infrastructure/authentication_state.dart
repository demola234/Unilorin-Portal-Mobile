import 'package:probitas_app/features/authentication/data/model/user_request.dart';

abstract class AuthenticationState {
  const AuthenticationState();
}

class AuthenticationInitial extends AuthenticationState {
  const AuthenticationInitial();
}

class AuthenticationLoading extends AuthenticationState {
  late bool isLoading;
  AuthenticationLoading(isLoading);
}

class AuthenticatingUser extends AuthenticationState {
  late UserRequest userRequest;
  AuthenticatingUser(userRequest);
}

class AuthenticationError extends AuthenticationState {
  late String errorMessage;
  AuthenticationError(errorMessage);
}
