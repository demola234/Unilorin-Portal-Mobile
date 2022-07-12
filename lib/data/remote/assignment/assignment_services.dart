import 'dart:io';
import 'package:probitas_app/data/local/cache.dart';
import '../../../features/assignments/data/model/assignment_response.dart';
import 'assignment_repository.dart';

abstract class AssignmentService {
  Future<AssignmentResponse> getAssignments();
  Future<AssignmentResponse> getSingleAssignment(String assignmentId);
  Future deleteAssignment(String assignmentId);
  Future createAssignment(
      {String courseCode,
      String courseTitle,
      String lecturer,
      String topic,
      String dueDate});
  Future submitAssignment(String assignmentId, {required File file});
  Future<AssignmentResponse> getSubmittedAssignment();
}

class AssignmentServiceImpl extends AssignmentService {
  AssignmentRepository assignmentRepository;
  Cache cache;

  AssignmentServiceImpl(
      {required this.assignmentRepository, required this.cache});

  @override
  Future createAssignment(
      {String? courseCode,
      String? courseTitle,
      String? lecturer,
      String? topic,
      String? dueDate}) async {
    return assignmentRepository.createAssignment(
      await cache.getToken(),
      courseCode: courseCode!,
      courseTitle: courseTitle!,
      lecturer: lecturer!,
      topic: topic!,
      dueDate: dueDate!,
    );
  }

  @override
  Future deleteAssignment(String assignmentId) async {
    return assignmentRepository.deleteAssignment(
        await cache.getToken(), assignmentId);
  }

  @override
  Future<AssignmentResponse> getAssignments() async {
    return assignmentRepository.getAssignments(await cache.getToken());
  }

  @override
  Future<AssignmentResponse> getSingleAssignment(String assignmentId) async {
    return assignmentRepository.getSingleAssignment(
        await cache.getToken(), assignmentId);
  }

  @override
  Future<AssignmentResponse> getSubmittedAssignment() {
    // TODO: implement getSubmittedAssignment
    throw UnimplementedError();
  }

  @override
  Future submitAssignment(String assignmentId, {required File file}) async {
    return assignmentRepository.submitAssignment(
      await cache.getToken(),
      assignmentId,
      file: file,
    );
  }
}
