import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

Future<void> initNotifications() async {
  final AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('icono');
  final DarwinInitializationSettings initializationSettingsIOS =
    DarwinInitializationSettings();
  final InitializationSettings initializationSettings =
    InitializationSettings(
      android: initializationSettingsAndroid, 
      iOS: initializationSettingsIOS);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

Future<void> showNotification(String grupo, String mensaje) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'channel id',
      'your channel name',
      importance: Importance.max,
      priority: Priority.high,
    );
  const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
    0,
    grupo,
    mensaje,
    platformChannelSpecifics,
  );
}