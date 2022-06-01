import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:probitas_app/data/remote/dashboard/dashboard_service.dart';
import '../../../../injection_container.dart';
import '../controller/dashboard_controller.dart';

final dashboardNotifierProvider =
    StateNotifierProvider.autoDispose<DashBoardNotifier, DashBoardState>(
        (ref) => DashBoardNotifier(ref.read));
