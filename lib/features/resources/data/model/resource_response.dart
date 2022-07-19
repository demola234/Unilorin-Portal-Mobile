// To parse this JSON data, do
//
//     final singlePostResponse = singlePostResponseFromJson(jsonString);

import 'dart:convert';

class ResourceResponse {
    ResourceResponse({
        this.success,
        this.message,
        this.data,
        this.count,
        this.pagination,
    });

    bool? success;
    String? message;
    List<Datum>? data;
    int? count;
    Pagination? pagination;

    factory ResourceResponse.fromRawJson(String str) => ResourceResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ResourceResponse.fromJson(Map<String, dynamic> json) => ResourceResponse(
        success: json["success"] == null ? null : json["success"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        count: json["count"] == null ? null : json["count"],
        pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "message": message == null ? null : message,
        "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
        "count": count == null ? null : count,
        "pagination": pagination == null ? null : pagination!.toJson(),
    };
}

class Datum {
    Datum({
        this.id,
        this.user,
        this.file,
        this.courseCode,
        this.courseTitle,
        this.topic,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    String? id;
    User? user;
    String? file;
    String? courseCode;
    String? courseTitle;
    String? topic;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"] == null ? null : json["_id"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        file: json["file"] == null ? null : json["file"],
        courseCode: json["courseCode"] == null ? null : json["courseCode"],
        courseTitle: json["courseTitle"] == null ? null : json["courseTitle"],
        topic: json["topic"] == null ? null : json["topic"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"] == null ? null : json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "user": user == null ? null : user!.toJson(),
        "file": file == null ? null : file,
        "courseCode": courseCode == null ? null : courseCode,
        "courseTitle": courseTitle == null ? null : courseTitle,
        "topic": topic == null ? null : topic,
        "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "__v": v == null ? null : v,
    };
}

class User {
    User({
        this.id,
        this.fullName,
        this.avatar,
        this.faculty,
        this.department,
        this.level,
    });

    String? id;
    String? fullName;
    String? avatar;
    String? faculty;
    String? department;
    String? level;

    factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"] == null ? null : json["_id"],
        fullName: json["fullName"] == null ? null : json["fullName"],
        avatar: json["avatar"] == null ? null : json["avatar"],
        faculty: json["faculty"] == null ? null : json["faculty"],
        department: json["department"] == null ? null : json["department"],
        level: json["level"] == null ? null : json["level"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "fullName": fullName == null ? null : fullName,
        "avatar": avatar == null ? null : avatar,
        "faculty": faculty == null ? null : faculty,
        "department": department == null ? null : department,
        "level": level == null ? null : level,
    };
}

class Pagination {
    Pagination({
        this.current,
        this.limit,
        this.total,
    });

    int? current;
    int? limit;
    int? total;

    factory Pagination.fromRawJson(String str) => Pagination.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        current: json["current"] == null ? null : json["current"],
        limit: json["limit"] == null ? null : json["limit"],
        total: json["total"] == null ? null : json["total"],
    );

    Map<String, dynamic> toJson() => {
        "current": current == null ? null : current,
        "limit": limit == null ? null : limit,
        "total": total == null ? null : total,
    };
}
