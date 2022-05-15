import 'dart:io';
import 'package:probitas_app/data/remote/posts/post_repository.dart';
import 'package:probitas_app/data/remote/resources/resources_repository.dart';
import '../../local/cache.dart';

abstract class ResourcesService {
   createResource(
      {String? courseCode, String? courseTitle, String? topic, required File file});
}

class ResourcesServiceImpl extends ResourcesService {
  ResourceRepository resourceRepository;
  Cache cache;
  ResourcesServiceImpl({required this.resourceRepository, required this.cache});

  @override
   createResource(
      {String? courseCode,
      String? courseTitle,
      String? topic,
      required File file}) async {
    return resourceRepository.createResource(
      await cache.getToken(),
      courseCode: courseCode,
      courseTitle: courseTitle,
      topic: topic,
      file: file,
    );
  }
}
