import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controller/dashboard_controller.dart';

final dashboardNotifierProvider =
    StateNotifierProvider.autoDispose<DashBoardNotifier, DashBoardState>(
        (ref) => DashBoardNotifier(ref.read));
