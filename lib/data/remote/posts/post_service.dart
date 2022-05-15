import 'dart:io';
import 'package:probitas_app/data/remote/posts/post_repository.dart';
import '../../local/cache.dart';

abstract class PostService {
  Future createPost({String? text, List<File>? images});
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
}
