import 'dart:convert';
import 'dart:ffi';
import 'dart:io';


import 'package:app_settings/app_settings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';

import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;



class NotificationHelper {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;

  static Future<void> getFcmToken() async {
    String? token = await _firebaseMessaging.getToken();
    print('FCM Token: $token');
  }

  /// notification inisalize

  static Future<void> init(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    // local notification inisalize
    await initLocalNotification(flutterLocalNotificationsPlugin);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // Handle the notification when the app is in the foreground.
      debugPrint("=========> onMessage Message : $message");
      if (Platform.isAndroid) {
        NotificationHelper.showNotification(
            message, flutterLocalNotificationsPlugin, false);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // Handle the notification when the app is terminated and the user taps on it.
      // _handleNotificationRedirection(message);

      Map<String, dynamic> data = message.data;
      handleNotificationRedirection(data);
      debugPrint(" ==========> onMessageOpenedApp Message : $message");
    });

    // If the app is terminated, this callback will be triggered when the user taps on the notification.
    // RemoteMessage? initialMessage =
    //     await FirebaseMessaging.instance.getInitialMessage();
    // if (initialMessage != null) {
    //   log.i("Initial Message  : $initialMessage");
    //   print("Initial Message : $initialMessage");
    // }
  }

  static Future<void> initLocalNotification(
      FlutterLocalNotificationsPlugin fln) async {
    var initializationSettingsAndroid =
    const AndroidInitializationSettings('notification_icon');
    var initializationSettingsIOS = const DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await fln.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse? paylod) async {
        try {
          Map<String, dynamic> _payloadData;
          if (paylod != null && paylod.payload!.isNotEmpty) {
            _payloadData = jsonDecode(paylod.payload!);
            debugPrint("======== > Initialize Local Notification payload : $_payloadData");

            handleNotificationRedirection(_payloadData);
          }
        } catch (e) {}
        return;
      },
    );
  }

  static void notificationPermission() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);
    NotificationSettings settings =
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint("=======> User notification permission authorized");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      ("========> User notification permission provisional");
    } else {
      AppSettings.openAppSettings();
    }
  }

  static Future<void> showNotification(RemoteMessage message,
      FlutterLocalNotificationsPlugin fln, bool data) async {
    String title;
    String body;
    String? image;

    if (data) {
      title = message.data["title"];
      body = message.data["body"];
      image =
      (message.data['image'] != null && message.data['image'].isNotEmpty)
          ? message.data['image']
          : null;
    } else {
      title = message.notification!.title!;
      body = message.notification!.body!;
      if (GetPlatform.isAndroid) {
        image = ((message.notification!.android!.imageUrl != null &&
            message.notification!.android!.imageUrl!.isNotEmpty)
            ? message.notification!.android!.imageUrl
            : null);
      } else if (GetPlatform.isIOS) {
        image = ((message.notification!.apple!.imageUrl != null &&
            message.notification!.apple!.imageUrl!.isNotEmpty)
            ? message.notification!.apple!.imageUrl
            : null);
      }
    }
    if (image != null && image.isNotEmpty) {
      try {
        await showBigPictureNotificationHiddenLargeIcon(
            title, body, message.data, image, fln);
        debugPrint("======> Show Big Picture Notification ");
      } catch (e) {
        await showTextNotification(title, body, message.data, fln);
        debugPrint("=======> Show  Text Notification ");
      }
    } else {
      await showBigTextNotification(title, body, message.data, fln);
      debugPrint("======> Show Big Text Notification ");
    }
  }

// <-------------------------- Show Text Notification  --------------------------->
  static Future<void> showTextNotification(
      String title,
      String body,
      Map<String, dynamic>? notificationBody,
      FlutterLocalNotificationsPlugin fln) async {
    // <---------- add commend 2 line add manifest.xml--------------->
    // <meta-data
    //      android:name="com.google.firebase.messaging.default_notification_channel_id"
    //      android:value="notification" />
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'notification', // meta-data android value
      'notification', // meta-data android value
      playSound: true,
      importance: Importance.max,
      priority: Priority.high,
      icon: "notification_icon",
      sound: RawResourceAndroidNotificationSound('notification_sound'),
    );

    // var iOSPlatformChannelSpecifics = const DarwinNotificationDetails(
    //     presentAlert: true, presentBadge: true, presentSound: true);

    // var platformChannelSpecifics = NotificationDetails(
    //   android: androidPlatformChannelSpecifics,
    //   iOS: iOSPlatformChannelSpecifics,
    // );

    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, title, body, platformChannelSpecifics,
        payload:
        notificationBody != null ? jsonEncode(notificationBody) : null);
  }

// <-------------------------- Show Big Text Notification  --------------------------->
  static Future<void> showBigTextNotification(
      String title,
      String body,
      Map<String, dynamic>? notificationBody,
      FlutterLocalNotificationsPlugin fln) async {
    BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
      body,
      htmlFormatBigText: true,
      contentTitle: title,
      htmlFormatContentTitle: true,
    );
    AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'notification',
      'notification',
      importance: Importance.max,
      styleInformation: bigTextStyleInformation,
      priority: Priority.max,
      icon: "notification_icon",
      playSound: true,
      sound: const RawResourceAndroidNotificationSound('notification_sound'),
    );
    NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, title, body, platformChannelSpecifics,
        payload:
        notificationBody != null ? jsonEncode(notificationBody) : null);
  }

// <-------------------------- Show Big Picture Notification Hiden largeIcon --------------------------->

  static Future<void> showBigPictureNotificationHiddenLargeIcon(
      String title,
      String body,
      Map<String, dynamic>? notificationBody,
      String image,
      FlutterLocalNotificationsPlugin fln) async {
    final String largeIconPath = await _downloadAndSaveFile(image, 'largeIcon');
    final String bigPicturePath =
    await _downloadAndSaveFile(image, 'bigPicture');
    final BigPictureStyleInformation bigPictureStyleInformation =
    BigPictureStyleInformation(
      FilePathAndroidBitmap(bigPicturePath),
      hideExpandedLargeIcon: true,
      contentTitle: title,
      htmlFormatContentTitle: true,
      summaryText: body,
      htmlFormatSummaryText: true,
    );
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'notification',
      'notification',
      largeIcon: FilePathAndroidBitmap(largeIconPath),
      priority: Priority.max,
      playSound: true,
      styleInformation: bigPictureStyleInformation,
      importance: Importance.max,
      icon: "notification_icon",
      sound: const RawResourceAndroidNotificationSound('notification_sound'),
    );
    final NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, title, body, platformChannelSpecifics,
        payload:
        notificationBody != null ? jsonEncode(notificationBody) : null);
  }

  static Future<String> _downloadAndSaveFile(
      String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

// <-------------------------- On Click Notification Screen Route --------------------------->

  static void handleNotificationRedirection(Map<String, dynamic> data) {
    // Use the data in the message.data to determine which page to redirect to.
    // For example, suppose you send a 'page' key in your notificati  on data:


  }

  /// back ground notificationService
  ///

  @pragma('vm:entry-point')
  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message,
      ) async {
    //  await Firebase.initializeApp();
    //   var androidInitialize = const AndroidInitializationSettings('notification_icon');
    //  var iOSInitialize = const DarwinInitializationSettings();
    //  var initializationsSettings = InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
    // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
// flutterLocalNotificationsPlugin.initialize(initializationsSettings);
    // NotificationHelper.showNotification(message, flutterLocalNotificationsPlugin, false);

    //  await  NotificationHelper.showNotification(message, flutterLocalNotificationsPlugin, false);
  }
}