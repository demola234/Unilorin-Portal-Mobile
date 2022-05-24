// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:probitas_app/features/news/data/model/news_response.dart';

class NewsPagination {
  final List<News> news;
  final int pages;
  final String error;
  NewsPagination({
    required this.news,
    required this.pages,
    required this.error,
  });

  NewsPagination.initial()
      : news = [],
        pages = 1,
        error = '';

  bool get refreshError => error != "" && news.length <= 18;

  NewsPagination copyWith({
    List<News>? news,
    int? pages,
    String? error,
  }) {
    return NewsPagination(
      news: news ?? this.news,
      pages: pages ?? this.pages,
      error: error ?? this.error,
    );
  }

  @override
  String toString() =>
      'NewsPagination(news: $news, pages: $pages, error: $error)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NewsPagination &&
        listEquals(other.news, news) &&
        other.pages == pages &&
        other.error == error;
  }

  @override
  int get hashCode => news.hashCode ^ pages.hashCode ^ error.hashCode;
}
