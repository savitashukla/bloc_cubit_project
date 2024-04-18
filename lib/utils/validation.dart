import 'package:cubit_project/utils/help_method.dart';

class Validation {
  static bool isValidString(String data) {
    return data.trim().isNotEmpty;
  }
  static bool isValidEmail(String email) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = RegExp(p);
    HelpMethod().customPrint("email=>${regExp.hasMatch(email)}");
    return regExp.hasMatch(email);
  }
  static bool validMobileNumber(String mobileNumber) {
    if (isValidString(mobileNumber)) {
      return false;
    }
    return true;
  }

  static bool validMobileNumberLength(String mobileNumber) {
    if (mobileNumber.length < 7 || mobileNumber.length > 15) {
      return false;
    }
    return true;
  }
}
