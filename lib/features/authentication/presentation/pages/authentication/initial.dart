
import 'package:flutter/material.dart';

import '../../../../../core/utils/navigation_service.dart';
import '../../../../../data/local/cache.dart';
import '../onboarding/onboarding.dart';
import 'logger_screen.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
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
        });
  }
}
