import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:probitas_app/features/authentication/data/infrastructure/authentication_state.dart';
import '../../../../data/remote/authentication/authentication_service.dart';
import '../../../../injection_container.dart';
import '../controller/authentication_provider.dart';

var authService = getIt<AuthenticationService>();
late bool loading;

final authenticationNotifierProvider = StateNotifierProvider(
    (ref) => LoginNotifier(authService, AuthenticationLoading));
