import 'package:probitas_app/data/remote/result/result_repository.dart';
import 'package:probitas_app/features/result/data/model/cgpa_response.dart';

import '../../local/cache.dart';

abstract class ResultService {
  Future<CgpaResponse> fetchCGPA(String level);
}

class ResultServiceImpl extends ResultService {
  ResultRepository resultRepository;
  Cache cache;
  ResultServiceImpl({required this.resultRepository, required this.cache});

  @override
  Future<CgpaResponse> fetchCGPA(String level) async {
    return resultRepository.fetchCgpa(await cache.getToken(), level);
  }
}
