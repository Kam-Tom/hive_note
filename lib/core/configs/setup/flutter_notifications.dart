import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:logger/logger.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static late Logger _logger;

  static void setLogger(Logger logger) {
    _logger = logger;
  }

  static Future<void> _onDidReceiveNotificationResponse(NotificationResponse response) async {
    _logger.d('onDidReceiveNotificationResponse: $response');
    // Add handling logic here
  }

  static Future<void> _onDidReceiveBackgroundNotificationResponse(NotificationResponse response) async {
    _logger.d('onDidReceiveBackgroundNotificationResponse: $response');
    // Add handling logic here
  }

  static Future<void> init() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings darwinInitializationSettings =
        DarwinInitializationSettings();

    const InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: darwinInitializationSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse,
      onDidReceiveBackgroundNotificationResponse: _onDidReceiveBackgroundNotificationResponse,
    );

    await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.requestNotificationsPermission();

    await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
  }

  static Future<void> showInstantNotification(int id, String title, String body) async {
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: AndroidNotificationDetails(
        "hive_note_reminders", // channel_Id
        "Reminders", // channel_name
        channelDescription: "Notifications for scheduled reminders in Hive Note",
        importance: Importance.high,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );

    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      platformChannelSpecifics,
    );
  }

  static Future<void> scheduleNotification(int id, String title, String body, DateTime scheduledDate) async {
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: AndroidNotificationDetails(
        "hive_note_reminders", // channel_Id
        "Reminders", // channel_name
        channelDescription: "Notifications for scheduled reminders in Hive Note",
        importance: Importance.high,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );


    await flutterLocalNotificationsPlugin.zonedSchedule(
      id, // Use the mapped ID
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      platformChannelSpecifics,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime);
  }

  /// Unschedules a notification with the given ID.
  /// 
  /// If the ID does not exist, this method will do nothing and will not throw an error.
  static Future<void> unscheduleNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}