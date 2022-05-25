import 'dart:io';
import 'package:dio/dio.dart';
import 'package:probitas_app/features/posts/data/model/all_comments.dart';
import 'package:probitas_app/features/posts/data/model/all_posts.dart';
import 'package:probitas_app/features/posts/data/model/single_post.dart';
import '../../../core/error/exceptions.dart';
import '../../../core/network/base_api.dart';

abstract class PostRepository {
  Future createPost(String token, {String? text, List<File>? images});
  Future<PostResponse> getAllPosts(String token);
  Future likeOrUnlikePost(String token, String postId);
  Future<SinglePostResponse> getSinglePost(String token, String postId);
  Future createComments(String token, String postId, String? text);
  Future<SingleCommentResponse> getPostsComments(String token, String postId);
}

class PostRepositoryImpl extends BaseApi implements PostRepository {
  @override
  Future createPost(String token, {String? text, List<File>? images}) async {
    var data = <String, dynamic>{};
    try {
      if (text != null) {
        data['text'] = text;
      }
      if (images != null && images.isNotEmpty) {
        List<MultipartFile> multiPart = [];
        for (var img in images) {
          multiPart.add(await MultipartFile.fromFile(img.path,
              filename:
                  "post_image${DateTime.now().millisecondsSinceEpoch}.${img.path.split(".").last}"));
        }
        data['image'] = multiPart;
        return post("posts",
            headers: getHeader(token), formData: FormData.fromMap(data));
      }
    } catch (err) {
      if (err is RequestException) {
        throw CustomException(err.message);
      }
      throw CustomException("Something went wrong");
    }
  }

  @override
  Future<PostResponse> getAllPosts(String token) async {
    try {
      var data = await get("posts", headers: getHeader(token));
      final s = PostResponse.fromJson(data);
      return s;
    } catch (err) {
      if (err is RequestException) {
        throw CustomException(err.message);
      }
      throw CustomException("Something went wrong");
    }
  }

  @override
  Future<SinglePostResponse> getSinglePost(String token, String postId) async {
    try {
      var data = await get("posts/$postId", headers: getHeader(token));
      final s = SinglePostResponse.fromJson(data);
      return s;
    } catch (err) {
      if (err is RequestException) {
        throw CustomException(err.message);
      }
      throw CustomException("Something went wrong");
    }
  }

  @override
  Future likeOrUnlikePost(String token, String postId) async {
    try {
      var data = await post("posts/$postId/like", headers: getHeader(token));
      return data;
    } catch (err) {
      if (err is RequestException) {
        throw CustomException(err.message);
      }
      throw CustomException("Something went wrong");
    }
  }

  @override
  Future createComments(String token, String postId, String? text) async {
    try {
      var data =
          await post("posts/$postId/comment", headers: getHeader(token), data: {
        "text": text,
      });
      return data;
    } catch (err) {
      if (err is RequestException) {
        throw CustomException(err.message);
      }
      throw CustomException("Something went wrong");
    }
  }

  @override
  Future<SingleCommentResponse> getPostsComments(
      String token, String postId) async {
    try {
      var data = await get("posts/$postId/comments", headers: getHeader(token));
      final s = SingleCommentResponse.fromJson(data);
      return s;
    } catch (err) {
      if (err is RequestException) {
        throw CustomException(err.message);
      }
      throw CustomException("Something went wrong");
    }
  }
}
