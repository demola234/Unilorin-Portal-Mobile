import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:probitas_app/data/remote/dashboard/dashboard_service.dart';
import 'package:probitas_app/features/dashboard/data/model/schedules_response.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/toasts.dart';
import '../../../../core/utils/navigation_service.dart';
import '../../../../data/local/cache.dart';
import '../../../../injection_container.dart';
import '../../data/model/user_response.dart';
import '../provider/dashboard_provider.dart';

// class DashBoardNotifier extends StateNotifier {
//   DashBoardNotifier(state) : super(state);
//   var dashboardService = getIt<DashBoardService>();

//   Future getUsers() async {
// final profile = await dashboardService.fetchUsers();
// return profile;
//   }
// }

final getUsersProvider = FutureProvider<UserResponses>((ref) async {
  final profile = await dashboardService.fetchUsers();
  print(profile.data!.user!.fullName);
  return profile;
});

class DashBoardNotifier extends StateNotifier {
  var dashBoardService = getIt<DashBoardService>();
  var cache = getIt<Cache>();
  bool? loading;
  DashBoardNotifier(this.dashBoardService, loading) : super(loading);

  Future createSchedule(
      String? courseCode,
      String? courseTitle,
      String? venue,
      String? weekdays,
      String? startTime,
      String? endTime,
      String? note) async {
    loading = true;
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

      Toasts.showSuccessToast("Post Have been uploaded successfully");
      print(loading);
    } catch (e) {
      Toasts.showErrorToast(ErrorHelper.getLocalizedMessage(e));
    }
  }
}

final getSchedulesProvider = FutureProvider<SchedulesResponse>((ref) async {
  final profile = await dashboardService.fetchSchedules();
  print(profile.data!.schedules);
  return profile;
});
