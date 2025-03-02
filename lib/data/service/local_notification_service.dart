import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class LocalNotificationService {
  Future<void> initializeNotifications() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final DarwinInitializationSettings iOSInitializationSettings =
        DarwinInitializationSettings();

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
      iOS: iOSInitializationSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        debugPrint('Notification Clicked: ${response.payload}');
      },
    );
  }

  Future<void> configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterTimezone.getLocalTimezone();
    debugPrint('Local Timezone: $timeZoneName');
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  Future<bool> _isAndroidPermissionGranted() async {
    return await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.areNotificationsEnabled() ??
        false;
  }

  Future<bool> _requestAndroidNotificationsPermission() async {
    return await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.requestNotificationsPermission() ??
        false;
  }

  Future<bool> _requestExactAlarmsPermission() async {
    return await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.requestExactAlarmsPermission() ??
        false;
  }

  Future<bool?> requestPermissions() async {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      final iOSImplementation =
          flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>();
      return await iOSImplementation?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      final notificationGranted =
          await _requestAndroidNotificationsPermission();
      final exactAlarmGranted = await _requestExactAlarmsPermission();
      final notificationEnabled = await _isAndroidPermissionGranted();

      debugPrint('Notification Permission: $notificationGranted');
      debugPrint('Exact Alarm Permission: $exactAlarmGranted');
      debugPrint('Notification Enabled: $notificationEnabled');

      return notificationGranted && exactAlarmGranted && notificationEnabled;
    }
    return false;
  }

  tz.TZDateTime _nextInstanceOfElevenAM() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, 11);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    debugPrint('Scheduled Notification at: $scheduledDate');
    return scheduledDate;
  }

  Future<void> scheduleDailyElevenAMNotification({
    required int id,
    String channelId = "3",
    String channelName = "Schedule Notification",
  }) async {
    final notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        channelId,
        channelName,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
      ),
      iOS: const DarwinNotificationDetails(),
    );

    final datetimeSchedule = _nextInstanceOfElevenAM();

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      'Restaurant',
      'This is a daily scheduled notification for the Restaurant',
      datetimeSchedule,
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.wallClockTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );

    debugPrint('Daily notification scheduled successfully');
  }

  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
    debugPrint('Notification with ID $id canceled');
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    required String payload,
    String channelId = "1",
    String channelName = "Simple Notification",
  }) async {
    final notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        channelId,
        channelName,
        importance: Importance.max,
        priority: Priority.high,
        styleInformation: BigTextStyleInformation(body),
      ),
      iOS: const DarwinNotificationDetails(),
    );

    try {
      await flutterLocalNotificationsPlugin.show(
        id,
        title,
        body,
        notificationDetails,
        payload: payload,
      );
      debugPrint('Notification shown successfully');
    } catch (e) {
      debugPrint('Error showing notification: $e');
    }
  }
}
