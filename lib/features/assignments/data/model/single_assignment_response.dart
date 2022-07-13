
import 'package:meta/meta.dart';
import 'dart:convert';

class SingleAssignmentResponse {
    SingleAssignmentResponse({
        required this.success,
        required this.message,
        required this.data,
    });

    final bool success;
    final String message;
    final Data data;

    factory SingleAssignmentResponse.fromRawJson(String str) => SingleAssignmentResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory SingleAssignmentResponse.fromJson(Map<String, dynamic> json) => SingleAssignmentResponse(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
    };
}

class Data {
    Data({
        required this.assignment,
    });

    final Assignment assignment;

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        assignment: Assignment.fromJson(json["assignment"]),
    );

    Map<String, dynamic> toJson() => {
        "assignment": assignment.toJson(),
    };
}

class Assignment {
    Assignment({
        required this.id,
        required this.user,
        required this.courseCode,
        required this.courseTitle,
        required this.lecturer,
        required this.level,
        required this.department,
        required this.dueDate,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    final String id;
    final User user;
    final String courseCode;
    final String courseTitle;
    final String lecturer;
    final String level;
    final String department;
    final DateTime dueDate;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int v;

    factory Assignment.fromRawJson(String str) => Assignment.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Assignment.fromJson(Map<String, dynamic> json) => Assignment(
        id: json["_id"],
        user: User.fromJson(json["user"]),
        courseCode: json["courseCode"],
        courseTitle: json["courseTitle"],
        lecturer: json["lecturer"],
        level: json["level"],
        department: json["department"],
        dueDate: DateTime.parse(json["dueDate"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user.toJson(),
        "courseCode": courseCode,
        "courseTitle": courseTitle,
        "lecturer": lecturer,
        "level": level,
        "department": department,
        "dueDate": dueDate.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}

class User {
    User({
        required this.id,
        required this.fullName,
        required this.avatar,
        required this.faculty,
        required this.department,
        required this.level,
    });

    final String id;
    final String fullName;
    final String avatar;
    final String faculty;
    final String department;
    final String level;

    factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        fullName: json["fullName"],
        avatar: json["avatar"],
        faculty: json["faculty"],
        department: json["department"],
        level: json["level"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "fullName": fullName,
        "avatar": avatar,
        "faculty": faculty,
        "department": department,
        "level": level,
    };
}
