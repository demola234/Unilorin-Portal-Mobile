import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:overlay_support/overlay_support.dart';
import 'core/constants/theme.dart';
import 'core/utils/navigation_service.dart';
import 'features/authentication/presentation/pages/authentication/initial.dart';
import 'features/settings/controller/theme_controller.dart';
import 'injection_container.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await injector();
  await GetStorage.init();
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  var brightness = SchedulerBinding.instance!.window.platformBrightness;
  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    final _themeNotifier = ref.watch(themeNotifierProvider);
    return OverlaySupport.global(
        child: MaterialApp(
      title: 'Probitas App',
      navigatorKey: NavigationService().navigationKey,
      themeMode: _themeNotifier.themeMode,
      theme: themes(),
      darkTheme: darkTheme(),
      debugShowCheckedModeBanner: false,
      home: InitialScreen(),
    ));
  }
}
