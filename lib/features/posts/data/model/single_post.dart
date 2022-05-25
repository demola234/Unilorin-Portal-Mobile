// To parse this JSON data, do
//
//     final singlePostResponse = singlePostResponseFromJson(jsonString);

import 'dart:convert';

class SinglePostResponse {
  SinglePostResponse({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  Data? data;

  factory SinglePostResponse.fromRawJson(String str) =>
      SinglePostResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SinglePostResponse.fromJson(Map<String, dynamic> json) =>
      SinglePostResponse(
        success: json["success"] == null ? null : json["success"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "message": message == null ? null : message,
        "data": data == null ? null : data!.toJson(),
      };
}

class Data {
  Data({
    this.post,
  });

  Post? post;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        post: json["post"] == null ? null : Post.fromJson(json["post"]),
      );

  Map<String, dynamic> toJson() => {
        "post": post == null ? null : post!.toJson(),
      };
}

class Post {
  Post({
    this.id,
    this.images,
    this.user,
    this.text,
    this.createdAt,
    this.commentCount,
    this.likeCount,
    this.isUserLiked,
  });

  String? id;
  List<dynamic>? images;
  User? user;
  String? text;
  DateTime? createdAt;
  int? commentCount;
  int? likeCount;
  bool? isUserLiked;

  factory Post.fromRawJson(String str) => Post.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["_id"] == null ? null : json["_id"],
        images: json["images"] == null
            ? null
            : List<dynamic>.from(json["images"].map((x) => x)),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        text: json["text"] == null ? null : json["text"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        commentCount:
            json["commentCount"] == null ? null : json["commentCount"],
        likeCount: json["likeCount"] == null ? null : json["likeCount"],
        isUserLiked: json["isUserLiked"] == null ? null : json["isUserLiked"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "images":
            images == null ? null : List<dynamic>.from(images!.map((x) => x)),
        "user": user == null ? null : user!.toJson(),
        "text": text == null ? null : text,
        "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
        "commentCount": commentCount == null ? null : commentCount,
        "likeCount": likeCount == null ? null : likeCount,
        "isUserLiked": isUserLiked == null ? null : isUserLiked,
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
