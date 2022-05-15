import 'dart:convert';

class CreatePost {
  CreatePost({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  Data? data;

  factory CreatePost.fromRawJson(String str) =>
      CreatePost.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CreatePost.fromJson(Map<String, dynamic> json) => CreatePost(
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

  List<String>? images;
  List<dynamic>? comments;
  List<dynamic>? likes;
  String? id;
  String? user;
  String? text;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  factory Post.fromRawJson(String str) => Post.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        images: List<String>.from(json["images"].map((x) => x)),
        comments: List<dynamic>.from(json["comments"].map((x) => x)),
        likes: List<dynamic>.from(json["likes"].map((x) => x)),
        id: json["_id"],
        user: json["user"],
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
        "user": user,
        "text": text,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
      };
}
