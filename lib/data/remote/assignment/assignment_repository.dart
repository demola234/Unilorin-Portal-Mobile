import 'dart:io';
import 'package:dio/dio.dart';
import '../../../core/error/exceptions.dart';
import '../../../core/network/base_api.dart';
import '../../../features/assignments/data/model/assignment_response.dart';
import '../../../features/resources/data/model/resource_response.dart';

abstract class AssignmentRepository {
  Future<Assignment> getAssignments(String token);
  Future<Assignment> getSingleAssignments(String token, String assignmentId);
  Future<Assignment> deleteAssignment(String token, String assignmentId);
  Future createAssignment(String token, String courseCode,
      String courseTitle, String lecturer, String dueDate, String topic);
  Future<Assignment> submitAssignment(String token);
  Future<Assignment> getSubmittedAssignment(String token);
}

class AssignmentRepositoryRepositoryImpl extends BaseApi
    implements AssignmentRepository {
  @override
  Future createAssignment(String token, String courseCode,
      String courseTitle, String lecturer, String dueDate, String topic) async {
     try {
      var data = await post("assignments", headers: getHeader(token), data: {
        "courseCode": courseCode,
        "courseTitle": courseTitle,
        "lecturer": lecturer,
        "dueDate": dueDate,
        "topic": topic,
      });
      return data;
    } catch (err) {
      if (err is RequestException) {
        throw CustomException(err.message);
      }
      throw CustomException("Something went wrong");
    }
  }

  @override
  Future<Assignment> deleteAssignment(String token, String assignmentId) {
    // TODO: implement deleteAssignment
    throw UnimplementedError();
  }

  @override
  Future<Assignment> getAssignments(String token) {
    // TODO: implement getAssignments
    throw UnimplementedError();
  }

  @override
  Future<Assignment> getSingleAssignments(String token, String assignmentId) {
    // TODO: implement getSingleAssignments
    throw UnimplementedError();
  }

  @override
  Future<Assignment> getSubmittedAssignment(String token) {
    // TODO: implement getSubmittedAssignment
    throw UnimplementedError();
  }

  @override
  Future<Assignment> submitAssignment(String token) {
    // TODO: implement submitAssignment
    throw UnimplementedError();
  }
}
