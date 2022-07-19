// ignore_for_file: unused_field

import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:probitas_app/data/local/cache.dart';
import 'package:probitas_app/features/resources/presentation/provider/resources_provider.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/toasts.dart';
import '../../../../core/utils/navigation_service.dart';
import '../../../../data/remote/resources/resources_services.dart';
import '../../../../injection_container.dart';
import '../../data/model/resource_response.dart';
import 'package:probitas_app/core/error/exceptions.dart';
import 'package:probitas_app/injection_container.dart';

import '../../../../core/utils/states.dart';

class ResourceNotifier extends StateNotifier {
  var resourceRepository = getIt<ResourcesService>();
  var cache = getIt<Cache>();
  bool? loading;
  ResourceNotifier(this.resourceRepository, loading) : super(loading);
}

var resourceRepository = getIt<ResourcesService>();

final getResourcesSearchedNotifier =
    FutureProvider.family<ResourceResponse, String>((ref, search) async {
  final resourceSearchResponse =
      await resourceRepository.searchResources(search);

  return resourceSearchResponse;
});

final deleteResourceProvider = FutureProvider.family((ref, String resourceId) async {
  final delete = await resourceService.deleteResource(resourceId);
  return delete;
});

class ResourcesNotifier extends StateNotifier<ResourceState> {
  ResourcesNotifier(this._read) : super(ResourceState.initial()) {
    getResource();
  }
  var resourceRepository = getIt<ResourcesService>();
  final Reader _read;

  Future<void> getResource() async {
    try {
      state = state.copyWith(
        viewState: ViewState.loading,
        currentPage: state.currentPage,
      );

      final resource = await resourceRepository.getResources(state.currentPage + 1);

      state = state.copyWith(
        resource: resource.data,
        currentPage: state.currentPage,
        viewState: ViewState.idle,
      );

      if (state.resource!.length < state.pageSize) {
        state = state.copyWith(moreDataAvailable: false);
      }
    } on CustomException {
      state = state.copyWith(viewState: ViewState.error);
    }
  }

  Future<void> getMoreResources() async {
    try {
      final resource = await resourceRepository.getResources(state.currentPage);

      if (resource.data!.isNotEmpty) {
        state = state.copyWith(moreDataAvailable: false);
      }

      state = state.copyWith(
        resource: [...state.resource!, ...resource.data!],
        viewState: ViewState.idle,
        currentPage: state.currentPage + 1,
      );
    } on CustomException {
      state = state.copyWith(viewState: ViewState.error);
    }
  }

  createResource(
      String? courseCode, String? courseTitle, String? topic, File file) async {
    state = state.copyWith(viewState: ViewState.loading);
    print(file);
    try {
      await resourceRepository.createResource(
          courseCode: courseCode,
          courseTitle: courseTitle,
          topic: topic,
          file: file);

      NavigationService().goBack();
      Toasts.showSuccessToast("Resource Have been uploaded successfully");
    } catch (e) {
      Toasts.showErrorToast(ErrorHelper.getLocalizedMessage(e));
    } finally {
      state = state.copyWith(viewState: ViewState.idle);
    }
  }
}

class ResourceState {
  final ViewState viewState;
  final List<Datum>? resource;
  final int currentPage;
  final bool moreDataAvailable;

  const ResourceState._({
    this.resource,
    required this.viewState,
    required this.currentPage,
    required this.moreDataAvailable,
  });

  factory ResourceState.initial() => const ResourceState._(
        currentPage: 1,
        moreDataAvailable: true,
        viewState: ViewState.idle,
      );

  final int pageSize = 17;

  ResourceState copyWith({
    List<Datum>? resource,
    int? currentPage,
    bool? moreDataAvailable,
    String? searchQuery,
    ViewState? viewState,
  }) {
    return ResourceState._(
      resource: resource ?? this.resource,
      currentPage: currentPage ?? this.currentPage,
      moreDataAvailable: moreDataAvailable ?? this.moreDataAvailable,
      viewState: viewState ?? this.viewState,
    );
  }
}
