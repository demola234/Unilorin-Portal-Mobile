import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../data/remote/authentication/authentication_service.dart';
import '../../../../injection_container.dart';
import '../controller/authentication_provider.dart';

var authService = getIt<AuthenticationService>();

final authenticationNotifierProvider =
    StateNotifierProvider((ref) => LoginNotifier(authService));
