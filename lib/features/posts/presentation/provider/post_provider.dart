import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:probitas_app/features/posts/presentation/controller/post_controller.dart';

import '../../../../data/remote/posts/post_service.dart';
import '../../../../injection_container.dart';
import '../../../authentication/data/infrastructure/authentication_state.dart';

var postService = getIt<PostService>();
late bool loading;

final postsNotifierProvider =
    StateNotifierProvider.autoDispose<PostsNotifier, PostsState>(
  (ref) => PostsNotifier(ref.watch),
);
