import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:probitas_app/data/local/cache.dart';
import 'package:probitas_app/features/posts/data/model/all_posts.dart';
import 'package:probitas_app/features/posts/data/model/single_post.dart';
import 'package:probitas_app/features/posts/presentation/provider/post_provider.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/toasts.dart';
import '../../../../core/utils/navigation_service.dart';
import '../../../../core/utils/states.dart';
import '../../../../data/remote/posts/post_service.dart';
import '../../../../injection_container.dart';
import '../../data/model/all_comments.dart';

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

class PostsNotifier extends StateNotifier<PostsState> {
  PostsNotifier(this._read) : super(PostsState.initial()) {
    getPosts();
  }
  final postService = getIt<PostService>();
  final Reader _read;

  Future<void> createPost(String text, List<File>? images) async {
    state = state.copyWith(viewState: ViewState.loading);
    try {
      await postService.createPost(text: text.trim(), images: images);
      print(images);
      NavigationService().goBack();

      Toasts.showSuccessToast("Post Have been uploaded successfully");
    } catch (e) {
      Toasts.showErrorToast(ErrorHelper.getLocalizedMessage(e));
    } finally {
      state = state.copyWith(viewState: ViewState.idle);
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

  Future<void> getPosts() async {
    try {
      state = state.copyWith(
        viewState: ViewState.loading,
        currentPage: 1,
      );

      final posts = await postService.getPosts(state.currentPage);
      state = state.copyWith(
        posts: posts,
        currentPage: state.currentPage,
        viewState: ViewState.idle,
      );

      if (state.posts!.length < state.pageSize) {
        state = state.copyWith(moreDataAvailable: false);
      }
    } on CustomException {
      state = state.copyWith(viewState: ViewState.error);
    }
  }

  Future<void> getMorePosts() async {
    try {
      final posts = await postService.getPosts(state.currentPage + 1);

      if (posts.isEmpty) {
        state = state.copyWith(moreDataAvailable: false);
      }

      state = state.copyWith(
        posts: [...state.posts!, ...posts],
        viewState: ViewState.idle,
        currentPage: state.currentPage + 1,
      );
    } on CustomException {
      state = state.copyWith(viewState: ViewState.error);
    }
  }
}

class PostsState {
  final ViewState viewState;
  final List<PostList>? posts;
  final int currentPage;
  final bool moreDataAvailable;

  const PostsState._({
    this.posts,
    required this.viewState,
    required this.currentPage,
    required this.moreDataAvailable,
  });

  factory PostsState.initial() => const PostsState._(
        currentPage: 1,
        moreDataAvailable: true,
        viewState: ViewState.idle,
      );

  final int pageSize = 25;

  PostsState copyWith({
    List<PostList>? posts,
    int? currentPage,
    bool? moreDataAvailable,
    String? searchQuery,
    ViewState? viewState,
  }) {
    return PostsState._(
      posts: posts ?? this.posts,
      currentPage: currentPage ?? this.currentPage,
      moreDataAvailable: moreDataAvailable ?? this.moreDataAvailable,
      viewState: viewState ?? this.viewState,
    );
  }
}
