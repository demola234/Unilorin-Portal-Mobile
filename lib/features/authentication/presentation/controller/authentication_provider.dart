import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:probitas_app/features/bottom_navigation.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/toasts.dart';
import '../../../../core/utils/navigation_service.dart';
import '../../../../data/remote/authentication/authentication_service.dart';
import '../../../../injection_container.dart';
import '../../data/infrastructure/authentication_state.dart';

class LoginNotifier extends StateNotifier<AuthenticationState> {
  var authService = getIt<AuthenticationService>();

  LoginNotifier(this.authService) : super(AuthenticationInitial());

  Future<void> login(String matricNumber, String password) async {
    bool isLoading = true;
    state = AuthenticationLoading(isLoading);
    try {
      final response = await authService.login(matricNumber, password);
      state = AuthenticatingUser(response);
      NavigationService().replaceScreen(NavController());
      bool isLoading = false;
      state = AuthenticationLoading(isLoading);
    } catch (e) {
      state = AuthenticationError("An Error Occured");
      bool isLoading = false;
      state = AuthenticationLoading(isLoading);
      Toasts.showErrorToast(ErrorHelper.getLocalizedMessage(e));
    }
  }
}
