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

    factory SinglePostResponse.fromRawJson(String str) => SinglePostResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory SinglePostResponse.fromJson(Map<String, dynamic> json) => SinglePostResponse(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data!.toJson(),
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
        post: Post.fromJson(json["post"]),
    );

    Map<String, dynamic> toJson() => {
        "post": post!.toJson(),
    };
}

class Post {
    Post({
        this.images,
        this.comments,
        this.likes,
        this.id,
        this.user,
        this.text,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    List<dynamic>? images;
    List<dynamic>? comments;
    List<String>? likes;
    String? id;
    User? user;
    String? text;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    factory Post.fromRawJson(String str) => Post.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Post.fromJson(Map<String, dynamic> json) => Post(
        images: List<dynamic>.from(json["images"].map((x) => x)),
        comments: List<dynamic>.from(json["comments"].map((x) => x)),
        likes: List<String>.from(json["likes"].map((x) => x)),
        id: json["_id"],
        user: User.fromJson(json["user"]),
        text: json["text"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "images": List<dynamic>.from(images!.map((x) => x)),
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
