abstract class AssignmentService {
  Future<AssignmentService> getAssignments(String token);
  Future<AssignmentService> getSingleAssignments(
      String token, String assignmentId);
  Future<AssignmentService> deleteAssignment(String token, String assignmentId);
  Future<AssignmentService> createAssignment(
    String token,
    String courseCode,
    String courseTitle,
    String lecturer,
    String dueDate,
  );
  Future<AssignmentService> submitAssignment(String token);
  Future<AssignmentService> getSubmittedAssignment(String token);
}
