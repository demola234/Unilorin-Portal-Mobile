import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../data/remote/authentication/authentication_service.dart';
import '../../../../injection_container.dart';
import '../controller/authentication_provider.dart';

var authService = getIt<AuthenticationService>();
late bool loading;

final authenticationNotifierProvider = StateNotifierProvider.autoDispose<LoginNotifier, LoginState>(
    (ref) => LoginNotifier(ref.read));
