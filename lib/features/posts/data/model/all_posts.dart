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
    List<PostList>? data;
    int? count;
    Pagination? pagination;

    factory PostResponse.fromRawJson(String str) => PostResponse.fromJson(json.decode(str));


    factory PostResponse.fromJson(Map<String, dynamic> json) => PostResponse(
        success: json["success"] == null ? null : json["success"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : List<PostList>.from(json["data"].map((x) => PostList.fromJson(x))),
        count: json["count"] == null ? null : json["count"],
        pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
    );

}

class PostList {
    PostList({
        this.id,
        this.user,
        this.text,
        this.images,
        this.createdAt,
        this.commentCount,
        this.likeCount,
        this.isUserLiked,
    });

    String? id;
    User? user;
    String? text;
    List<String>? images;
    DateTime? createdAt;
    int? commentCount;
    int? likeCount;
    bool? isUserLiked;

    factory PostList.fromRawJson(String str) => PostList.fromJson(json.decode(str));


    factory PostList.fromJson(Map<String, dynamic> json) => PostList(
        id: json["_id"] == null ? null : json["_id"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        text: json["text"] == null ? null : json["text"],
        images: json["images"] == null ? null : List<String>.from(json["images"].map((x) => x)),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        commentCount: json["commentCount"] == null ? null : json["commentCount"],
        likeCount: json["likeCount"] == null ? null : json["likeCount"],
        isUserLiked: json["isUserLiked"] == null ? null : json["isUserLiked"],
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

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"] == null ? null : json["_id"],
        fullName: json["fullName"] == null ? null : json["fullName"],
        avatar: json["avatar"] == null ? null : json["avatar"],
        faculty: json["faculty"] == null ? null : json["faculty"],
        department: json["department"] == null ? null : json["department"],
        level: json["level"] == null ? null : json["level"],
    );

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

class EnumValues<T> {
    Map<String, T>? map;
    Map<T, String>? reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map!.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap!;
    }
}
