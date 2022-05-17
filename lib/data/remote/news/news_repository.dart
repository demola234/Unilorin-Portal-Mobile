import 'package:probitas_app/features/news/data/model/news_response.dart';
import '../../../core/error/exceptions.dart';
import '../../../core/network/base_api.dart';

abstract class NewsRepository {
  Future<NewsResponse> fetchNews(String token, String source, int page);
}

class NewsRepositoryImpl extends BaseApi implements NewsRepository {
  @override
  Future<NewsResponse> fetchNews(String token, String source, int page) async {
    try {
      var data = await get("news", headers: getHeader(token), query: {
        "source": source,
        "page": page,
      });

      final s = NewsResponse.fromJson(data);

      return s;
    
    } catch (err) {
      if (err is RequestException) {
        throw CustomException(err.message);
      }
      throw CustomException("Something went wrong");
    }
  }
}
