class AssignmentResponse {
    AssignmentResponse({
        required this.success,
        required this.message,
        required this.data,
        required this.count,
        required this.pagination,
    });

    final bool success;
    final String message;
    final List<Datum> data;
    final int count;
    final Pagination pagination;

    factory AssignmentResponse.fromJson(Map<String, dynamic> json) => AssignmentResponse(
        success: json["success"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        count: json["count"],
        pagination: Pagination.fromJson(json["pagination"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "count": count,
        "pagination": pagination.toJson(),
    };
}

class Datum {
    Datum({
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


    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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

class Pagination {
    Pagination({
        required this.current,
        required this.limit,
        required this.total,
    });

    final int current;
    final int limit;
    final int total;

    factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        current: json["current"],
        limit: json["limit"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "current": current,
        "limit": limit,
        "total": total,
    };
}
