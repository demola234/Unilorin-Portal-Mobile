import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:probitas_app/core/constants/colors.dart';
import 'core/utils/navigation_service.dart';
import 'features/authentication/presentation/pages/authentication/initail.dart';
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
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: ProbitasColor.ProbitasSecondary,
          onPrimary: ProbitasColor.ProbitasTextPrimary,
          onSurface: ProbitasColor.ProbitasSecondary,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: ProbitasColor.ProbitasSecondary,
          ),
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.dark(
          primary: ProbitasColor.ProbitasSecondary,
          onPrimary: ProbitasColor.ProbitasTextPrimary,
          onSurface: ProbitasColor.ProbitasSecondary,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: ProbitasColor.ProbitasSecondary,
          ),
        ),
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Color(0xFF1A1A2A),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          elevation: 0,
          backgroundColor: ProbitasColor.ProbitasPrimary,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: InitialScreen(),
    ));
  }
}
