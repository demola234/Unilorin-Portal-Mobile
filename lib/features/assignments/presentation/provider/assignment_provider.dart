import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:probitas_app/features/assignments/presentation/controller/assignment_controller.dart';
import '../state/assignment_state.dart';

final assignmentNotifierProvider =
    StateNotifierProvider.autoDispose<AssignmentNotifier, AssignmentState>(
        (ref) => AssignmentNotifier(ref.read));
