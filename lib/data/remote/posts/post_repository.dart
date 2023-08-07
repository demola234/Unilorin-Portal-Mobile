import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:probitas_app/features/posts/data/model/all_comments.dart';
import 'package:probitas_app/features/posts/data/model/all_posts.dart';
import 'package:probitas_app/features/posts/data/model/single_post.dart';
import '../../../core/error/exceptions.dart';
import '../../../core/network/base_api.dart';

abstract class PostRepository {
  Future createPost(String token, {required String text, List<File>? images});
  Future<List<PostList>> getAllPosts(String token, int page);
  Future likeOrUnlikePost(String token, String postId);
  Future<SinglePostResponse> getSinglePost(String token, String postId);
  Future createComments(String token, String postId, String? text);
  Future<SingleCommentResponse> getPostsComments(String token, String postId);
  Future deletePost(String token, String postId);
}

class PostRepositoryImpl extends BaseApi implements PostRepository {
  @override
  Future createPost(String token,
      {required String text, List<File>? images}) async {
    var data = <String, dynamic>{};
    try {
      print(text);
      data['text'] = text;
      if (images != null && images.isNotEmpty) {
        List<MultipartFile> multiPart = [];
        for (var image in images) {
          multiPart.add(await MultipartFile.fromFile(image.path,
              contentType: MediaType.parse("image/jpeg"),
              filename:
                  "post_image${DateTime.now().millisecondsSinceEpoch}.${image.path.split(".").last}"));
        }
        print(multiPart);
        data['image'] = multiPart;
      }
      return post("posts",
          headers: getHeader(token), formData: FormData.fromMap(data));
    } catch (err) {
      if (err is RequestException) {
        throw CustomException(err.message);
      }
      throw CustomException("Something went wrong");
    }
  }

  @override
  Future<List<PostList>> getAllPosts(String token, [int page = 1]) async {
    try {
      var data = await get(
        "posts",
        headers: getHeader(token),
        query: {"page": page},
      );
      final result = List<Map<String, dynamic>>.from(data['data']);
      List<PostList> posts = result
          .map((postData) => PostList.fromJson(postData))
          .toList(growable: false);
      return posts;
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

  @override
  Future deletePost(String token, String postId) async {
    try {
      var data = await delete("posts/$postId", headers: getHeader(token));
      final s = SinglePostResponse.fromJson(data);
      return s;
    } catch (err) {
      if (err is RequestException) {
        throw CustomException(err.message);
      }
      throw CustomException("Something went wrong");
    }
  }
}
