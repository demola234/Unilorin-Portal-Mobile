import 'dart:io';
import 'package:probitas_app/data/remote/posts/post_repository.dart';
import 'package:probitas_app/features/posts/data/model/all_comments.dart';
import 'package:probitas_app/features/posts/data/model/all_posts.dart';
import '../../../features/posts/data/model/single_post.dart';
import '../../local/cache.dart';

abstract class PostService {
  Future createPost({String? text, List<File>? images});
  Future<List<PostList>> getPosts(int? page);
  Future likeOrUnlikePost(String postId);
  Future<SinglePostResponse> getSinglePost(String postId);
  Future createComments(String postId, String text);
  Future<SingleCommentResponse> getPostsComments(String postId);
}

class PostServiceImpl extends PostService {
  PostRepository postRepository;
  Cache cache;
  PostServiceImpl({required this.postRepository, required this.cache});

  @override
  Future createPost({String? text, List<File>? images}) async {
    return postRepository.createPost(await cache.getToken(),
        text: text, images: images);
  }

  @override
  Future<List<PostList>> getPosts(int? page) async {
    return postRepository.getAllPosts(await cache.getToken(), page!);
  }

  @override
  Future<SinglePostResponse> getSinglePost(String postId) async {
    return postRepository.getSinglePost(await cache.getToken(), postId);
  }

  @override
  Future likeOrUnlikePost(String postId) async {
    return postRepository.likeOrUnlikePost(await cache.getToken(), postId);
  }

  @override
  Future createComments(String postId, String text) async {
    return postRepository.createComments(await cache.getToken(), postId, text);
  }

  @override
  Future<SingleCommentResponse> getPostsComments(String postId) async {
    return postRepository.getPostsComments(await cache.getToken(), postId);
  }
}
