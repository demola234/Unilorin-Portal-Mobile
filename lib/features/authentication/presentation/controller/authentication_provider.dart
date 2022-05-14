import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:probitas_app/data/local/cache.dart';
import 'package:probitas_app/features/authentication/data/model/user_request.dart';
import 'package:probitas_app/features/bottom_navigation.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/toasts.dart';
import '../../../../core/utils/navigation_service.dart';
import '../../../../data/remote/authentication/authentication_service.dart';
import '../../../../injection_container.dart';

class LoginNotifier extends StateNotifier {
  var authService = getIt<AuthenticationService>();
  var cache = getIt<Cache>();
  bool? loading;
  LoginNotifier(this.authService, loading) : super(loading);

  Future<void> login(String matricNumber, String password) async {
    loading = true;
    try {
      await authService.login(matricNumber, password);
      NavigationService().replaceScreen(NavController());
      loading = false;
      print(loading);
    } catch (e) {
      loading = false;
      Toasts.showErrorToast(ErrorHelper.getLocalizedMessage(e));
    }
  }

  Future<UserRequest> getUserFromCache() async {
    var usr = await cache.getUser();
    return usr;
  }
}
