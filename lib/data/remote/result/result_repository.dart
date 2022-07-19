import 'package:probitas_app/features/result/data/model/cgpa_response.dart';
import 'package:probitas_app/features/result/data/model/result_response.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/network/base_api.dart';

abstract class ResultRepository {
  Future<CgpaResponse> fetchCgpa(String token, String level);
  Future<ResultResponse> fetchResults(String token, String session);
}

class ResultRepositoryImpl extends BaseApi implements ResultRepository {
  @override
  Future<CgpaResponse> fetchCgpa(String token, String level) async {
    var data = await get("users/results/calculate-cgpa",
        headers: getHeader(token),
        query: {
          "level": level,
        });
    try {
      final s = CgpaResponse.fromJson(data);
      return s;
    } catch (err) {
      if (err is RequestException) {
        throw CustomException(err.message);
      }
      throw CustomException("Something went wrong");
    }
  }

  @override
  Future<ResultResponse> fetchResults(String token, String session) async {
    var data = await get("users/results", headers: getHeader(token), query: {
      "session": session,
    });
    try {
      final s = ResultResponse.fromJson(data);
      return s;
    } catch (err) {
      if (err is RequestException) {
        throw CustomException(err.message);
      }
      throw CustomException("Something went wrong");
    }
  }
}
