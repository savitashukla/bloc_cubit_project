import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  SharedPreferences? prefs;

  Future<SharedPreferences?> getinstnace() async {
    if (prefs == null) {
      prefs = await SharedPreferences.getInstance();
      return prefs;
    }
  }

  addStringValues(String key, String values) {
    if (prefs != null) prefs!.setString(key, values);
  }


  setStringUserId(String key, String values) async {
    if (prefs != null) {
      prefs!.setString(key, values);
    } else {
      prefs = await SharedPreferences.getInstance();
      prefs!.setString(key, values);
    }
  }

  Future<String?> getStringUserId(String key) async {
    prefs ??= await SharedPreferences.getInstance();
    return prefs!.getString(key);
  }


  setString(String key, String values) async {
    if (prefs != null) {
      prefs!.setString(key, values);
    } else {
      prefs = await SharedPreferences.getInstance();
      prefs!.setString(key, values);
    }
  }


  Future<String?> getStringValues(String key) async {
    prefs ??= await SharedPreferences.getInstance();
    //Return String
    return prefs!.getString(key);
  }




}
