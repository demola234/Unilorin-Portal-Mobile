import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:probitas_app/core/error/exceptions.dart';
import 'package:probitas_app/data/remote/news/news_service.dart';
import 'package:probitas_app/features/news/data/model/news_pagination.dart';
import 'package:probitas_app/features/news/data/model/news_response.dart';
import 'package:probitas_app/injection_container.dart';

class NewsPaginationController extends StateNotifier<NewsPagination> {
  final newsService = getIt<NewsService>();
  NewsPaginationController(newsService, [NewsPagination? state])
      : super(
          state ?? NewsPagination.initial(),
        ) {
    getNews();
  }

  Future<void> getNews() async {
    try {
      final news = await newsService.fetchUsers("unilorinsu", state.pages);
      state = state
          .copyWith(news: [...state.news, ...news], pages: state.pages + 1);
    } on CustomException catch (e) {
      state = state.copyWith(error: e.message);
    }
  }

  void handleScrollWithIndex(int index) {
    final itemPosition = index + 1;
    final requestMoreData = itemPosition % 18 == 0 && itemPosition != 0;

    final pageToRequest = itemPosition ~/ 18;

    if (requestMoreData && pageToRequest + 1 >= state.pages) {
      getNews();
    }
  }
}
