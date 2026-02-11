
import 'dart:convert';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  String? _fcmToken;
  String? get fcmToken => _fcmToken;

  Future<void> initialize() async {
    try {
      NotificationSettings settings = await _firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
        provisional: false,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        log('Notification permission granted');

        await getFreshToken();
        await _setupLocalNotifications();
        _setupForegroundMessageHandler();
        _setupBackgroundMessageHandler();
        _setupTerminatedStateHandler();
      } else {
        log('Notification permission denied');
      }
    } catch (e) {
      log('Error initializing notifications: $e');
    }
  }

  Future<void> _setupLocalNotifications() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        log('Notification tapped');
        if (response.payload != null) {
          _handleNotificationTap(response.payload);
        }
      },
    );

    await _createNotificationChannel();
    log('Local notifications setup complete');
  }

  Future<void> _createNotificationChannel() async {
    final androidPlugin = _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    if (androidPlugin == null) return;

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'default_channel',
      'Default Notifications',
      description: 'General notifications',
      importance: Importance.high,
      enableVibration: true,
      playSound: true,
    );

    await androidPlugin.createNotificationChannel(channel);
    log('Notification channel created');
  }

  void _setupForegroundMessageHandler() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('Foreground message received');
      log('Title: ${message.notification?.title}');
      log('Body: ${message.notification?.body}');
      _showLocalNotification(message);
    });
  }

  void _setupBackgroundMessageHandler() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log('Background message opened');
      _handleNotificationTap(jsonEncode(message.data));
    });
  }

  void _setupTerminatedStateHandler() {
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        log('App opened from terminated state');
        Future.delayed(const Duration(milliseconds: 1500), () {
          _handleNotificationTap(jsonEncode(message.data));
        });
      }
    });
  }

  Future<void> _showLocalNotification(RemoteMessage message) async {
    try {
      final String title = message.notification?.title ?? 'Notification';
      final String body = message.notification?.body ?? 'You have a new message!';

      // Big Text Style ke liye Android notification details
      final BigTextStyleInformation bigTextStyle = BigTextStyleInformation(
        body,
        htmlFormatBigText: true,
        contentTitle: title,
        htmlFormatContentTitle: true,
        summaryText: message.data['summary'] ?? '',
        htmlFormatSummaryText: true,
      );

      final AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
        'default_channel',
        'Default Notifications',
        channelDescription: 'General notifications',
        importance: Importance.high,
        priority: Priority.high,
        showWhen: true,
        icon: '@mipmap/ic_launcher',
        styleInformation: bigTextStyle, // Expanded notification ke liye
        enableLights: true,
        enableVibration: true,
        playSound: true,
      );

      const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );

      final NotificationDetails platformDetails = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      int notificationId = DateTime.now().millisecondsSinceEpoch.remainder(100000);

      final payloadData = jsonEncode({
        ...message.data,
        'notification_id': notificationId.toString(),
        'title': title,
        'body': body,
      });

      await _localNotifications.show(
        notificationId,
        title,
        body,
        platformDetails,
        payload: payloadData,
      );

      log('Notification shown: $title');
    } catch (e) {
      log('Error showing notification: $e');
    }
  }

  // Inbox Style notification ke liye separate method
  Future<void> showInboxStyleNotification({
    required String title,
    required List<String> messages,
    String? summary,
    Map<String, dynamic>? data,
  }) async {
    try {
      final InboxStyleInformation inboxStyle = InboxStyleInformation(
        messages,
        contentTitle: title,
        summaryText: summary ?? '${messages.length} messages',
        htmlFormatLines: true,
        htmlFormatContentTitle: true,
        htmlFormatSummaryText: true,
      );

      final AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
        'default_channel',
        'Default Notifications',
        channelDescription: 'General notifications',
        importance: Importance.high,
        priority: Priority.high,
        styleInformation: inboxStyle,
        icon: '@mipmap/ic_launcher',
      );

      const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );

      final NotificationDetails platformDetails = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      int notificationId = DateTime.now().millisecondsSinceEpoch.remainder(100000);

      final payloadData = jsonEncode({
        ...?data,
        'notification_id': notificationId.toString(),
        'title': title,
      });

      await _localNotifications.show(
        notificationId,
        title,
        messages.first,
        platformDetails,
        payload: payloadData,
      );

      log('Inbox notification shown: $title');
    } catch (e) {
      log('Error showing inbox notification: $e');
    }
  }

  void _handleNotificationTap(String? payload) {
    if (payload != null) {
      try {
        final data = jsonDecode(payload) as Map<String, dynamic>;
        log('Notification tapped with data: $data');
        
        // Yahan apna navigation logic add karein
        // Get.toNamed(AppRoutes.notificationsRoute);
      } catch (e) {
        log('Error parsing payload: $e');
      }
    }
  }

  Future<String?> getFreshToken() async {
    try {
      _fcmToken = await _firebaseMessaging.getToken();
      log('FCM Token: $_fcmToken');
      return _fcmToken;
    } catch (e) {
      log('Error getting FCM token: $e');
      return null;
    }
  }

  Future<void> deleteToken() async {
    try {
      await _firebaseMessaging.deleteToken();
      _fcmToken = null;
      log('FCM Token deleted');
    } catch (e) {
      log('Error deleting FCM token: $e');
    }
  }
}