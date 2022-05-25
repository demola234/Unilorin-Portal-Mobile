import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:probitas_app/data/local/cache.dart';
import 'package:probitas_app/features/posts/data/model/all_posts.dart';
import 'package:probitas_app/features/posts/data/model/single_post.dart';
import 'package:probitas_app/features/posts/presentation/provider/post_provider.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/toasts.dart';
import '../../../../core/utils/navigation_service.dart';
import '../../../../data/remote/posts/post_service.dart';
import '../../../../injection_container.dart';
import '../../data/model/all_comments.dart';

class PostNotifier extends StateNotifier {
  var postService = getIt<PostService>();
  var cache = getIt<Cache>();
  bool? loading;
  PostNotifier(this.postService, loading) : super(loading);

  Future<void> createPost(String text, List<File>? images) async {
    loading = true;
    try {
      await postService.createPost(text: text, images: images);
      print(images);
      NavigationService().goBack();
      Toasts.showSuccessToast("Post Have been uploaded successfully");
      print(loading);
    } catch (e) {
      Toasts.showErrorToast(ErrorHelper.getLocalizedMessage(e));
    }
  }

  Future<void> likedOrUnlike(String postId, bool isLiked) async {
    try {
      await postService.likeOrUnlikePost(postId);
      Toasts.showSuccessToast("You have successfully liked the post");
      print(loading);
    } catch (e) {
      Toasts.showErrorToast(ErrorHelper.getLocalizedMessage(e));
    }
  }

  Future<void> createComments(String postId, String text) async {
    try {
      await postService.createComments(postId, text);
      Toasts.showSuccessToast("Your comment has successfully been created!");
      print(loading);
    } catch (e) {
      Toasts.showErrorToast(ErrorHelper.getLocalizedMessage(e));
    }
  }
}

final getPostsProvider = FutureProvider<PostResponse>((ref) async {
  final getAllPosts = await postService.getPosts();

  return getAllPosts;
});

final getSinglePostProvider =
    FutureProvider.family<SinglePostResponse, String>((ref, postId) async {
  final getSinglePost = await postService.getSinglePost(postId);

  return getSinglePost;
});


final getSinglePostCommentsProvider =
    FutureProvider.family<SingleCommentResponse, String>((ref, postId) async {
  final getSinglePost = await postService.getPostsComments(postId);

  return getSinglePost;
});