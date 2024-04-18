import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cubit_project/data/route/Routes.dart';
import 'package:cubit_project/model/lootBoxModel/loot_box_advertisers_model.dart';
import 'package:cubit_project/model/lootBoxModel/user_deal_model.dart';
import 'package:cubit_project/utils/help_method.dart';
import 'package:cubit_project/utils/logger_utils.dart';
import 'package:cubit_project/utils/weight/help_weight.dart';
import 'package:cubit_project/view/login/otp_screen.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/service/web_services_helper.dart';
import '../../../model/LoginModel.dart';
import '../../../model/otp_responce_model.dart';
import '../../../model/public_setting.dart';
import '../../../res/AppString.dart';
import '../../../utils/helper_progressbar.dart';
import '../../../utils/preferences/UserPreferences.dart';

part 'loot_box_equatable.dart';

class LootBoxCubit extends Cubit<LootBoxEquatable> {
  SharedPreferences? prefs;

  String? version;

  String? code;

  String? packageName;

  LootBoxCubit()
      : super(LootBoxEquatable.init(
            isProcessing: false,
            selectedCategoryIndex: 3,

            currentIndex: 2,
            checkTurnOffLootBox: true,
            colorPrimaryOfferWall: const Color(0xff46558c),
            colorwhiteOfferWall: const Color(0xffffffff),
            onlyNumber: "9829953786",
            secondV: 60));

  void init() async {
    emit(state.copyWith(
      isProcessing: true,
    ));

    emit(state.copyWith(
      isProcessing: false,
    ));
  }

  void changeIndex(var index) {
    emit(state.copyWith(
      currentIndex: index,
    ));
  }

  void offerCall() {
    emit(state.copyWith(
        checkTurnOffLootBox: true,
        colorPrimaryOfferWall: const Color(0xFF46558C),
        colorwhiteOfferWall: const Color(0xFFffffff)));
  }

  void historyCall() {
    emit(state.copyWith(
        checkTurnOffLootBox: false,
        colorwhiteOfferWall: const Color(0xFF46558C),
        colorPrimaryOfferWall: const Color(0xFFffffff)));
  }

  void secondValuesSet(secondV) {
    emit(state.copyWith(secondV: secondV));
  }

  Future<void> onSubmitLogin(String phone) async {
    getAppversion();
    HelpMethod().customPrint("mobile Number$phone");
    /*var result = await validateMobile(phone);
    if (result == '0') {
      return;
    }*/
    final FirebaseMessaging _fcm = FirebaseMessaging.instance;
    var token =  _fcm.getToken();
    print("call data here$token");


    String tokecall="$token";

    final param = {
      "mobileNumber": "$phone",
      "countryCode": AppString().txtCountry,
      "referralCode": "",
      "device": {
        "fcmId": "${tokecall ?? "-"}",
        "info": "dfghjk567",
        "type": "android",
        "version": "2.7.4",
        //new work
        "id": "12345edc",
        "name": "gmng pro",
        "productName": "gmng",
        "cpuName": "-",
        "IMEI": 0,
        "platformVersion": "${version ?? "-"}",
        "apiLevel": "33",
        "hardware": "-",
        "mode": "-",
        "manufacturer": "-"
      },
      "registeredThrough": {
        "appVersion": "${code ?? "-"}",
        "appType": "lootBox",
        "appPackage": "com.gmng.earnzo"
      },
      "campaign": {}
    };

    showProgress();
    HelpMethod().customPrint("api login request $param");
    Map<String, dynamic>? responseLogin =
        await WebServicesHelper().getUserLogin(param);
    HelpMethod().customPrint('response on view $responseLogin');
    hideProgress();
    if (responseLogin != null) {
      LoginModel? loginResponse = LoginModel.fromJson(responseLogin);

      try {
        if (loginResponse.statusCode == null) {
          emit(state.copyWith(
            loginResponse: loginResponse,
          ));
          prefs = await SharedPreferences.getInstance();
          prefs!.setString("user_id", "${loginResponse.userId}");
          prefs!.setString("user_mobileNo", phone);
          emit(state.copyWith(
            onlyNumber: phone,
          ));

          Navigator.push(
            navigatorKey.currentState!.context,
            MaterialPageRoute(builder: (context) => OtpScreen(phone)),
          );

          /* Navigator.pushNamed(
              navigatorKey.currentState!.context, Routes.otpScreen);*/
        } else {
          HelpWeight().flutterCustomToast("${loginResponse.error}}");
        }
      } catch (E) {}
    } else {
      HelpWeight().flutterCustomToast("Error Coming");
    }
  }

  Future<void> onSubmitOtp(
      String? otpRequestId, String? userId, String enterOtp) async {
    if (enterOtp != null && enterOtp.length < 6) {
      //btnControllerProfile.reset();
      HelpWeight().flutterCustomToast("Please enter a valid OTP");
      return;
    }

    final param = {
      "otpRequestId": "$otpRequestId",
      "otp": "$enterOtp",
      "userId": "$userId"
    };
    HelpMethod().customPrint(param);
    Map<String, dynamic>? response;

    showProgress();

    response = await WebServicesHelper().requestForVerifyOTP(param);

    hideProgress();

    debugPrint("otp ===$response");

    if (response != null) {
      OtpResponseModel loginResponseModel = OtpResponseModel.fromJson(response);
      SharedPreferences prefs;
      prefs = await SharedPreferences.getInstance();

      UserPreferences().getinstnace();
      UserPreferences().setString("token", "${loginResponseModel.token}");
      UserPreferences().setStringUserId("userId", "$userId");
      prefs.setString("token", "${loginResponseModel.token}");
      prefs.setString("userId", "$userId");
      Navigator.pushNamed(navigatorKey.currentState!.context, Routes.dashBoard);
    } else {
      // btnControllerProfile.reset();
      HelpWeight().flutterCustomToast("Error");
      HelpMethod().customPrint("else part");
    }
  }

  Future<void> onResendOtp(String? userId, String phoneNumber) async {
    Map<String, dynamic>? responseResendOtp;

    final param = {
      "mobileNumber": phoneNumber,
      "countryCode": 91,
      "userId": userId
    };

    showProgress();

    responseResendOtp = await WebServicesHelper().requestForResendOTP(param);

    hideProgress();
    HelpMethod().customPrint("respondata===${responseResendOtp}");
    LoginModel loginResponseModel = LoginModel.fromJson(responseResendOtp!);

    if (loginResponseModel != null) {
      emit(state.copyWith(
        loginResponse: loginResponseModel,
      ));
      HelpWeight().flutterCustomToast("OTP Sent Successfully");
    } else {
      HelpWeight().flutterCustomToast("Some Thing Went Wrong");
    }
  }

  // offer Wall Screen Call

  Future<void> getAdvertisersDeals() async {
    HelpMethod().customPrint('response getAdvertisersDeals code CALLING...');
    prefs = await SharedPreferences.getInstance();
    String? token = prefs!.getString("token");
    String? userId = prefs!.getString("userId");

    HelpMethod().customPrint("toke call $token");

    Map<String, dynamic>? response = await WebServicesHelper()
        .getAdvertisersDeals("${token!}", "", "", "", "active",
            "order:ASC,createdAt:DESC", "${userId}");
    HelpMethod().customPrint('response getAdvertisersDeals code IN WAY...');

    if (response != null) {
      LootBoxAdvertisersModel? offerWallList =
          LootBoxAdvertisersModel.fromJson(response);
      emit(state.copyWith(lootBoxAdvertisers: offerWallList));

      HelpMethod().customPrint(
          'response getAdvertisersDeals code length ${offerWallList.data!.length}');
    } else {
      HelpMethod().customPrint('response getAdvertisersDeals ERROR');
    }
  }

  //withdrawal cancel api
  Future<void> createUserDeal(
      BuildContext context, Map<String, dynamic> param) async {
    prefs = await SharedPreferences.getInstance();
    String? token = prefs!.getString("token");
    String? userId = prefs!.getString("userId");

    Map<String, dynamic>? response =
        await WebServicesHelper().createUserDeal("$token", "$userId", param);
    hideProgress();

    try {
      if (response != null) {
        if (response["errorCode"] != null &&
            response["errorCode"] == "ERR2302") {
          HelpWeight()
              .creatDealPopupError("Offer Already used on this Device.");
          return;
        }
        HelpMethod().customPrint('createUserDeal DATA:: ${response}');
        if (response != null) {
          HelpWeight().flutterCustomToast('Offer created successfully!');

          if (response['url'] != null && response['url'] != '') {
            String url = response['url'].toString();
            if (url.contains("{clickid}")) {
              url = url.replaceAll("{clickid}", response['userDealId']);
            }
            HelpMethod().customPrint('createUserDeal DATA:: ${url}');
            HelpMethod.launchURLApp(url);

            await getAdvertisersDeals();
            getUserDeals();
          } else {
            HelpWeight().flutterCustomToast('URL not found!');
          }
        }
      } else {
        //Fluttertoast.showToast(msg: 'Request already placed!');
        HelpWeight().flutterCustomToast('Request already placed!');
      }
    } catch (e) {
      HelpWeight().flutterCustomToast('Something went wrong!');
    }
  }

  //offerwall user deals api
  Future<void> getUserDeals() async {
    emit(state.copyWith(userDealHistory: null));
    prefs = await SharedPreferences.getInstance();
    String? token = prefs!.getString("token");
    String? userId = prefs!.getString("userId");

    Map<String, dynamic>? response =
        await WebServicesHelper().getUserDeals("$token", "$userId");

    if (response != null) {
      UserdealModel? userDealHistory = UserdealModel.fromJson(response);
      emit(state.copyWith(userDealHistory: userDealHistory));

      HelpMethod().customPrint('response getUserDeals code STARTING...');
    } else {
      HelpMethod().customPrint('response getUserDeals ERROR');
      HelpWeight().flutterCustomToast('Something went wrong History!');
    }
  }

  Future<String> validateMobile(String value) async {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      HelpWeight().flutterCustomToast('Please enter mobile number');
      return '0';
    } else if (value.length != 10) {
      HelpWeight().flutterCustomToast('Mobile number length must be 10');
      return '0';
    } else if (!regExp.hasMatch(value)) {
      HelpWeight().flutterCustomToast('Please enter valid mobile number');
      return '0';
    } else {
      if (value.contains(" ")) {
        HelpWeight().flutterCustomToast('Please remove space');
        return '0';
      } else {
        //   only_number.value = value;
        return '1';
      }
    }
  }

  //
  Future<void> getSettingPublicM() async {
    HelpMethod().customPrint('getSettingPublicM: STARTED');
    Map<String, dynamic>? response =
        await WebServicesHelper().getSettingPublic();
    if (response != null) {
      PublicSetting publicSettingModel = PublicSetting.fromJson(response);
      emit(state.copyWith(publicSetting: publicSettingModel));

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(
          "whatsappMobile", "${publicSettingModel.support!.whatsappMobile}");
      print(
          " call getSetting whatsappMobile ${publicSettingModel.support!.whatsappMobile}");
    } else {
      // Fluttertoast.showToast(msg: "ERROR!");
    }
  }

  getAppversion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
    code = packageInfo.buildNumber;
    packageName = packageInfo.packageName;
  }


  addMobileNumber(String) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
    code = packageInfo.buildNumber;
    packageName = packageInfo.packageName;
  }
}
