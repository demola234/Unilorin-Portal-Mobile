import 'dart:convert';

class PostResponse {
  PostResponse({
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

  factory PostResponse.fromRawJson(String str) =>
      PostResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PostResponse.fromJson(Map<String, dynamic> json) => PostResponse(
        success: json["success"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        count: json["count"],
        pagination: Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "count": count,
        "pagination": pagination!.toJson(),
      };
}

class Datum {
  Datum({
    required this.images,
    this.comments,
    this.likes,
    this.id,
    this.user,
    this.text,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  List<String> images;
  List<String>? comments;
  List<String>? likes;
  String? id;
  User? user;
  String? text;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        images: List<String>.from(json["images"].map((x) => x)),
        comments: List<String>.from(json["comments"].map((x) => x)),
        likes: List<String>.from(json["likes"].map((x) => x)),
        id: json["_id"],
        user: User.fromJson(json["user"]),
        text: json["text"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "images": List<dynamic>.from(images.map((x) => x)),
        "comments": List<dynamic>.from(comments!.map((x) => x)),
        "likes": List<dynamic>.from(likes!.map((x) => x)),
        "_id": id,
        "user": user!.toJson(),
        "text": text,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
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
    this.current,
    this.limit,
    this.total,
  });

  int? current;
  int? limit;
  int? total;

  factory Pagination.fromRawJson(String str) =>
      Pagination.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

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
