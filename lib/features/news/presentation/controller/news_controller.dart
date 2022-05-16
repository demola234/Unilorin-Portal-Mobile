import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:probitas_app/data/remote/news/news_service.dart';
import 'package:probitas_app/features/news/data/model/news_response.dart';
import 'package:probitas_app/injection_container.dart';

var newsService = getIt<NewsService>();
int currentPage = 1;
final getNewsProvider = FutureProvider<NewsResponse>((ref) async {
  final profile = await newsService.fetchUsers("unilorinsu", currentPage);
  currentPage++;

  return profile;
});
