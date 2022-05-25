import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:probitas_app/core/error/exceptions.dart';
import 'package:probitas_app/data/remote/news/news_service.dart';
import 'package:probitas_app/features/news/data/model/news_response.dart';
import 'package:probitas_app/injection_container.dart';

import '../../../../core/utils/states.dart';

class NewsNotifier extends StateNotifier<NewsState> {
  NewsNotifier(this._read) : super(NewsState.initial()) {
    getNews();
  }
  final newsService = getIt<NewsService>();
  final Reader _read;

  Future<void> getNews() async {
    try {
      state = state.copyWith(
        viewState: ViewState.loading,
        currentPage: state.currentPage,
      );

      final news = await newsService.fetchNews("unilorinsu", state.currentPage);
      state = state.copyWith(
        news: news,
        currentPage: state.currentPage,
        viewState: ViewState.idle,
      );

      if (state.news!.length < state.pageSize) {
        state = state.copyWith(moreDataAvailable: false);
      }
    } on CustomException {
      state = state.copyWith(viewState: ViewState.error);
    }
  }

  Future<void> getMoreNews() async {
    try {
      final news =
          await newsService.fetchNews("unilorinsu", state.currentPage + 1);

      if (news.isEmpty) {
        state = state.copyWith(moreDataAvailable: false);
      }

      state = state.copyWith(
        news: [...state.news!, ...news],
        viewState: ViewState.idle,
        currentPage: state.currentPage + 1,
      );
    } on CustomException {
      state = state.copyWith(viewState: ViewState.error);
    }
  }
}

class NewsState {
  final ViewState viewState;
  final List<News>? news;
  final int currentPage;
  final bool moreDataAvailable;

  const NewsState._({
    this.news,
    required this.viewState,
    required this.currentPage,
    required this.moreDataAvailable,
  });

  factory NewsState.initial() => const NewsState._(
        currentPage: 1,
        moreDataAvailable: true,
        viewState: ViewState.idle,
      );

  final int pageSize = 17;

  NewsState copyWith({
    List<News>? news,
    int? currentPage,
    bool? moreDataAvailable,
    String? searchQuery,
    ViewState? viewState,
  }) {
    return NewsState._(
      news: news ?? this.news,
      currentPage: currentPage ?? this.currentPage,
      moreDataAvailable: moreDataAvailable ?? this.moreDataAvailable,
      viewState: viewState ?? this.viewState,
    );
  }
}
