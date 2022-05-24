import 'dart:convert';

class NewsResponse {
  NewsResponse({
    this.success,
    this.message,
    this.data,
    this.count,
    this.pagination,
  });

  bool? success;
  String? message;
  List<News>? data;
  int? count;
  Pagination? pagination;

  factory NewsResponse.fromRawJson(String str) =>
      NewsResponse.fromJson(json.decode(str));

  factory NewsResponse.fromJson(Map<String, dynamic> json) => NewsResponse(
        success: json["success"],
        message: json["message"],
        data: List<News>.from(json["data"].map((x) => News.fromJson(x))),
        count: json["count"],
        pagination: Pagination.fromJson(json["pagination"]),
      );
}

class News {
  News({
    this.link,
    this.image,
    this.title,
    this.excerpt,
    this.date,
  });

  String? link;
  String? image;
  String? title;
  String? excerpt;
  DateTime? date;

  factory News.fromRawJson(String str) => News.fromJson(json.decode(str));

  factory News.fromJson(Map<String, dynamic> json) => News(
        link: json["link"],
        image: json["image"],
        title: json["title"],
        excerpt: json["excerpt"],
        date: DateTime.parse(json["date"]),
      );
}

class Pagination {
  Pagination({
    this.current,
    this.limit,
    this.total,
    this.next,
  });

  int? current;
  int? limit;
  int? total;
  Next? next;

  factory Pagination.fromRawJson(String str) =>
      Pagination.fromJson(json.decode(str));

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        current: json["current"],
        limit: json["limit"],
        total: json["total"],
        next: Next.fromJson(json["next"]),
      );
}

class Next {
  Next({
    this.page,
    this.limit,
    this.total,
  });

  int? page;
  int? limit;
  int? total;

  factory Next.fromRawJson(String str) => Next.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Next.fromJson(Map<String, dynamic> json) => Next(
        page: json["page"],
        limit: json["limit"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "limit": limit,
        "total": total,
      };
}
