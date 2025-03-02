import 'package:flutter/material.dart';
import 'package:restaurant_app/data/service/local_notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingProvider extends ChangeNotifier {
  static const String keyTheme = 'theme';
  static const String keyReminder = 'daily_reminder';
  bool _isDarkTheme = false;
  bool _isReminderOn = false;
  final LocalNotificationService _notificationService;

  SettingProvider(this._notificationService) {
    _loadSettings();
  }

  bool get isDarkTheme => _isDarkTheme;
  bool get isReminderOn => _isReminderOn;

  void setDarkTheme(bool value) async {
    _isDarkTheme = value;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(keyTheme, value);
    notifyListeners();
  }

  void toggleReminder(bool value) async {
    _isReminderOn = value;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(keyReminder, value);
    if (value) {
      await _notificationService.scheduleDailyElevenAMNotification(id: 0);
    } else {
      await _notificationService.cancelNotification(0);
    }
    notifyListeners();
  }

  void _loadSettings() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _isDarkTheme = sharedPreferences.getBool(keyTheme) ?? false;
    _isReminderOn = sharedPreferences.getBool(keyReminder) ?? false;
    notifyListeners();
  }
}
