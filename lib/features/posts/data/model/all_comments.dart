import 'dart:convert';

class SingleCommentResponse {
    SingleCommentResponse({
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

    factory SingleCommentResponse.fromRawJson(String str) => SingleCommentResponse.fromJson(json.decode(str));


    factory SingleCommentResponse.fromJson(Map<String, dynamic> json) => SingleCommentResponse(
        success: json["success"] == null ? null : json["success"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        count: json["count"] == null ? null : json["count"],
        pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
    );

}

class Datum {
    Datum({
        this.id,
        this.post,
        this.user,
        this.text,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    String? id;
    String? post;
    User? user;
    String? text;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));


    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"] == null ? null : json["_id"],
        post: json["post"] == null ? null : json["post"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        text: json["text"] == null ? null : json["text"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"] == null ? null : json["__v"],
    );

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
