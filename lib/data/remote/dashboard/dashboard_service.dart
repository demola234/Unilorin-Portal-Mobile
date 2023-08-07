import 'package:probitas_app/data/remote/dashboard/dashboard_repository.dart';
import 'package:probitas_app/features/dashboard/data/model/schedules_response.dart';
import 'package:probitas_app/features/dashboard/data/model/user_summary_response.dart';
import '../../../features/dashboard/data/model/user_response.dart';
import '../../local/cache.dart';

abstract class DashBoardService {
  Future<UserSummaryResponse> fetchUserSummary();
  Future<UserResponse> fetchUser();
  Future uploadSchedule(
      {String? courseCode,
      String? courseTitle,
      String? venue,
      String? weekdays,
      String? startTime,
      String? endTime,
      String? note});
  Future<SchedulesResponse> fetchSchedules();
  Future deleteSchedules(String scheduleId);
}

class DashBoardServiceImpl extends DashBoardService {
  DashboardRepository dashboardRepository;
  Cache cache;

  DashBoardServiceImpl(
      {required this.dashboardRepository, required this.cache});

  @override
  Future<UserSummaryResponse> fetchUserSummary() async {
    return dashboardRepository.fetchUserSummary(await cache.getToken());
  }

  @override
  Future<UserResponse> fetchUser() async {
    return dashboardRepository.fetchUser(await cache.getToken());
  }

  @override
  Future uploadSchedule(
      {String? courseCode,
      String? courseTitle,
      String? venue,
      String? weekdays,
      String? startTime,
      String? endTime,
      String? note}) async {
    return dashboardRepository.uploadSchedule(
      await cache.getToken(),
      courseCode: courseCode,
      courseTitle: courseTitle,
      venue: venue,
      startTime: startTime,
      endTime: endTime,
      note: note,
      weekdays: weekdays,
    );
  }

  @override
  Future<SchedulesResponse> fetchSchedules() async {
    return dashboardRepository.fetchSchedules(await cache.getToken());
  }

  @override
  Future deleteSchedules(String scheduleId) async {
    return dashboardRepository.deleteSchedules(
        await cache.getToken(), scheduleId);
  }
}
