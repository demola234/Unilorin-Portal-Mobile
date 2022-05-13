import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:probitas_app/core/constants/colors.dart';
import 'package:probitas_app/features/authentication/presentation/pages/authentication/logger_screen.dart';
import 'package:probitas_app/features/authentication/presentation/pages/onboarding/onboarding.dart';
import 'core/utils/navigation_service.dart';
import 'data/local/cache.dart';
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

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var brightness = SchedulerBinding.instance!.window.platformBrightness;
  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
        child: MaterialApp(
      title: 'Probitas App',
      navigatorKey: NavigationService().navigationKey,
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Color(0xFF1A1A2A),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            elevation: 0,
            backgroundColor: ProbitasColor.ProbitasPrimary,
          )),
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<bool>(
          future: Cache.get().isFirstLoad(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data! == true) {
                Future.delayed(Duration(microseconds: 1),
                    () => NavigationService().replaceScreen(OnBoarding()));
              } else {
                Future.delayed(Duration(microseconds: 1),
                    () => NavigationService().replaceScreen(LoggerScreen()));
              }
            }
            return Scaffold();
          }),
    ));
  }
}
