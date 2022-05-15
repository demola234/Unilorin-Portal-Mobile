import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:probitas_app/features/news/data/model/news_response.dart';
import '../../../core/error/exceptions.dart';
import '../../../core/network/base_api.dart';

abstract class PostRepository {
  Future createPost(String token, {String? text, List<File>? images});
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
              contentType: MediaType.parse("image/jpeg"),
              filename:
                  "post_image_${DateTime.now().millisecondsSinceEpoch}.${img.path.split(".").last}"));
        }
        data['images'] = multiPart;
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
}
