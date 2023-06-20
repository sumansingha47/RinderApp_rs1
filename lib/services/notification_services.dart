import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotification {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings("@mipmap/ic_launcher");

    DarwinInitializationSettings darwinSettings = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestSoundPermission: true,
        requestBadgePermission: true);

    InitializationSettings initializationSettings = InitializationSettings(
        android: androidSettings, iOS: darwinSettings, macOS: darwinSettings);

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> scheduleNotification(
      String title, String body, DateTime scheduleDate) async {
    AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails("channelId", "reminderChannel");

    DarwinNotificationDetails darwinDetails = DarwinNotificationDetails(
        presentAlert: true, presentBadge: true, presentSound: true);

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidDetails, iOS: darwinDetails, macOS: darwinDetails);

    flutterLocalNotificationsPlugin.schedule(
        0, title, body, scheduleDate, notificationDetails);
  }
}
