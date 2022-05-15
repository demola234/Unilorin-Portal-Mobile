import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:probitas_app/data/local/cache.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/toasts.dart';
import '../../../../core/utils/navigation_service.dart';
import '../../../../data/remote/resources/resources_services.dart';
import '../../../../injection_container.dart';

class ResourceNotifier extends StateNotifier {
  var resourceRepository = getIt<ResourcesService>();
  var cache = getIt<Cache>();
  bool? loading;
  ResourceNotifier(this.resourceRepository, loading) : super(loading);

  createResource(
      String? courseCode, String? courseTitle, String? topic, File file) async {
    loading = true;
    print(file);
    try {
      await resourceRepository.createResource(
          courseCode: courseCode,
          courseTitle: courseTitle,
          topic: topic,
          file: file);

      NavigationService().goBack();
      Toasts.showSuccessToast("Resource Have been uploaded successfully");
      print(loading);
    } catch (e) {
      Toasts.showErrorToast(ErrorHelper.getLocalizedMessage(e));
    }
  }
}
