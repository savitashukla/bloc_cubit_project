import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:cubit_project/utils/help_method.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/route/Routes.dart';
import '../data/service/LocalNotification.dart';
import '../utils/logger_utils.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  SharedPreferences? prefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getScreenCall();

    // 1. This method call when app in terminated state and you get a notification
    // when you click on notification app open from terminated state and you can get notification data in this method

    FirebaseMessaging.instance.getInitialMessage().then(
      (message) async {
        HelpMethod().customPrint(
            "FirebaseMessaging.instance.getInitialMessage${message.toString()}");

        if (message != null) {
          //  LocalNotificationService.showNotificationWithDefaultSound("");
          if (message.notification != null) {
            LocalNotificationService.createanddisplaynotification(message);
            HelpMethod().customPrint("New Notification");
          } else {
            //  LocalNotificationService.showNotificationWithDefaultSound("");
          }
        }
      },
    );

    // 2. This method only call when App in forground it mean app must be opened

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) async {
        HelpMethod().customPrint("FirebaseMessaging.onMessageOpenedApp.listen");

        //  Utils().customPrint("Aditi Rao Agle Sakal yeah${message.notification.title}");
        //    Utils().customPrint("FirebaseMessaging.onMessage.listen${message.notification.body}");
        //    LocalNotificationService.createanddisplaynotification(message);Aditi Rao Agle Sakal

        if (message.notification != null) {
          LocalNotificationService.createanddisplaynotification(message);
        } else {
          // LocalNotificationService.showNotificationWithDefaultSound("");
        }
      },
    );

    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) async {
        HelpMethod().customPrint("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          HelpMethod().customPrint(message.notification!.title);
          HelpMethod().customPrint(message.notification!.body);
          HelpMethod().customPrint("message.data22 ${message.data['_id']}");
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        color: Colors.black,
      ),
    ));
  }

  Future<void> getScreenCall() async {
    prefs = await SharedPreferences.getInstance();
    String? token = prefs!.getString("token");
    String? userId = prefs!.getString("userId");



    if (token != null && userId != null) {
      Navigator.pushNamed(navigatorKey.currentState!.context, Routes.dashBoard);
    } else {
      Navigator.pushNamed(navigatorKey.currentState!.context, Routes.login);
    }
  }
}
