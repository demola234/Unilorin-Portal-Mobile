import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:probitas_app/data/local/cache.dart';
import 'package:probitas_app/features/authentication/data/model/user_request.dart';
import 'package:probitas_app/features/bottom_navigation.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/toasts.dart';
import '../../../../core/utils/navigation_service.dart';
import '../../../../data/remote/authentication/authentication_service.dart';
import '../../../../injection_container.dart';
import '../../data/infrastructure/authentication_state.dart';

class LoginNotifier extends StateNotifier<AuthenticationState> {
  var authService = getIt<AuthenticationService>();
  var cache = getIt<Cache>();
  LoginNotifier(this.authService) : super(AuthenticationInitial());

  Future<void> login(String matricNumber, String password) async {
    state = AuthenticationLoading(true);
    try {
      final response = await authService.login(matricNumber, password);
      state = AuthenticatingUser(response);
      NavigationService().replaceScreen(NavController());
      state = AuthenticationLoading(false);
    } catch (e) {
      state = AuthenticationError("An Error Occurred");
      bool isLoading = false;
      state = AuthenticationLoading(isLoading);
      Toasts.showErrorToast(ErrorHelper.getLocalizedMessage(e));
    }
  }

  Future<UserRequest> getUserFromCache() async {
    var usr = await cache.getUser();
    return usr;
  }
}
