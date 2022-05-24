import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/remote/news/news_service.dart';
import '../../../../injection_container.dart';
import '../controller/news_controller.dart';

final newsService = getIt<NewsService>();
final newsNotifierProvider = StateNotifierProvider((ref) {
  return NewsPaginationController(newsService);
});
