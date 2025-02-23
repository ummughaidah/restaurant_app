import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeSettingProvider extends ChangeNotifier {
  static const String keyTheme = 'theme';
  bool _isDarkTheme = false;

  bool get isDarkTheme => _isDarkTheme;

  ThemeSettingProvider() {
    getPreferece();
  }

  void setDarkTheme(bool value) {
    _isDarkTheme = value;
    notifyListeners();
  }

  setTheme(bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(keyTheme, value);
  }

  Future<bool> getTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(keyTheme) ?? false;
  }

  getPreferece() async {
    _isDarkTheme = await getTheme();
    notifyListeners();
  }
}
