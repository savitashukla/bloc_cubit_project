import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:cubit_project/data/service/api_url.dart';
import 'package:cubit_project/utils/help_method.dart';
import 'package:cubit_project/utils/logger_utils.dart';
import 'package:cubit_project/utils/weight/help_weight.dart';
import 'package:cubit_project/view/login/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../res/AppString.dart';

class WebServicesHelper {
  Future<Map<String, dynamic>?> getUserLogin(Map<String, dynamic> param) async {
    //net connectivity check
    if (!await InternetConnectionChecker().hasConnection) {
      HelpWeight().flutterCustomToast("INTERNET CONNECTIVITY LOST");
      return null;
    }

    HelpMethod().customPrint("param login$param");
    HelpMethod().customPrint("login  url => ${ApiUrl.API_URL_LOGIN}");
    final response = await http.post(Uri.parse(ApiUrl.API_URL_LOGIN),
        body: json.encode(param),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "BasicAuth": AppString().headerToken,
        });
    HelpMethod().customPrint("response login====${response.body}");
    HelpMethod().customPrint("response Code ====" + '${response.statusCode}');
    if (response.statusCode == 200) {
      return json.decode(response.body.toString());
    } else if (response.statusCode == 401 || response.statusCode == 403) {
      HelpMethod().customPrint('Login test 46');
      HelpWeight().flutterCustomToast("Account logged in somewhere else");
      return null;
    } else if (response.statusCode == 400) {
      final res = json.decode(response.body.toString());
      HelpMethod().customPrint('Login test 51');
      Fluttertoast.showToast(msg: "${res["error"]}");
      return null;
    } else {
      final res = json.decode(response.body.toString());
      Fluttertoast.showToast(msg: "${res["error"]}");
      return null;
    }
  }

  Future<Map<String, dynamic>?> getEditProfile(
      var payload, String token, String User_id) async {
    //net connectivity check
    /*if (!await InternetConnectionChecker().hasConnection) {
      Fluttertoast.showToast(msg: 'INTERNET CONNECTIVITY LOST');
      return null;
    }*/
    HelpMethod().customPrint("edit profile  ${jsonEncode(payload)}");
    final response = await http.patch(
      Uri.parse('${ApiUrl().API_URL_USER}$User_id'),
      body: jsonEncode(payload),
      headers: {
        "BasicAuth": AppString().headerToken,
        'Authorization': 'Bearer $token',
      },
    );
    HelpMethod().customPrint("response edit profile ====${response.body}");
    HelpMethod().customPrint("response edit profile ===${response.statusCode}");

    if (response.statusCode == 200) {
      if (response != null) {
        HelpWeight().flutterCustomToast("Successful");
        return json.decode(response.body.toString());
      } else {
        return null;
      }
    } else if (response.statusCode == 401 || response.statusCode == 403) {
      //LogOut(true);
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.remove('token');
      await preferences.remove('user_id');
      await preferences.clear();
      //   Get.offAll(Login());
    } else {
      // Utils().showErrorMessage("", "Some Error");
      return null;
    }
  }

  Future<Map<String, dynamic>?> getProfileData(
      String token, String User_id) async {
    if (User_id != '') {
      //net connectivity check
      /* if (!await InternetConnectionChecker().hasConnection) {
        Fluttertoast.showToast(msg: 'INTERNET CONNECTIVITY LOST');
        return null;
      }*/

      final response = await http.get(
        Uri.parse('${ApiUrl().API_URL_USER}$User_id'),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "BasicAuth": AppString().headerToken,
          'Authorization': 'Bearer $token',
        },
      );
      HelpMethod().customPrint("profile api${ApiUrl().API_URL_USER}$User_id");

      HelpMethod()
          .customPrint("response User Profile Body ====${response.body}");
      HelpMethod()
          .customPrint("response User Profile Code==== ${response.statusCode}");

      if (response.statusCode == 200) {
        if (response != null) {
          return json.decode(response.body.toString());
        } else {
          return null;
        }
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        // LogOut(true);

        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.remove('token');
        await preferences.remove('user_id');
        await preferences.clear();
        // Get.offAll(Login());
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>?> getHomePage(String token) async {
    //net connectivity check
    if (!await InternetConnectionChecker().hasConnection) {
      Fluttertoast.showToast(msg: 'INTERNET CONNECTIVITY LOST');
      return null;
    }

    String url = "";
    if (ApiUrl().isPlayStore) {
      url =
          '${ApiUrl().API_URL_HOME_PAGE}?isPlayStore=${ApiUrl().isPlayStore}&appTypes=lootBox';
    } else {
      url = '${ApiUrl().API_URL_HOME_PAGE}?appTypes=lootBox';
    }
    HelpMethod().customPrint('home url -> $url');
    final response = await http.get(
      Uri.parse(url),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "BasicAuth": AppString().headerToken,
        'Authorization': 'Bearer $token',
      },
    );
    HelpMethod().customPrint("response home page====${response.body}");
    HelpMethod().customPrint("response Code ====${response.statusCode}");

    if (response.statusCode == 200) {
      return json.decode(response.body.toString());
    } else if (response.statusCode == 401 || response.statusCode == 403) {
      // LogOut(true);
      HelpWeight().flutterCustomToast("Account logged in somewhere else");

      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.remove('token');
      await preferences.remove('user_id');
      await preferences.clear();
      // Get.offAll(Login());
    } else {
      return null;
    }
  }


  Future<Map<String, dynamic>?> requestForVerifyOTP(
      Map<String, dynamic> param) async {
    //net connectivity check
    if (!await InternetConnectionChecker().hasConnection) {
      Fluttertoast.showToast(msg: 'INTERNET CONNECTIVITY LOST');
      return null;
    }
    HelpMethod().customPrint("aag otp req");
    HelpMethod().customPrint(json.encode(param));
    HelpMethod().customPrint("aa otp url  ${ApiUrl.API_URL_OTP_VERIFY}");
    final response = await http.post(Uri.parse('${ApiUrl.API_URL_OTP_VERIFY}'),
        body: json.encode(param),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Access-Control-Allow-Credentials": "true",
          "BasicAuth": AppString().headerToken,
        });
    HelpMethod().customPrint("response====" + '${response.body}');
    HelpMethod().customPrint("response Code ====" + '${response.statusCode}');
    if (response != null) {
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        HelpWeight().flutterCustomToast("Some Error ..1");
        return null;
      } else if (response.statusCode == 404) {
        HelpWeight().flutterCustomToast("Invalid otp requestId for provided userId");
        return null;
      } else if (response.statusCode == 400) {
        HelpWeight().flutterCustomToast("Invalid OTP value");
        return null;
      } else {
        HelpWeight().flutterCustomToast("Some Error..0");
        return null;
      }
    } else {
     HelpWeight().flutterCustomToast("Some Error ..-1");
      return null;
    }
  }

  Future<Map<String, dynamic>?> requestForResendOTP(
      Map<String, dynamic> param) async {
    //net connectivity check
    if (!await InternetConnectionChecker().hasConnection) {
      Fluttertoast.showToast(msg: 'INTERNET CONNECTIVITY LOST');
      return null;
    }
    HelpMethod().customPrint("aa gaya");
    HelpMethod().customPrint(json.encode(param));

    final response = await http.post(
        Uri.parse('${ApiUrl.apiURL}user/resendOTP'),
        body: json.encode(param),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Access-Control-Allow-Credentials": "true",
          "BasicAuth": AppString().headerToken,
        });
    HelpMethod().customPrint("response====${response.body}");
    HelpMethod().customPrint("response Code ===${response.statusCode}");
    if (response.statusCode == 200) {
      return json.decode(response.body.toString());
    } else if (response.statusCode == 401 || response.statusCode == 403) {
      //   LogOut(true);
/*      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.remove('token');
      await preferences.remove('userId');
      await preferences.clear();
      Navigator.pushAndRemoveUntil<dynamic>(
        navigatorKey.currentState!.context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => LoginScreen(),
        ),
            (route) => false,//if you want to disable back feature set to false
      );*/



      //  Get.offAll(Login());
    } else {
      return null;
    }
  }

  // offer Wall Api Call

  //Offerwall get data
  Future<Map<String, dynamic>?> getAdvertisersDeals(
      String token,
      String keyword,
      String activeFromDate,
      String activeToDate,
      String status,
      String sortBy,
      String user_id) async {
    //net connectivity check
    if (!await InternetConnectionChecker().hasConnection) {
      Fluttertoast.showToast(msg: 'INTERNET CONNECTIVITY LOST');
      return null;
    }
    var URL =
        '${ApiUrl.apiURL}advertiser/deal?appTypes=lootBox&keyword=$keyword&activeFromDate=$activeFromDate&activeToDate=$activeToDate&status=$status&sortBy=$sortBy&usesLimitFilter=true&includeUserDeals=$user_id&date=${AppString.utcCurrentDate}';
    final response = await http.get(
      Uri.parse(URL),


      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "BasicAuth": AppString().headerToken,
        'Authorization': 'Bearer $token',
      },

    );
    HelpMethod().customPrint('url $URL');
    //Utils().customPrint("getAdvertisersDeals Data ====" + '${response.body}');
    HelpMethod()
        .customPrint("getAdvertisersDeals Code ====${response.statusCode}");

    if (response.statusCode == 200) {
      if (response != null) {
        return json.decode(response.body.toString());
      } else {
        return null;
      }
    } else if (response.statusCode == 403 || response.statusCode == 401) {
      //   LogOut(true);

      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.remove('token');
      await preferences.remove('userId');
      await preferences.clear();
      Navigator.pushAndRemoveUntil<dynamic>(
        navigatorKey.currentState!.context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => LoginScreen(),
        ),
            (route) => false,//if you want to disable back feature set to false
      );
      //Get.offAll(Login());
    } else {
      return null;
    }
  }

  //createUserDeal
  Future<Map<String, dynamic>?> createUserDeal(
      String token, String user_id, Map<String, dynamic> param) async {
    //net connectivity check
    if (!await InternetConnectionChecker().hasConnection) {
      Fluttertoast.showToast(msg: 'INTERNET CONNECTIVITY LOST');
      return null;
    }
    HelpMethod().customPrint("createUserDeal data $param");
    HelpMethod()
        .customPrint("createUserDeal ====" + 'user_id: $user_id token: $token');
    HelpMethod().customPrint(
        'createUserDeal URL==== ${ApiUrl.apiURL}${'user/${user_id}/deal?appTypes=lootBox'}');
    final response = await http.post(
        Uri.parse('${ApiUrl.apiURL}${'user/${user_id}/deal?appTypes=lootBox'}'),
        body: json.encode(param),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "BasicAuth": AppString().headerToken,
          'Authorization': 'Bearer $token',
        });
    //Utils().customPrint("getHashForRummy response ====" + '${response.body}');
    HelpMethod()
        .customPrint("createUserDeal response Code ====${response.statusCode}");
    HelpMethod().customPrint(
        "createUserDeal response Code ==${response.body.toString()}");
    if (response.statusCode == 200) {
      return json.decode(response.body.toString());
    } else if (response.statusCode == 401 || response.statusCode == 403) {

      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.remove('token');
      await preferences.remove('userId');
      await preferences.clear();
      Navigator.pushAndRemoveUntil<dynamic>(
        navigatorKey.currentState!.context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => LoginScreen(),
        ),
            (route) => false,//if you want to disable back feature set to false
      );
      // Fluttertoast.showToast(msg: "Account logged in somewhere else".capitalize);
      return null;
    } else if (response.statusCode == 400) {
      final res = json.decode(response.body.toString());

      if (res["errorCode"] != null &&
          res["errorCode"].toString() == "ERR2302") {
        return res;
      } else {
        Fluttertoast.showToast(msg: "${res["error"]}");
        return null;
      }
    } else {
      //final res = json.decode(response.body.toString());
      Fluttertoast.showToast(msg: "Something went wrong!");
      return null;
    }
  }

  Future<Map<String, dynamic>?> getUserDeals(
    String token,
    String user_id,
  ) async {
    //net connectivity check
    if (!await InternetConnectionChecker().hasConnection) {
      Fluttertoast.showToast(msg: 'INTERNET CONNECTIVITY LOST');
      return null;
    }
    var URL =
        '${ApiUrl.apiURL}user/deal?userId=$user_id&expand=advertiserDealId&appTypes=lootBox';
    final response = await http.get(
      Uri.parse(URL),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "BasicAuth": AppString().headerToken,
        'Authorization': 'Bearer $token',
      },
    );
    HelpMethod().customPrint('url ${URL}');
    HelpMethod().customPrint("getUserDeals Data ====${response.body}");
    HelpMethod()
        .customPrint("getUserDeals Code ====" + '${response.statusCode}');

    if (response.statusCode == 200) {
      if (response != null) {
        return json.decode(response.body.toString());
      } else {
        return null;
      }
    } else if (response.statusCode == 403 || response.statusCode == 401) {

      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.remove('token');
      await preferences.remove('userId');
      await preferences.clear();
      Navigator.pushAndRemoveUntil<dynamic>(
        navigatorKey.currentState!.context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => LoginScreen(),
        ),
            (route) => false,//if you want to disable back feature set to false
      );

    } else {
      return null;
    }
  }

  // Game List API
  Future<Map<String, dynamic>?> getUnitEventList(
      String token,
      String gameid,
      String clanId,
      String displayDateFrom,
      String includeUserEvents,
      String status) async {
    //net connectivity check
    /*if (!await InternetConnectionChecker().hasConnection) {
      Fluttertoast.showToast(msg: 'INTERNET CONNECTIVITY LOST');
      return null;
    }*/
    HelpMethod().customPrint("------ LUDO ------");
    String Url =
        '${ApiUrl.apiURL}event?appTypes=lootBox&expand=gameId,gameModeId,gamePerspectiveId,teamTypeId,gameMapId&isRMG=true';
    if (!gameid.isEmpty) {
      Url = Url + "&gameId=$gameid";
    }
    if (!status.isEmpty) {
      Url = Url + "&status=$status";
    }
    if (!includeUserEvents.isEmpty) {
      Url = Url + "&excludeUserEvents=$includeUserEvents";
    }

    if (ApiUrl().isPlayStore) {
      Url = Url + "&isPlayStore=${ApiUrl().isPlayStore}";
    }

    HelpMethod().customPrint("Url===$Url");
    HelpMethod().customPrint("Header Token${AppString().headerToken}");
    HelpMethod().customPrint("Bearer$token");
    final response = await http.get(
      Uri.parse(Url),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "BasicAuth": AppString().headerToken,
        'Authorization': 'Bearer $token',
      },
    );
    HelpMethod().customPrint("response====" + '${response.body}');
    HelpMethod().customPrint("response Code ====" + '${response.statusCode}');

    if (response.statusCode == 200) {
      if (response != null) {
        return json.decode(response.body.toString());
      } else {
        return null;
      }
    } else if (response.statusCode == 401 || response.statusCode == 403) {


      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.remove('token');
      await preferences.remove('userId');
      await preferences.clear();


      Navigator.pushAndRemoveUntil<dynamic>(
        navigatorKey.currentState!.context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => LoginScreen(),
        ),
            (route) => false,//if you want to disable back feature set to false
      );

      // LogOut(true);

      // Fluttertoast.showToast(msg: "Account logged in somewhere else".capitalize);
    } else {
      return null;
    }
    return null;
  }

  Future<Map<String, dynamic>?> getUnityHistory(String token, String userId,
      String gameId, int totalLimit, var pagesCount) async {
    HelpMethod().customPrint(
        "unity history api ${ApiUrl().API_URL_UNITY_HIS}$gameId&userId=$userId&expand=eventId&limit=$totalLimit&offset=$pagesCount");
    final response = await http.get(
      Uri.parse(
          '${ApiUrl().API_URL_UNITY_HIS}$gameId&userId=$userId&expand=eventId&limit=$totalLimit&offset=$pagesCount'),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "BasicAuth": AppString().headerToken,
        'Authorization': 'Bearer $token',
      },
    );
    HelpMethod().customPrint("response BUY STORE  ====${response.body}");
    HelpMethod().customPrint("response BUY STORE ====${response.statusCode}");

    if (response.statusCode == 200) {
      if (response != null) {
        return json.decode(response.body.toString());
      } else {
        return null;
      }
    } else if (response.statusCode == 401 || response.statusCode == 403) {
      Fluttertoast.showToast(msg: "Account logged in somewhere else");

      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.remove('token');
      await preferences.remove('userId');
      await preferences.clear();

      Navigator.pushAndRemoveUntil<dynamic>(
        navigatorKey.currentState!.context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => LoginScreen(),
        ),
            (route) => false,//if you want to disable back feature set to false
      );

    } else {
      return json.decode(response.body.toString());
    }
    return null;
  }

  Future<Map<String, dynamic>?> getPreEventJoinGameJob(
      var payload, String token, String event_id) async {
    //net connectivity check
    if (!await InternetConnectionChecker().hasConnection) {
      Fluttertoast.showToast(msg: 'INTERNET CONNECTIVITY LOST');
      return null;
    }
    HelpMethod().customPrint("pre join event  id  ${payload}   $event_id");
    HelpMethod().customPrint(
        "url pre-join-validate  => ${ApiUrl().API_URL_PRE_JOIN_EVENT}${'$event_id/pre-join-validate'}");
    final response = await http.post(
      Uri.parse(
          '${ApiUrl().API_URL_PRE_JOIN_EVENT}${'$event_id/pre-join-validate'}'),
      body: json.encode(payload),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "BasicAuth": AppString().headerToken,
        'Authorization': 'Bearer $token',
      },
    );
    HelpMethod()
        .customPrint("response pre join Code ====" + '${response.statusCode}');
    HelpMethod().customPrint("response pre join  ====" + '${response.body}');

    if (response != null) {
      if (response.statusCode == 200) {
        return json.decode(response.body.toString());
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.remove('token');
        await preferences.remove('userId');
        await preferences.clear();
        Navigator.pushAndRemoveUntil<dynamic>(
          navigatorKey.currentState!.context,
          MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => LoginScreen(),
          ),
              (route) => false,//if you want to disable back feature set to false
        );
      } else {
        return json.decode(response.body.toString());
      }
    } else {
      return null;
    }
    return null;
  }

  Future<Map<String, dynamic>?> getPreEventJoin(
      var payload, String token, String eventId) async {
    //net connectivity check
    if (!await InternetConnectionChecker().hasConnection) {
      Fluttertoast.showToast(msg: 'INTERNET CONNECTIVITY LOST');
      return null;
    }
    HelpMethod().customPrint("pre join event  id  $payload   $eventId");
    HelpMethod().customPrint(
        "url pre-join-validate  => ${ApiUrl().API_URL_PRE_JOIN_EVENT}${'$eventId/pre-join-validate'}");
    final response = await http.post(
      Uri.parse(
          '${ApiUrl().API_URL_PRE_JOIN_EVENT}${'$eventId/pre-join-validate'}'),
      body: json.encode(payload),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "BasicAuth": AppString().headerToken,
        'Authorization': 'Bearer $token',
      },
    );
    HelpMethod().customPrint("response pre join  ====${response.body}");
    HelpMethod()
        .customPrint("response pre join Code ====" + '${response.statusCode}');

    if (response != null) {
      if (response.statusCode == 200) {
        return json.decode(response.body.toString());
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.remove('token');
        await preferences.remove('userId');
        await preferences.clear();
        Navigator.pushAndRemoveUntil<dynamic>(
          navigatorKey.currentState!.context,
          MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => LoginScreen(),
          ),
              (route) => false,//if you want to disable back feature set to false
        );
      } else {
        return json.decode(response.body.toString());
      }
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>?> getTeam11BB(
      String token, String user_id, Map<String, dynamic> params) async {
    print("call game id $user_id");
    var URL = '${ApiUrl().MYTEAM11_BB}'.replaceAll('%s', user_id);

    HelpMethod().customPrint("URL====team 11" + '${URL}');
    HelpMethod().customPrint("token====" + '${token}');
    final response = await http.post(
      Uri.parse('${URL}'),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "BasicAuth": AppString().headerToken,
        'Authorization': 'Bearer $token',
      },
      body: json.encode(params),
    );
    HelpMethod().customPrint("response==== team11" + '${response.body}');
    HelpMethod().customPrint("response Code ====" + '${response.statusCode}');

    if (response.statusCode == 200) {
      if (response != null) {
        return json.decode(response.body.toString());
      } else {
        return null;
      }
    } else if (response.statusCode == 401 || response.statusCode == 403) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.remove('token');
      await preferences.remove('userId');
      await preferences.clear();
      Navigator.pushAndRemoveUntil<dynamic>(
        navigatorKey.currentState!.context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => LoginScreen(),
        ),
            (route) => false,//if you want to disable back feature set to false
      );
    } else {
      return null;
    }
  }

// tamasha api

  Future<Map<String, dynamic>?> getTamashaEventList(String token) async {
    String url = "";
    url = ApiUrl.API_URL_TAMASHA_EVENT_LIST;
    HelpMethod().customPrint('getBannerAsPerPageType: $url');

    HelpMethod().customPrint(url);
    final response = await http.get(
      Uri.parse('${url}'),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "BasicAuth": AppString().headerToken,
        'Authorization': 'Bearer $token',
      },
    );
    HelpMethod().customPrint("getBannerAsPerPageType response $response");

    if (response != null) {
      if (response.statusCode == 200) {
        return json.decode(response.body.toString());
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.remove('token');
        await preferences.remove('userId');
        await preferences.clear();
        Navigator.pushAndRemoveUntil<dynamic>(
          navigatorKey.currentState!.context,
          MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => LoginScreen(),
          ),
              (route) => false,//if you want to disable back feature set to false
        );
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>?> getTamashaWebView(
      String token, Map<String, String> param) async {
    SharedPreferences prefs;

    if(token==null)
      {
        prefs = await SharedPreferences.getInstance();
        token = prefs!.getString("token")!;
      }

    if (!await InternetConnectionChecker().hasConnection) {
      Fluttertoast.showToast(msg: 'INTERNET CONNECTIVITY LOST');
      return null;
    }
    HelpMethod()
        .customPrint("TAMASHA Webview call Api  ${ApiUrl.API_URL_WEBTAMASHA}");

    HelpMethod().customPrint("pramas  ${ApiUrl.API_URL_WEBTAMASHA}");

    final response = await http.post(Uri.parse('${ApiUrl.API_URL_WEBTAMASHA}'),
        body: json.encode(param),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "BasicAuth": AppString().headerToken,
          'Authorization': 'Bearer $token',
        });
    HelpMethod().customPrint("response facebook ====" + '${response.body}');
    HelpMethod()
        .customPrint("response Code facebook ====" + '${response.statusCode}');
    //   Fluttertoast.showToast(msg: "response ${response.statusCode}");

    if (response != null) {
      if (response.statusCode == 200) {
        return json.decode(response.body.toString());
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>?> getBannerViaGameId(
      String token, String gameId) async {
    //net connectivity check
    /*if (!await InternetConnectionChecker().hasConnection) {
      Fluttertoast.showToast(msg: 'INTERNET CONNECTIVITY LOST');
      return null;
    }*/
    HelpMethod().customPrint("banner reword");

    String url = "";

    url = '${ApiUrl.API_URL_BANNER}?gameId=$gameId&status=active';
    HelpMethod().customPrint('getBannerViaGameId: $url');

    HelpMethod().customPrint('${url}');
    final response = await http.get(
      Uri.parse('${url}'),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "BasicAuth": AppString().headerToken,
        'Authorization': 'Bearer $token',
      },
    );
    HelpMethod().customPrint("banner reword response $response");

    if (response != null) {
      if (response.statusCode == 200) {
        return json.decode(response.body.toString());
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.remove('token');
        await preferences.remove('userId');
        await preferences.clear();
        Navigator.pushAndRemoveUntil<dynamic>(
          navigatorKey.currentState!.context,
          MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => LoginScreen(),
          ),
              (route) => false,//if you want to disable back feature set to false
        );
      } else {
        return null;
      }
    } else {
      return null;
    }
  }


  Future<Map<String, dynamic>?> getWalletData(String token, String id) async {
    //net connectivity check
    /*if (!await InternetConnectionChecker().hasConnection) {
      Fluttertoast.showToast(msg: 'INTERNET CONNECTIVITY LOST');
      return null;
    }*/
    var URL = '${ApiUrl().API_URL_USER_WALLATE}'.replaceAll('%s', id);
    final response = await http.get(
      Uri.parse('${URL}'),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "BasicAuth": AppString().headerToken,
        'Authorization': 'Bearer $token',
      },
    );
    HelpMethod().customPrint('url ${URL}');
    HelpMethod().customPrint("getWalletData====" + '${response.body}');
    HelpMethod().customPrint("getWalletData Code ====" + '${response.statusCode}');

    if (response.statusCode == 200) {
      if (response != null) {
        return json.decode(response.body.toString());
      } else {
        return null;
      }
    } else if (response.statusCode == 401 || response.statusCode == 403) {
      //Fluttertoast.showToast(msg: "Account logged in somewhere else".capitalize);

      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.remove('token');
      await preferences.remove('userId');
      await preferences.clear();
      Navigator.pushAndRemoveUntil<dynamic>(
        navigatorKey.currentState!.context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => LoginScreen(),
        ),
            (route) => false,//if you want to disable back feature set to false
      );
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>?> getWithdrawal(
      var payload, String token, String user_id) async {
    //net connectivity check
    if (!await InternetConnectionChecker().hasConnection) {
      Fluttertoast.showToast(msg: 'INTERNET CONNECTIVITY LOST');
      return null;
    }
    HelpMethod().customPrint(" getWithdrawal $payload $user_id token $token");
    HelpMethod().customPrint("${ApiUrl().API_URL_USER}${'$user_id/withdrawMethod'}");
    final response = await http.post(
      Uri.parse('${ApiUrl().API_URL_USER}${'$user_id/withdrawMethod'}'),
      body: json.encode(payload),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "BasicAuth": AppString().headerToken,
        'Authorization': 'Bearer $token',
      },
    );
    HelpMethod().customPrint(
        " withdrawMethod upi response ${response.body.toString()}");
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: "Added Sucessfully");

      if (response != null) {
        return json.decode(response.body.toString());
      } else {
        return null;
      }
    } else if (response.statusCode == 401 || response.statusCode == 403) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.remove('token');
      await preferences.remove('userId');
      await preferences.clear();
      Navigator.pushAndRemoveUntil<dynamic>(
        navigatorKey.currentState!.context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => LoginScreen(),
        ),
            (route) => false,//if you want to disable back feature set to false
      );
    } else if (response.statusCode == 404) {
      final res = json.decode(response.body.toString());
      Fluttertoast.showToast(msg: "${res["error"]}");
      return json.decode(response.body.toString());
    } else if (response.statusCode == 400) {
      final res = json.decode(response.body.toString());
      Fluttertoast.showToast(msg: "${res["error"]}");
      return json.decode(response.body.toString());
    } else {
      final res = json.decode(response.body.toString());
      Fluttertoast.showToast(msg: "${res["error"]}");
      return null;
    }
  }

  Future<Map<String, dynamic>?> getWithdrawalUpdate(var payload, String token,
      String user_id, String withdrawMethodId) async {
    if (!await InternetConnectionChecker().hasConnection) {
      Fluttertoast.showToast(msg: 'INTERNET CONNECTIVITY LOST');
      return null;
    }
    HelpMethod().customPrint(" getWithdrawal update $payload $user_id token $token");
    HelpMethod().customPrint(
        "${ApiUrl().API_URL_USER}${'$user_id/withdrawMethod/'}$withdrawMethodId");
    final response = await http.patch(
      Uri.parse(
          '${ApiUrl().API_URL_USER}${'$user_id/withdrawMethod/'}$withdrawMethodId'),
      body: json.encode(payload),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "BasicAuth": AppString().headerToken,
        'Authorization': 'Bearer $token',
      },
    );
    HelpMethod().customPrint(
        " withdrawMethod upi response ${response.body.toString()}");
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: "Added Sucessfully");

      if (response != null) {
        return json.decode(response.body.toString());
      } else {
        return null;
      }
    } else if (response.statusCode == 401 || response.statusCode == 403) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.remove('token');
      await preferences.remove('userId');
      await preferences.clear();
      Navigator.pushAndRemoveUntil<dynamic>(
        navigatorKey.currentState!.context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => LoginScreen(),
        ),
            (route) => false,//if you want to disable back feature set to false
      );



    } else if (response.statusCode == 404) {
      final res = json.decode(response.body.toString());
      Fluttertoast.showToast(msg: "${res["error"]}");
      return json.decode(response.body.toString());
    } else if (response.statusCode == 400) {
      final res = json.decode(response.body.toString());
      Fluttertoast.showToast(msg: "${res["error"]}");
      return json.decode(response.body.toString());
    } else {
      final res = json.decode(response.body.toString());
      Fluttertoast.showToast(msg: "${res["error"]}");
      return null;
    }
  }

  Future<Map<String, dynamic>?> getTransaction(String token, String user_id,
      String wallet_id, int pagesCount, int total_limit) async {

    HelpMethod().customPrint("getTransaction====" +
        'wallet id ${wallet_id}  user_id$user_id token$token');
    HelpMethod().customPrint(
        '${ApiUrl.apiURL}${'user/$user_id/transaction?walletId=$wallet_id&sortBy=date:DESC'}&limit=$total_limit&offset=$pagesCount');
    final response = await http.get(
      Uri.parse(
          '${ApiUrl.apiURL}${'user/$user_id/transaction?walletId=$wallet_id&sortBy=date:DESC'}&limit=$total_limit&offset=$pagesCount'),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "BasicAuth": AppString().headerToken,
        'Authorization': 'Bearer $token',
      },
    );
    HelpMethod().customPrint("heder====" + '${AppString().headerToken}');
    HelpMethod().customPrint("heder====" + 'Bearer ${token}');
    HelpMethod().customPrint("getTransaction====" + '${response.body}');
    HelpMethod().customPrint("getTransaction Code ====" + '${response.statusCode}');

    if (response.statusCode == 200) {
      if (response != null) {
        return json.decode(response.body.toString());
      } else {
        return null;
      }
    } else if (response.statusCode == 401 || response.statusCode == 403) {
      HelpMethod().customPrint('getWithdrawRequest DATA:: -1');
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.remove('token');
      await preferences.remove('userId');
      await preferences.clear();
      Navigator.pushAndRemoveUntil<dynamic>(
        navigatorKey.currentState!.context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => LoginScreen(),
        ),
            (route) => false,//if you want to disable back feature set to false
      );
    } else {
      return json.decode(response.body.toString());
    }
  }


  Future<http.Response?> getWithdrawalClick(
      var payload, String token, String user_id) async {
    //net connectivity check
    if (!await InternetConnectionChecker().hasConnection) {
      Fluttertoast.showToast(msg: 'INTERNET CONNECTIVITY LOST');
      return null;
    }
    HelpMethod().customPrint(
        "getWithdrawal ${json.encode(payload)}  $user_id token $token");
    HelpMethod().customPrint(
        "getWithdrawal ${ApiUrl().API_URL_USER}${'$user_id/withdrawRequest'}");
    final response = await http.post(
      Uri.parse('${ApiUrl().API_URL_USER}${'$user_id/withdrawRequest'}'),
      body: json.encode(payload),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "BasicAuth": AppString().headerToken,
        'Authorization': 'Bearer $token',
      },
    );
    HelpMethod().customPrint("response Withdrawal click ====" + '${response.body}');
    HelpMethod().customPrint(
        "response Withdrawal click  Code ====" + '${response.statusCode}');

    return response;
  }


  Future<Map<String, dynamic>?> getWithdrawalData(
      String token, String user_id) async {

    final response = await http.get(
      Uri.parse('${ApiUrl().API_URL_USER}${'$user_id/withdrawMethod'}'),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "BasicAuth": AppString().headerToken,
        'Authorization': 'Bearer $token',
      },
    );
    HelpMethod().customPrint("withdraw body====" + '${response.body}');
    HelpMethod().customPrint("api Url" + '${'${ApiUrl().API_URL_USER}${'$user_id/withdrawMethod'}'}');
    HelpMethod().customPrint("response Code ====" + '${response.statusCode}');

    if (response.statusCode == 200) {
      if (response != null) {
        return json.decode(response.body.toString());
      } else {
        return null;
      }
    } else if (response.statusCode == 401 || response.statusCode == 403) {

      HelpMethod().customPrint('getWithdrawRequest DATA:: -1');
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.remove('token');
      await preferences.remove('userId');
      await preferences.clear();
      Navigator.pushAndRemoveUntil<dynamic>(
        navigatorKey.currentState!.context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => LoginScreen(),
        ),
            (route) => false,//if you want to disable back feature set to false
      );


    } else {
      Fluttertoast.showToast(msg: "Something went wrong");
      Map<String, dynamic> map = {
        "user_id": user_id,
        "error": response.body.toString()
      };

      return null;
    }
  }




  // setting public
  Future<Map<String, dynamic>?> getSettingPublic() async {
    final response = await http.get(
      Uri.parse('${ApiUrl().setting_public}'),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "BasicAuth": AppString().headerToken,
      },
    );
    HelpMethod().customPrint(
        "dynamic whatsapp values in URL ${ApiUrl().setting_public}");
    HelpMethod().customPrint("dynamic whatsapp values in BODY ${response.body}");
    if (response.statusCode == 200) {
      if (response != null) {
        return json.decode(response.body.toString());
      } else {
        HelpMethod().customPrint('dynamic whatsapp: ERROR');
        return null;
      }
    } else if (response.statusCode == 401 || response.statusCode == 403) {

      HelpMethod().customPrint('getWithdrawRequest DATA:: -1');
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.remove('token');
      await preferences.remove('userId');
      await preferences.clear();
      Navigator.pushAndRemoveUntil<dynamic>(
        navigatorKey.currentState!.context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => LoginScreen(),
        ),
            (route) => false,//if you want to disable back feature set to false
      );
    } else {
      HelpMethod().customPrint('dynamic whatsapp: ERROR LAST');
    }
  }


}
