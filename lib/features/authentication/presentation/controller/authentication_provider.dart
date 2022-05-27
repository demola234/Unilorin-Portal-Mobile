import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:probitas_app/data/local/cache.dart';
import 'package:probitas_app/features/authentication/data/model/user_request.dart';
import 'package:probitas_app/features/bottom_navigation.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/toasts.dart';
import '../../../../core/utils/navigation_service.dart';
import '../../../../core/utils/states.dart';
import '../../../../data/remote/authentication/authentication_service.dart';
import '../../../../injection_container.dart';

class LoginNotifier extends StateNotifier<LoginState> {
  var authService = getIt<AuthenticationService>();
  var cache = getIt<Cache>();
  LoginNotifier(this._read) : super(LoginState.initial());

  final Reader _read;

  Future<void> login(String matricNumber, String password) async {
    state = state.copyWith(viewState: ViewState.loading);
    try {
      await authService.login(matricNumber, password);
      NavigationService().replaceScreen(NavController());
    } catch (e) {
      Toasts.showErrorToast(ErrorHelper.getLocalizedMessage(e));
    } finally {
      state = state.copyWith(viewState: ViewState.idle);
    }
  }

  Future<UserRequest> getUserFromCache() async {
    var usr = await cache.getUser();
    return usr;
  }
}

class LoginState {
  final ViewState viewState;
  final bool passwordVisible;

  const LoginState._({required this.viewState, required this.passwordVisible});

  factory LoginState.initial() => const LoginState._(
        viewState: ViewState.idle,
        passwordVisible: false,
      );

  LoginState copyWith({ViewState? viewState, bool? passwordVisible}) =>
      LoginState._(
        viewState: viewState ?? this.viewState,
        passwordVisible: passwordVisible ?? this.passwordVisible,
      );
}
