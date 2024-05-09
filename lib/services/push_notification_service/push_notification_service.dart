import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../base/utils/utilities.dart';
import '../../features/device_management/app_state.dart';
import '../../features/device_management/bloc/device_management_bloc.dart';
import '../../injector/injector.dart';
import '../crashlytics_service/crashlytics_service.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  //await Firebase.initializeApp();
  Utilities.printObj('Handling a background message: ${message.messageId}');
}

class PushNotificationService {
  PushNotificationService({required CrashlyticsService crashlyticsService})
      : _crashlyticsService = crashlyticsService {
    init();
  }
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  AndroidNotificationChannel androidNotificationChannel() =>
      const AndroidNotificationChannel(
        'high_importance_channel',
        'High Importance Notifications',
        description: 'This channel is used for important notifications.',
        importance: Importance.max,
      );

  final CrashlyticsService _crashlyticsService;

  Future<void> init() async {
    FlutterError.onError = _crashlyticsService.recordFlutterFatalError;
    PlatformDispatcher.instance.onError = (error, stack) {
      _crashlyticsService.recordError(error, stack, fatal: true);
      return true;
    };
    FirebaseMessaging.instance.onTokenRefresh.listen((event) {
      Injector.instance<DeviceManagementBloc>().add(SetFCMTokenEvent());
    });
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    await _setupInteractedMessage();
    await _registerNotificationListeners();
  }

  Future<void> _setupInteractedMessage() async {
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      Utilities.printObj('App open in Firebase');
      _onPushNotificationFetched(message, NotificationAppState.onClick);
    });

    FirebaseMessaging.onMessage.listen((message) {
      if (message.data.containsKey('custom')) {
        return;
      }
      _onPushNotificationFetched(
          message, NotificationAppState.onForegroundListen);
    });

    await _enableIOSNotifications();
    await _registerNotificationListeners();
  }

  Future<void> _enableIOSNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<void> _registerNotificationListeners() async {
    await _setUpAndroidNotificationSettings();
    // var androidSettings = const AndroidInitializationSettings('drawable/logo');
    // var iOSSettings = const DarwinInitializationSettings(
    //   requestSoundPermission: false,
    //   requestBadgePermission: false,
    //   requestAlertPermission: false,
    // );

    // var initSetttings =
    //     InitializationSettings(android: androidSettings, iOS: iOSSettings);
    // _flutterLocalNotificationsPlugin.initialize(
    //   initSetttings,
    //   onDidReceiveNotificationResponse: (details) {
    //     if ((details.payload ?? '') == '') {
    //       Injector.instance<ApiLogService>().showLog();
    //     }
    //   },
    // );
  }

  void _onPushNotificationFetched(
      RemoteMessage message, NotificationAppState state) {
    _flutterLocalNotificationsPlugin.show(
        message.notification.hashCode,
        message.notification!.title,
        message.notification!.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            androidNotificationChannel().id,
            androidNotificationChannel().name,
            channelDescription: androidNotificationChannel().description,
          ),
        ));
  }

  Future<void> _setUpAndroidNotificationSettings() async {
    final channel = androidNotificationChannel();
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  void resetFCMToken() {
    FirebaseMessaging.instance
        .deleteToken()
        .then((value) => FirebaseMessaging.instance.getToken());
  }

  Future<void> addInitialMessageListener() async {
    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _onPushNotificationFetched(
          initialMessage, NotificationAppState.appLaunched);
    }
  }

  Future<String?> getPushToken() async {
    final messaging = FirebaseMessaging.instance;

    final _ = await messaging.requestPermission();

    return FirebaseMessaging.instance.getToken();
  }
}
