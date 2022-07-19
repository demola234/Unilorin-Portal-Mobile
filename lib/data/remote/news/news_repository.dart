import 'package:probitas_app/features/news/data/model/news_response.dart';
import '../../../core/error/exceptions.dart';
import '../../../core/network/base_api.dart';

abstract class NewsRepository {
  Future<List<News>> fetchNews(String token, String source, int page);
}

class NewsRepositoryImpl extends BaseApi implements NewsRepository {
  @override
  Future<List<News>> fetchNews(String token, String source,
      [int page = 1, int pageSize = 18]) async {
    try {

      var data = await get("news", headers: getHeader(token), query: {
        "source": source,
        "page": page,
      });
      final result = List<Map<String, dynamic>>.from(data['data']);
      List<News> news = result
          .map((newsData) => News.fromJson(newsData))
          .toList(growable: false);

      return news;
    } catch (err) {
      if (err is RequestException) {
        throw CustomException(err.message);
      }
      throw CustomException("Something went wrong");
    }
  }
}
