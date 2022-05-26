import 'dart:io';
import 'package:probitas_app/data/remote/resources/resources_repository.dart';
import '../../../features/resources/data/model/resource_response.dart';
import '../../local/cache.dart';

abstract class ResourcesService {
  createResource(
      {String? courseCode,
      String? courseTitle,
      String? topic,
      required File file});
  Future<ResourceResponse> getResources();
  Future<ResourceResponse> searchResources(
    String search,
  );
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

  @override
  Future<ResourceResponse> getResources() async {
    return resourceRepository.getResources(await cache.getToken());
  }

  @override
  Future<ResourceResponse> searchResources(String search) async {
    return resourceRepository.searchResources(await cache.getToken(), search);
  }
}
