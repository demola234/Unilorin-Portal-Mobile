import 'package:probitas_app/data/remote/news/news_repository.dart';
import 'package:probitas_app/features/news/data/model/news_response.dart';

import '../../local/cache.dart';

abstract class NewsService {
  Future<NewsResponse> fetchUsers(String source, String page);
}

class NewsServiceImpl extends NewsService {
  NewsRepository newsRepository;
  Cache cache;
  NewsServiceImpl({required this.newsRepository, required this.cache});

  @override
  Future<NewsResponse> fetchUsers(String source, String page) async {
    return newsRepository.fetchNews(await cache.getToken(), source, page);
  }
}
