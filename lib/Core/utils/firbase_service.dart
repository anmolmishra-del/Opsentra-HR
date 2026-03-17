import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseNotificationService {
  static final _firebaseMessaging = FirebaseMessaging.instance;
  static final _localNotifications = FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    // 🔐 Request permission (Android 13+)
    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // 🔑 Get token
    final token = await _firebaseMessaging.getToken();
    print("🔥 FCM TOKEN: $token");

    // 🔔 Local notification setup
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const initSettings =
        InitializationSettings(android: androidSettings);

    await _localNotifications.initialize(initSettings);

    // 🔔 Foreground notification
    FirebaseMessaging.onMessage.listen(_onMessage);
  }

  static void _onMessage(RemoteMessage message) {
    final notification = message.notification;
    if (notification == null) return;

    _localNotifications.show(
      notification.hashCode,
      notification.title,
      notification.body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'default_channel',
          'General Notifications',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
    );
  }
}
