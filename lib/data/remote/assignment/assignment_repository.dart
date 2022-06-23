import 'dart:io';
import 'package:dio/dio.dart';
import '../../../core/error/exceptions.dart';
import '../../../core/network/base_api.dart';
import '../../../features/assignments/data/model/assignment_response.dart';
import '../../../features/resources/data/model/resource_response.dart';

abstract class AssignmentRepository {
  Future<AssignmentResponse> getAssignment(String token);
  Future<AssignmentResponse> getSingleAssignment(
      String token, String assignmentId);
  Future deleteAssignment(String token, String assignmentId);
  Future createAssignment(String token,
      {String courseCode,
      String courseTitle,
      String lecturer,
      String dueDate,
      String topic});
  Future submitAssignment(String token, String assignmentId,
      {required File file});
  Future<AssignmentResponse> getSubmittedAssignment(String token);
}

class AssignmentRepositoryImpl extends BaseApi implements AssignmentRepository {
  @override
  Future createAssignment(String token,
      {String? courseCode,
      String? courseTitle,
      String? lecturer,
      String? dueDate,
      String? topic}) async {
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
  Future deleteAssignment(String token, String assignmentId) async {
    try {
      var data =
          await delete("assignment/$assignmentId", headers: getHeader(token));
      final s = AssignmentResponse.fromJson(data);
      return s;
    } catch (err) {
      if (err is RequestException) {
        throw CustomException(err.message);
      }
      throw CustomException("Something went wrong");
    }
  }

  @override
  Future<AssignmentResponse> getAssignment(String token) async {
    try {
      var data = await get("assignments", headers: getHeader(token));
      final s = AssignmentResponse.fromJson(data);
      return s;
    } catch (err) {
      if (err is RequestException) {
        throw CustomException(err.message);
      }
      throw CustomException("Something went wrong");
    }
  }

  @override
  Future<AssignmentResponse> getSingleAssignment(
      String token, String assignmentId) async {
    try {
      var data =
          await get("assignments/$assignmentId", headers: getHeader(token));
      final s = AssignmentResponse.fromJson(data);
      return s;
    } catch (err) {
      if (err is RequestException) {
        throw CustomException(err.message);
      }
      throw CustomException("Something went wrong");
    }
  }

  @override
  Future<AssignmentResponse> getSubmittedAssignment(String token) {
    // TODO: implement getSubmittedAssignmentResponse
    throw UnimplementedError();
  }

  @override
  Future submitAssignment(String token, String assignmentId,
      {required File file}) async {
    try {
      var data = <String, dynamic>{};
      data["file"] = await MultipartFile.fromFile(file.path,
          filename:
              "assignment${file.path.split(".").last}.${file.path.split(".").last}");

      final v = await post("assignments/$assignmentId/submit",
          headers: getHeader(token), formData: FormData.fromMap(data));
      print(v);
    } catch (err) {
      if (err is RequestException) {
        throw CustomException(err.message);
      }
      print(err);
      throw CustomException("Something went wrong");
    }
  }
}
