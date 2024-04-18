import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:cubit_project/model/public_setting.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_share/social_share.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/service/web_services_helper.dart';

class HelpMethod {
  customPrint(var data) async {
    try {
      if (kDebugMode) {
        print("$data");
      } else if (kReleaseMode) {
        // this is release mode
      }
    } catch (e) {
      debugPrint("$e");
    }
  }

/*
  static launchURLApp(String url) async {
    if (await canLaunch( Uri.parse(url).toString())) {
      await launch("${ Uri.parse(url).toString()}");
    } else {
      if (!await launchUrl(Uri.parse(url))) {
        throw Exception('Could not launch $url');
      }
     // throw 'Could not launch $url';
    }
  }*/


  shareTelegram(String refCode) async {
    try {
      SocialShare.shareTelegram(refCode);
    } catch (e) {
      return null;
    }
  }


  funShareS(String refCode) async {
    try {
      await Share.share(refCode);
    } catch (e) {
      return null;
    }
  }

  shareInstagram(String refCode) async {
    try {
    //  SocialShare.shareInstagramStory(ref_code, appId: '');

    } catch (e) {
      Fluttertoast.showToast(msg: "not  installed");
      return null;
    }
  }
  static launchURLApp(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<String?> getUniqueDeviceId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if (Platform.isAndroid) {
      String uniqueDeviceId;
      /*    try {
        uniqueDeviceId = await UniqueDeviceId.get;
      } on PlatformException {*/
      //uniqueDeviceId = 'Failed to get platform version.';
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id;
      // }
      //  return uniqueDeviceId;
    } else {
      var androidDeviceInfo = "";
      return androidDeviceInfo;
    }
  }




  openWhatsappOTPV(int? whatsapp ) async {

    HelpMethod().customPrint("call wha number $whatsapp");
    var whatsappUrlAndroid = "whatsapp://send?phone=" + "91$whatsapp";
    var whatAppUrlIos = "https://wa.me/91$whatsapp";
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunch(whatAppUrlIos)) {
        await launch(whatAppUrlIos, forceSafariVC: false);
      } else {
        Fluttertoast.showToast(msg: "whatsapp no installed");
      }
    } else {
      // android , web
      if (await canLaunch(whatsappUrlAndroid)) {
        await launch(whatsappUrlAndroid);
      } else {
        Fluttertoast.showToast(msg: "whatsapp no installed");
      }
    }
  }

  subtractDate(DateTime expireDate) {
    var apiDate = expireDate.toUtc();
    var utcCurrentDate = DateTime.now().toUtc();
    //Utils().customPrint("current system date $utcCurrentDate");

    var difference = apiDate.difference(utcCurrentDate.toUtc()).inSeconds;
    var differencem = difference * 60;
    customPrint("current system date utcCurrentDate $utcCurrentDate");
    customPrint("current system date expireDate $expireDate");
    customPrint("current system date difference $differencem");
    return difference;
  }

  openwhatsapp(int? message) async {
    print(message);
    var whatsapp = "";
    var whatsappurlAndroid =
        "whatsapp://send?phone=" + whatsapp + "&text=${message}";
    var whatappurlIos = "https://wa.me/$whatsapp?text=${Uri.parse("hello")}";

    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunch(whatappurlIos)) {
        await launch(whatappurlIos, forceSafariVC: false);
      } else {
        Fluttertoast.showToast(msg: "whatsapp no installed");
      }
    } else {
      // android , web
      if (await canLaunch(whatsappurlAndroid)) {
        await launch(whatsappurlAndroid);
      } else {
        Fluttertoast.showToast(msg: "whatsapp no installed");
      }
    }
  }




 static String replace3digit(var balance)
  {

    var _formattedNumber = NumberFormat.compactCurrency(
      decimalDigits: 2,
      symbol: '', // if you want to add currency symbol then pass that in this else leave it empty.
    ).format(balance);

    return _formattedNumber;

  }
}
