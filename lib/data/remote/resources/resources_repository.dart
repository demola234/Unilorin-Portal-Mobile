import 'dart:io';
import 'package:dio/dio.dart';
import '../../../core/error/exceptions.dart';
import '../../../core/network/base_api.dart';
import '../../../features/resources/data/model/resource_response.dart';

abstract class ResourceRepository {
  createResource(String token,
      {String? courseCode,
      String? courseTitle,
      String? topic,
      required File file});

  Future<ResourceResponse> getResources(String token, int page);
  Future<ResourceResponse> searchResources(
    String token,
    String search,
  );
  Future deleteResources(String token, String resourceId);
}

class ResourceRepositoryRepositoryImpl extends BaseApi
    implements ResourceRepository {
  @override
  createResource(String token,
      {String? courseCode,
      String? courseTitle,
      String? topic,
      required File file}) async {
    var data = <String, dynamic>{
      "courseCode": courseCode,
      "courseTitle": courseTitle,
      "topic": topic,
    };
    print(data);
    try {
      data["file"] = await MultipartFile.fromFile(file.path,
          filename:
              "resource${file.path.split(".").last}.${file.path.split(".").last}");

      final v = await post("resources",
          headers: getHeader(token), formData: FormData.fromMap(data));
      print(v);
    } catch (err) {
      if (err is RequestException) {
        throw CustomException(err.message);
      }
      print(err);
      throw CustomException("Something went wrong");
    }
  }

  @override
  Future<ResourceResponse> getResources(String token, [int page = 1]) async {
    var data = await get("resources", headers: getHeader(token));
    try {
      final s = ResourceResponse.fromJson(data);
      return s;
    } catch (err) {
      if (err is RequestException) {
        throw CustomException(err.message);
      }

      throw CustomException("Something went wrong");
    }
  }

  @override
  Future<ResourceResponse> searchResources(String token, String search) async {
    var data = await get("resources/search", headers: getHeader(token), query: {
      "s": search,
    });
    try {
      final s = ResourceResponse.fromJson(data);
      return s;
    } catch (err) {
      if (err is RequestException) {
        throw CustomException(err.message);
      }
      throw CustomException("Something went wrong");
    }
  }

  @override
  Future deleteResources(String token, String resourceId) async {
    try {
      var data =
          await delete("resources/$resourceId", headers: getHeader(token));
      final s = ResourceResponse.fromJson(data);
      return s;
    } catch (err) {
      if (err is RequestException) {
        throw CustomException(err.message);
      }
      throw CustomException("Something went wrong");
    }
  }
}
