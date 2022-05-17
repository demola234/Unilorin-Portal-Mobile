import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:probitas_app/data/remote/result/result_service.dart';
import 'package:probitas_app/features/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:probitas_app/features/result/data/model/cgpa_response.dart';
import 'package:probitas_app/features/result/presentation/pages/results.dart';
import '../../../../injection_container.dart';

var resultService = getIt<ResultService>();

final getResultsProvider = FutureProvider<CgpaResponse>((ref) async {
  final cgpaResult = await resultService
      .fetchCGPA(ref.read(getUsersProvider).asData!.value.data!.user!.level!);

  return cgpaResult;
});
