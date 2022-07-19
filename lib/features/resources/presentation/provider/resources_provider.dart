import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../data/remote/resources/resources_services.dart';
import '../../../../injection_container.dart';
import '../../../authentication/data/infrastructure/authentication_state.dart';
import '../controller/resource_controller.dart';

var resourceService = getIt<ResourcesService>();
late bool loading;

final resourceNotifierProviders = StateNotifierProvider(
    (ref) => ResourceNotifier(resourceService, AuthenticationLoading));

final resourcesNotifierProvider = StateNotifierProvider<ResourcesNotifier, ResourceState>(
  (ref) => ResourcesNotifier(ref.read),
);
