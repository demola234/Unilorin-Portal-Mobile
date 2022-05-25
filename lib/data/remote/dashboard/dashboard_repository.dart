import 'package:probitas_app/features/dashboard/data/model/schedules_response.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/network/base_api.dart';
import '../../../features/dashboard/data/model/user_response.dart';

abstract class DashboardRepository {
  Future<UserResponses> fetchUser(String token);
  Future uploadSchedule(String token,
      {String? courseCode,
      String? courseTitle,
      String? venue,
      String? weekdays,
      String? startTime,
      String? endTime,
      String? note});
  Future<SchedulesResponse> fetchSchedules(String token);
}

class DashboardRepositoryImpl extends BaseApi implements DashboardRepository {
  @override
  Future<UserResponses> fetchUser(String token) async {
      
    try {
      
      var data = await get("auth/me", headers: getHeader(token));
      final s = UserResponses.fromJson(data);
      return s;
    } catch (err) {
      if (err is RequestException) {
        throw CustomException(err.message);
      }
      throw CustomException("Something went wrong");
    }
  }

  @override
  Future uploadSchedule(String token,
      {String? courseCode,
      String? courseTitle,
      String? venue,
      String? weekdays,
      String? startTime,
      String? endTime,
      String? note}) async {
    try {
      var data = await post("schedules", headers: getHeader(token), data: {
        "courseCode": courseCode,
        "courseTitle": courseTitle,
        "venue": venue,
        "weekdays": [weekdays],
        "startTime": startTime,
        "endTime": endTime,
        "note": note,
      });
      return data;
    } catch (err) {
      if (err is RequestException) {
        throw CustomException(err.message);
      }
      throw CustomException("Something went wrong");
    }
  }

  @override
  Future<SchedulesResponse> fetchSchedules(String token) async {
    try {
      var data = await get("users/userId/schedule", headers: getHeader(token));
      final s = SchedulesResponse.fromJson(data);
      return s;
    } catch (err) {
      if (err is RequestException) {
        throw CustomException(err.message);
      }
      throw CustomException("Something went wrong");
    }
  }
}
