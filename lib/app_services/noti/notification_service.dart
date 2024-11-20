import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:get/get.dart';
import 'package:mobile_rhm/core/extentions/string.dart';
import 'package:mobile_rhm/core/languages/keys.dart';
import 'package:mobile_rhm/core/utils/log_utils.dart';
import 'package:mobile_rhm/data/repository_manager.dart';
import 'package:mobile_rhm/di/components/service_locator.dart';
import 'package:mobile_rhm/firebase_options.dart';

import 'notification_helper.dart';

class NotificationService extends GetxService with NotificationHelper {
  final RepositoryManager _repositoryManager = getIt<RepositoryManager>();
  RxInt noOfUnreadNotification = 0.obs;
  final String APP_NOTI_CHANNEL = 'qlcv_notification_channel';

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    ).then((value) {
      LogUtils.logE(message: 'Init firebase complete');
      onTokenChange();
    });
  }

  void onTokenChange() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    messaging.onTokenRefresh.listen((token) {
      if (_repositoryManager.getUserProfile() != null) {
        pushFirebaseToken(firebaseToken: token);
      }
    });
  }

  @override
  Future pushFirebaseToken({String? firebaseToken}) async {
    try {
      LogUtils.logE(message: 'Push firebase token');
      if (firebaseToken.isNotNullOrEmpty) {
        _repositoryManager.pushFirebaseToken(firebaseToken: firebaseToken!);
      } else {
        FirebaseMessaging messaging = FirebaseMessaging.instance;
        messaging.getToken().then((token) {
          LogUtils.logE(message: '@FirebaseToken is $token');
          if (token.isNotNullOrEmpty) {
            _repositoryManager.pushFirebaseToken(firebaseToken: token!);
          }
        });
      }
    } catch (e) {}
  }

  @override
  Future<bool?> requestPermission() async {
    bool isGrant = await isGrantedNotification();
    LogUtils.logE(message: 'requestPermission grant = $isGrant');
    if (isGrant) {
      handleNotification();
      return true;
    }
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.getNotificationSettings();

    //Android: Setup to show local_notification when app in foreground
    if (Platform.isAndroid) {
      //Create app_channel
      AndroidNotificationChannel channel = AndroidNotificationChannel(
          APP_NOTI_CHANNEL, // id
          AppStrings.app_name.tr, // title
          importance: Importance.max,
          showBadge: true);

      final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
    }

    if (settings.authorizationStatus == AuthorizationStatus.authorized || settings.authorizationStatus == AuthorizationStatus.provisional) {
      handleNotification();
      return true;
    }

    //Request permission -> will show head up on IOS
    settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized || settings.authorizationStatus == AuthorizationStatus.provisional) {
      await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true, // Required to display a heads up notification
        badge: true,
        sound: true,
      );
      handleNotification();
      return true;
    }
    return false;
  }

  _handleMessage(RemoteMessage message) {
    if (message.data['screenTo'] != null) {
      // handleNextScreen(screenTo: message.data['screenTo'], data: message.data);
    }
  }

  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    }
  }

  Future<void> setupInteractedMessage() async {
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  @override
  Future<void> handleNotification() async {
    LogUtils.logE(message: 'handle notification');
    try {
      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
      await setupInteractedMessage();
      //Init local notification
      const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
      const DarwinInitializationSettings initializationSettingsiOS = DarwinInitializationSettings();

      const InitializationSettings initializationSettings =
          InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsiOS);

      final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      // await flutterLocalNotificationsPlugin.initialize(initializationSettings, onDidReceiveNotificationResponse: (NotificationResponse details) {
      //   //TODO: Handle select notification
      // }, onDidReceiveBackgroundNotificationResponse: (NotificationResponse details) {
      //   //TODO: Handle select notification
      // });

      await flutterLocalNotificationsPlugin.initialize(initializationSettings);

      if (Platform.isIOS) {
        FirebaseMessaging messaging = FirebaseMessaging.instance;
        NotificationSettings settings = await messaging.getNotificationSettings();
        if (settings.authorizationStatus == AuthorizationStatus.authorized || settings.authorizationStatus == AuthorizationStatus.provisional) {
          await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
            alert: true, // Required to display a heads up notification
            badge: true,
            sound: true,
          );
        }
      }

      //Handle message coming when app is in foreground
      LogUtils.logE(message: 'listen message forceground');
      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        LogUtils.logE(message: 'has new message from forceground');
        if (message.notification != null) {
          RemoteNotification? notification = message.notification;
          AndroidNotification? android = message.notification?.android;
          AppleNotification? ios = message.notification?.apple;

          // If `onMessage` is triggered with a notification, construct our own
          // local notification to show to users using the created channel.
          if (Platform.isAndroid) {
            LogUtils.logE(message: 'Show message android');
            if (notification != null && android != null) {
              AndroidNotificationChannel channel = AndroidNotificationChannel(APP_NOTI_CHANNEL, AppStrings.app_name.tr,
                  importance: Importance.max, enableVibration: true, showBadge: true);

              flutterLocalNotificationsPlugin.show(
                  notification.hashCode,
                  notification.title,
                  notification.body,
                  NotificationDetails(
                    android: AndroidNotificationDetails(channel.id, channel.name,
                        priority: Priority.max, importance: Importance.max, enableVibration: true),
                  ),
                  payload: jsonEncode(message.data));
            }
          } else if (Platform.isIOS) {}
        }
      });

    } catch (e) {
      LogUtils.logE(message: 'handleNotification error cause ${e.toString()}');
    }
  }

  @override
  Future<bool> isGrantedNotification() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.getNotificationSettings();
    if (settings.authorizationStatus == AuthorizationStatus.authorized || settings.authorizationStatus == AuthorizationStatus.provisional) {
      return true;
    }
    return false;
  }

  @override
  Future deleteFirebaseToken() async {
    _repositoryManager.deleteFirebaseToken();
  }
}
