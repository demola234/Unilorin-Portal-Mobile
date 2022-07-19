import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:probitas_app/core/constants/colors.dart';
import 'package:probitas_app/core/utils/config.dart';

import '../../../../core/utils/customs/custom_nav_bar.dart';
import '../../controller/theme_controller.dart';

class ThemesMode extends ConsumerStatefulWidget {
  const ThemesMode({Key? key}) : super(key: key);

  @override
  ConsumerState<ThemesMode> createState() => _ThemeModeState();
}

class _ThemeModeState extends ConsumerState<ThemesMode> {
  String? theme = "system";
  @override
  Widget build(BuildContext context) {
    final notifier = ref.watch(themeNotifierProvider);
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: CustomNavBar(title: "Themes"),
        ),
        body: Column(
          children: [
            YMargin(20),
            _singleTile("Dark Theme", ThemeMode.dark, notifier),
            _singleTile("Light Theme", ThemeMode.light, notifier),
            _singleTile("System Preferences", ThemeMode.system, notifier),
          ],
        ));
  }
}

Widget _singleTile(String title, ThemeMode mode, ThemeNotifier notifier) {
  return RadioListTile<ThemeMode>(
      value: mode,
      title: Text(title),
      groupValue: notifier.themeMode,
      activeColor: ProbitasColor.ProbitasSecondary,
      onChanged: (val) {
        if (val != null) notifier.setTheme(val);
      });
}
