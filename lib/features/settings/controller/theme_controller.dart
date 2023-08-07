import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;
  SharedPreferences? prefs;
  final box = GetStorage();

  ThemeNotifier() {
    _init();
  }

  _init() async {
    prefs = await SharedPreferences.getInstance();

    int _theme = prefs?.getInt("theme") ?? themeMode.index;
    themeMode = ThemeMode.values[_theme];
    notifyListeners();
  }

  setTheme(ThemeMode mode) {
    themeMode = mode;
    notifyListeners();
    prefs?.setInt("theme", mode.index);
  }
}

final themeNotifierProvider =
    ChangeNotifierProvider<ThemeNotifier>((_) => ThemeNotifier());
