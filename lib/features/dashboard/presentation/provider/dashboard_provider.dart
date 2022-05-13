import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:probitas_app/data/remote/dashboard/dashboard_service.dart';
import 'package:probitas_app/features/dashboard/presentation/controller/dashboard_controller.dart';
import '../../../../injection_container.dart';

var dashboardService = getIt<DashBoardService>();
dynamic state;

// final dashboardNotifierProvider =
//     StateNotifierProvider((ref) => DashBoardNotifier(state));
