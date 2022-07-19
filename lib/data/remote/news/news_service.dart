import 'package:probitas_app/data/remote/news/news_repository.dart';
import 'package:probitas_app/features/news/data/model/news_response.dart';

import '../../local/cache.dart';

abstract class NewsService {
  Future<List<News>> fetchNews(String source, int page);
}

class NewsServiceImpl extends NewsService {
  NewsRepository newsRepository;
  Cache cache;
  NewsServiceImpl({required this.newsRepository, required this.cache});

  @override
  Future<List<News>> fetchNews(String source, int page) async {
    return newsRepository.fetchNews(await cache.getToken(), source, page);
  }
}
