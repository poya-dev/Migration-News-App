import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FCMService {
  static FirebaseMessaging? _firebaseMessaging;

  static final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const AndroidNotificationChannel _notificationChannel =
      AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    importance: Importance.high,
    enableVibration: true,
  );

  static Future<void> initializeFirebase() async {
    print('-------initializeFirebase-------');
    await Firebase.initializeApp();
    FCMService._firebaseMessaging = FirebaseMessaging.instance;
  }

  static Future<void> requestPermission() async {
    NotificationSettings? settings =
        await FCMService._firebaseMessaging?.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    print('-------requestPermission--------->${settings!.authorizationStatus}');
  }

  static Future<void> initializeLocalNotification() async {
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/launcher_icon'),
      iOS: DarwinInitializationSettings(),
    );
    await FCMService._localNotificationsPlugin.initialize(
      initializationSettings,
    );
    await _localNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_notificationChannel);
    await FCMService._firebaseMessaging
        ?.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  static Future<String?> getDeviceToken() async {
    final deviceToken = await FCMService._firebaseMessaging?.getToken();
    if (deviceToken!.isEmpty) {
      return null;
    }
    return deviceToken;
  }

  static FirebaseMessaging getFMInstance() {
    if (FCMService._firebaseMessaging != null) {
      return FCMService._firebaseMessaging!;
    } else {
      return FirebaseMessaging.instance;
    }
  }

  static Future<void> onBackgroundMessage() async {
    FirebaseMessaging.onBackgroundMessage(FCMService.fcmBackgroundHandler);
  }

  static Future<void> fcmBackgroundHandler(RemoteMessage message) async {
    print("handling background message.messageId ${message.messageId}");
    print(
        "handling background notification!.title ${message.notification!.title}");
    print(
        "handling background message.notification!.body ${message.notification!.body}");
    print("handling background message.data ${message.data}");
  }

  static Future<void> onForegroundMessage() async {
    FirebaseMessaging.onMessage.listen(FCMService.fcmForegroundHandler);
  }

  static Future<void> fcmForegroundHandler(RemoteMessage message) async {
    print("handling background message.messageId ${message.messageId}");
    print("handling background message ${message.notification}");
    print("handling background message.data ${message.data}");
    await FCMService.showNotification(message);
  }

  static Future<void> showNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null) {
      FCMService._localNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _notificationChannel.id,
            _notificationChannel.name,
          ),
        ),
      );
    }
  }
}
