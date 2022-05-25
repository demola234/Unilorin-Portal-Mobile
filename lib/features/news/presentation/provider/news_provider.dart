import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controller/news_controller.dart';

final newsNotifierProvider = StateNotifierProvider<NewsNotifier, NewsState>(
  (ref) => NewsNotifier(ref.read),
);