import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:probitas_app/features/authentication/data/model/user_request.dart';

import '../../../../data/remote/dashboard/dashboard_service.dart';
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

final getUsers = FutureProvider<UserResponses>((ref) async {
  final profile = await dashboardService.fetchUsers();
  print(profile.data!.user!.fullName);
  return profile;
});
