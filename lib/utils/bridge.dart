import 'package:flutter/services.dart';
class NativeBridge {
  static const messageChannel = MethodChannel('flutter/channel');
  static const methodHello = "OpenPocket52";
  static const openUnityGames = "UnityGames";
  static const methodChangeInternetConnectivity = "CHANGE_INTERNET";

  static const eventChannel =
      EventChannel('flutter/event_channel');

  static bool currentValue = false;
  static Stream<bool>? eventStream;

  static Stream<bool>? listenToNativeEventChannel() {
    eventStream ??= eventChannel.receiveBroadcastStream().cast<bool>();
    return eventStream;
  }

  static void changeInternetConnectivity() {
    Map<String, dynamic> params = {};

    currentValue = !currentValue;
    params["connectivity"] = currentValue;

    messageChannel.invokeMethod(methodChangeInternetConnectivity, params);
  }

  static Future<String> sayHiToNative() async {
    String response = "";
    try {
      final String result = await messageChannel.invokeMethod(methodHello);
      response = result;
    } on PlatformException catch (e) {
      response = "Failed to Invoke: '${e.message}'.";
    }
    return response;
  }

  static Future<String> callOpenPocket52(Map<String, String> data) async {
    String response = "";
    try {
      final String result =
          await messageChannel.invokeMethod(methodHello, data);
      response = result;
    } on PlatformException catch (e) {
      response = "Failed to Invoke: '${e.message}'.";
    }
    return response;
  }

  static Future<String> OpenUnityGames(Map<String, String> data) async {
    String response = "";
    try {
      final String result =
          await messageChannel.invokeMethod(openUnityGames, data);
      response = result;
    } on PlatformException catch (e) {
      response = "Failed to Invoke: '${e.message}'.";
    }
    return response;
  }

  Future<String> OpenInstagram(String data) async {
    String response = "";
    try {
      final String result =
          await messageChannel.invokeMethod('InstagramShare', data);
      response = result;
    } on PlatformException catch (e) {
      response = "Failed to Invoke: '${e.message}'.";
    }
    return response;
  }

  //not using
  Future<String> OpenLudoKing() async {
    String response = "";
    try {
      final String result =
          await messageChannel.invokeMethod('OpenLudoKing', '');
      response = result;
    } on PlatformException catch (e) {
      response = "Failed to Invoke: '${e.message}'.";
    }
    return response;
  }

  Future<String> OpenRummy(Map<String, String> data) async {
    String response = "";
    try {
      final String result = await messageChannel.invokeMethod('OpenRummy', data);


    } on PlatformException catch (e) {
      response = "Failed to Invoke: '${e.message}'.";
    }
    return response;
  }
}
