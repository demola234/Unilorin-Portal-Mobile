import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:probitas_app/data/remote/dashboard/dashboard_service.dart';
import 'package:probitas_app/features/dashboard/data/model/schedules_response.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/toasts.dart';
import '../../../../core/utils/navigation_service.dart';
import '../../../../data/local/cache.dart';
import '../../../../injection_container.dart';
import '../../data/model/user_response.dart';
import '../../../../core/utils/states.dart';
import '../provider/dashboard_provider.dart';

// class DashBoardNotifier extends StateNotifier {
//   DashBoardNotifier(state) : super(state);
//   var dashboardService = getIt<DashBoardService>();

//   Future getUsers() async {
// final profile = await dashboardService.fetchUsers();
// return profile;
//   }
// }
var dashboardService = getIt<DashBoardService>();

final getUsersProvider = FutureProvider.autoDispose<UserResponses>((ref) async {
  final profile = await dashboardService.fetchUsers();
  // print(profile.data!.user.fullName);
  return profile;
});

class DashBoardNotifier extends StateNotifier<DashBoardState> {
  DashBoardNotifier(this._read) : super(DashBoardState.initial());
  var dashBoardService = getIt<DashBoardService>();
  var cache = getIt<Cache>();
  final Reader _read;

  Future createSchedule(
      String? courseCode,
      String? courseTitle,
      String? venue,
      String? weekdays,
      String? startTime,
      String? endTime,
      String? note) async {
    state = state.copyWith(viewState: ViewState.loading);
    try {
      await dashBoardService.uploadSchedule(
        courseCode: courseCode,
        courseTitle: courseTitle,
        venue: venue,
        endTime: endTime,
        startTime: startTime,
        note: note,
        weekdays: weekdays,
      );
      NavigationService().goBack();

      Toasts.showSuccessToast("Schedule Have been uploaded successfully");
    } catch (e) {
      Toasts.showErrorToast(ErrorHelper.getLocalizedMessage(e));
    } finally {
      state = state.copyWith(viewState: ViewState.idle);
    }
  }
}

final getSchedulesProvider =
    FutureProvider.autoDispose<SchedulesResponse>((ref) async {
  final profile = await dashboardService.fetchSchedules();
  print(profile.data!.schedules);
  return profile;
});

final deleteSchedulesProvider =
    FutureProvider.family.autoDispose((ref, String scheduleId) async {
  final delete = await dashboardService.deleteSchedules(scheduleId);
  return delete;
});

class DashBoardState {
  final ViewState viewState;

  const DashBoardState._({required this.viewState});

  factory DashBoardState.initial() => const DashBoardState._(
        viewState: ViewState.idle,
      );

  DashBoardState copyWith({ViewState? viewState, bool? passwordVisible}) =>
      DashBoardState._(
        viewState: viewState ?? this.viewState,
      );
}
