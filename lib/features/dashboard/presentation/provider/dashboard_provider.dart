import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:probitas_app/data/remote/dashboard/dashboard_service.dart';
import 'package:probitas_app/features/authentication/data/infrastructure/authentication_state.dart';
import '../../../../injection_container.dart';
import '../controller/dashboard_controller.dart';

var dashboardService = getIt<DashBoardService>();
bool state = false;


final dashboardNotifierProvider =
    StateNotifierProvider((ref) => DashBoardNotifier(dashboardService, state));
