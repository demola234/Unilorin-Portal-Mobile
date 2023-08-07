import 'dart:convert';

class SubmittedAssignmentResponse {
    SubmittedAssignmentResponse({
        required this.success,
        required this.message,
        required this.data,
    });

    final bool success;
    final String message;
    final Data data;

    factory SubmittedAssignmentResponse.fromRawJson(String str) => SubmittedAssignmentResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory SubmittedAssignmentResponse.fromJson(Map<String, dynamic> json) => SubmittedAssignmentResponse(
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
        required this.assignments,
    });

    final List<AssignmentElement> assignments;

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        assignments: List<AssignmentElement>.from(json["assignments"].map((x) => AssignmentElement.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "assignments": List<dynamic>.from(assignments.map((x) => x.toJson())),
    };
}

class AssignmentElement {
    AssignmentElement({
        required this.user,
        required this.id,
        required this.assignment,
        required this.file,
        required this.createdAt,
    });

    final User user;
    final String id;
    final AssignmentAssignment assignment;
    final String file;
    final DateTime createdAt;

    factory AssignmentElement.fromRawJson(String str) => AssignmentElement.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory AssignmentElement.fromJson(Map<String, dynamic> json) => AssignmentElement(
        user: User.fromJson(json["user"]),
        id: json["_id"],
        assignment: AssignmentAssignment.fromJson(json["assignment"]),
        file: json["file"],
        createdAt: DateTime.parse(json["createdAt"]),
    );

    Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "_id": id,
        "assignment": assignment.toJson(),
        "file": file,
        "createdAt": createdAt.toIso8601String(),
    };
}

class AssignmentAssignment {
    AssignmentAssignment({
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
    final String user;
    final String courseCode;
    final String courseTitle;
    final String lecturer;
    final String level;
    final String department;
    final DateTime dueDate;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int v;

    factory AssignmentAssignment.fromRawJson(String str) => AssignmentAssignment.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory AssignmentAssignment.fromJson(Map<String, dynamic> json) => AssignmentAssignment(
        id: json["_id"],
        user: json["user"],
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
        "user": user,
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
        required this.fullName,
        required this.avatar,
        required this.faculty,
        required this.department,
        required this.level,
    });

    final String fullName;
    final String avatar;
    final String faculty;
    final String department;
    final String level;

    factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory User.fromJson(Map<String, dynamic> json) => User(
        fullName: json["fullName"],
        avatar: json["avatar"],
        faculty: json["faculty"],
        department: json["department"],
        level: json["level"],
    );

    Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "avatar": avatar,
        "faculty": faculty,
        "department": department,
        "level": level,
    };
}
