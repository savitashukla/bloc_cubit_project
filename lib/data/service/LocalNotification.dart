import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:cubit_project/utils/help_method.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalNotificationService {
  static var onSelectNotification = false;
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
  FlutterLocalNotificationsPlugin();
  static FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

  static void initialize() {
    // initializationSettings  for Android
    InitializationSettings initializationSettings = const InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
    );

    _notificationsPlugin.initialize(
      initializationSettings,
    /*  onSelectNotification: (String? payload) async {
        print(payload);
        HelpMethod().customPrint("onSelectNotification");
        if (payload!.isNotEmpty) {
          if (payload.compareTo("freshChat") == 0) {
            onSelectNotification = true;
          }
          HelpMethod().customPrint("Router Value1234 $payload");
        }
      },*/
    );
  }

  static onSelectNotificationLunchT() async {
    final notificationAppLaunchDetails =
    await _notificationsPlugin.getNotificationAppLaunchDetails();
    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      HelpMethod().customPrint(notificationAppLaunchDetails);
      HelpMethod().customPrint(
          "getNotificationAppLaunchDetails=============${notificationAppLaunchDetails.toString()}");
   /* if (notificationAppLaunchDetails!.payload!.compareTo("freshChat") == 0) {
        onSelectNotification = true;
      } else {
        onSelectNotification = false;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("channel_id", "");
      }*/
      // await onSelectNotification111(notificationAppLaunchDetails.payload);
      //    return notificationAppLaunchDetails.payload;
    }
  }


  static void createanddisplaynotification(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      const NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          "earnzoflutter",
          "earnzoflutterchannel",
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
        ),
      );

    await _notificationsPlugin.show(id,  message.notification!.title??"", message.notification!.body??"", notificationDetails);
    } on Exception catch (e) {
      HelpMethod().customPrint(e);
    }
  }

  static void showNotificationWithDefaultSound(String body_values) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'earnzoflutter',
      "earnzoflutterchannel",
      channelDescription:
      "This channel is responsible for all the local notifications",
      playSound: true,
      priority: Priority.high,
      importance: Importance.high,
    );

    var platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await _notificationsPlugin.show(
      0,
      'Support Responded',
      body_values??"Support",
      platformChannelSpecifics,
      payload: 'freshChat',
    );
  }


}
