import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:probitas_app/features/assignments/data/model/assignment_response.dart';
import 'package:probitas_app/injection_container.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/toasts.dart';
import '../../../../core/utils/navigation_service.dart';
import '../../../../core/utils/states.dart';
import '../../../../data/remote/assignment/assignment_services.dart';
import '../../../../data/remote/dashboard/dashboard_service.dart';
import '../state/assignment_state.dart';

var assignmentService = getIt<AssignmentService>();

class AssignmentNotifier extends StateNotifier<AssignmentState> {
  AssignmentNotifier(this._read) : super(AssignmentState.initial());
  var assignmentService = getIt<AssignmentService>();
  final Reader _read;

  Future createAssignment(String courseCode, String courseTitle,
      String lecturer, String dueDate, String topic) async {
    state = state.copyWith(viewState: ViewState.loading);
    try {
      await assignmentService.createAssignment(
          courseCode: courseCode,
          courseTitle: courseTitle,
          lecturer: lecturer,
          topic: topic,
          dueDate: dueDate);
      NavigationService().goBack();

      Toasts.showSuccessToast("Assignment Have been uploaded successfully");
    } catch (e) {
      Toasts.showErrorToast(ErrorHelper.getLocalizedMessage(e));
    } finally {
      state = state.copyWith(viewState: ViewState.idle);
    }
  }
}

final getAssignmentProvider = FutureProvider<AssignmentResponse>((ref) async {
  final assignments = await assignmentService.getAssignments();
  return assignments;
});

final getSingleAssignmentProvider =
    FutureProvider.family<AssignmentResponse, String>(
        (ref, assignmentId) async {
  final assignments = await assignmentService.getSingleAssignment(assignmentId);
  return assignments;
});
