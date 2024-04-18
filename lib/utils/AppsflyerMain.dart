import 'dart:convert';
import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/service/api_url.dart';
import 'help_method.dart';

class AppsflyerMain {
  static var page_name = "";
  static var event_id_call = "";
  static var referral_code_af = "";
  var page_name11 = "";
  static var splashDelayRef = 5;
  static var  onChangesV = false;
static  AppsflyerSdk? appsflyerSdk;
//  final getxStorages = GetStorage();

static  var mediaSource ,
      campaign ,
      CampaignName ,
      CampaignType = "",
      CampaignId = "",
      is_deferred = false,
      af_adset = "",
      af_adset_id = "",
      af_sub1 = "",
      page = "22",
      id_Call = "",
      link = "";
static initCall()
   {

     HelpMethod().customPrint("onInstallConversionData res: check ony ");
     final AppsFlyerOptions options = AppsFlyerOptions(
         afDevKey: ApiUrl.APPSFLYERS_KEY, showDebug: true, appId: "123456789");
     //apps id required or iod only
     appsflyerSdk = AppsflyerSdk(options);

     HelpMethod().customPrint("onInstallConversionData res: check ony ");

     appsflyerSdk!.initSdk(
         registerConversionDataCallback: true,
         registerOnAppOpenAttributionCallback: true,
         registerOnDeepLinkingCallback: true);

     // Fluttertoast.showToast(msg: "onInit state Call");


     appsflyerSdk!.onInstallConversionData((res) async {
       HelpMethod().customPrint("onInstallConversionData res: $res");

       // Fluttertoast.showToast(msg: "install ${res.toString()}");
       SharedPreferences prefs = await SharedPreferences.getInstance();

       //   prefs.setString("mediaSource", res.toString());
       // Utils().customPrint("SharedPreferencess ${prefs.getString("mediaSource")}");
       // Fluttertoast.showToast(msg: "install ${prefs.getString("mediaSource")}");

       final pdfText = await json.decode(json.encode(res));

       try {
         prefs.setString("afAdSet", pdfText["payload"]["install_time"] ?? "");
       } catch (E) {}

       try {
         prefs.setString(
             "mediaSource", pdfText["payload"]["media_source"] ?? "");
       } catch (E) {}

       try {
         if (referral_code_af != null ||
             referral_code_af.isNotEmpty) {
           referral_code_af = pdfText["payload"]["referral_code"];
           print("referral_code${pdfText["payload"]["referral_code"]}");
         }
       } catch (E) {}

       try {
         prefs.setString("campaign", pdfText["payload"]["campaign"] ?? "");
         prefs.setString("campaignId", pdfText["payload"]["CampaignID"] ?? "");
         prefs.setString("appsFlyerId", pdfText["payload"]["af_web_dp"] ?? "");
         prefs.setString("campaignName", pdfText["payload"]["campaign"] ?? "");
         prefs.setString(
             "campaignType", pdfText["payload"]["af_android_url"] ?? "");
         prefs.setString("afAdSetId", pdfText["payload"]["af_adset"] ?? "");
         prefs.setString("afSub", pdfText["payload"]["af_sub2"] ?? "");
         prefs.setBool(
             "isDeferred", pdfText["payload"]["is_retargeting"] ?? false);
       } catch (E) {}
       //Fluttertoast.showToast(msg: "install ${pdfText["payload"]["install_time"]}");
     });

     appsflyerSdk!.onAppOpenAttribution((res) {

       //  Fluttertoast.showToast(msg: "onAppOpenAttribution ${res.toString()}");

       HelpMethod().customPrint("onAppOpenAttribution --->res: $res");
     });

     appsflyerSdk!.onDeepLinking((DeepLinkResult dp) async {

       HelpMethod().customPrint("onDeepLinking res: $dp");
       //  Fluttertoast.showToast(msg: "msg${dp.toString()}");
       switch (dp.status) {
         case Status.FOUND:
         //    Fluttertoast.showToast(msg: "deeaplink data=>> ${dp.deepLink?.toString()}");

           SharedPreferences prefs = await SharedPreferences.getInstance();
           HelpMethod().customPrint("deeplink data=>>${dp.deepLink}");

           try {
             if (referral_code_af != null ||
                 referral_code_af.isNotEmpty) {
               referral_code_af = dp.deepLink!.getStringValue("referral_code")!;
               print(
                   "referral_code depp${dp.deepLink!.getStringValue("referral_code")}  ${referral_code_af}");
             }
           } catch (E) {}

           try {
             page_name = dp.deepLink?.getStringValue("page") ?? "";

             HelpMethod().customPrint("Apps exception call ${page_name}");

             event_id_call = dp.deepLink?.getStringValue("id") ?? "";
             id_Call = dp.deepLink?.getStringValue("id") ?? "";
             HelpMethod().customPrint("Apps exception call ${id_Call}");

             page = dp.deepLink?.getStringValue("page") ?? "";
             prefs.setString("page", page);
             // prefs.setString("page", page ?? "");
             prefs.setString("id_Call", id_Call ?? "");
           } on Exception catch (e) {
             HelpMethod().customPrint("Apps exception call $e");
           }

           mediaSource = dp.deepLink!.getStringValue("media_source");
           campaign = dp.deepLink?.getStringValue("campaign");

           prefs.setString("mediaSource", mediaSource ?? "");
           prefs.setString("campaign", campaign ?? "");
           try {
             if (dp.deepLink?.getStringValue("CampaignID") != null) {
               CampaignId =
                   dp.deepLink?.getStringValue("CampaignID") ?? "";
               prefs.setString("appsFlyerId", CampaignId ?? "");
               prefs.setString("campaignId", CampaignId ?? "");
             } else {
               CampaignId =
                   dp.deepLink?.getStringValue("campaign_id") ?? "";
               prefs.setString("appsFlyerId", CampaignId ?? "");
               prefs.setString("campaignId", CampaignId ?? "");
             }
           } catch (E) {}
           HelpMethod().customPrint("msg${prefs.getString("campaignId")}");
           //Fluttertoast.showToast(msg: "msg${prefs.getString("campaignId")}");
           HelpMethod().customPrint(
               "storeData data app${prefs.getString("mediaSource")}");
           HelpMethod().customPrint("campaign ${campaign}");

           CampaignName =
               dp.deepLink?.getStringValue("CampaignName") ?? "";

           try {
             prefs.setString(
                 "campaignName",
                 CampaignName == null ||
                     CampaignName.compareTo("") == 0
                     ? campaign
                     : CampaignName);
           } catch (E) {}
           CampaignType = dp.deepLink!.getStringValue("CampaignType") ?? "";

           af_adset_id = dp.deepLink?.getStringValue("af_adset") ?? "";
           af_sub1 = dp.deepLink?.getStringValue("af_sub1") ?? "";
           af_adset = dp.deepLink?.getStringValue("af_adset") ?? "";
           link = dp.deepLink?.getStringValue("link") ?? "";

           prefs.setString("campaignType", CampaignType ?? "");
           prefs.setString("afAdSet", af_adset ?? "");
           prefs.setString("afAdSetId", af_adset_id ?? "");
           prefs.setString("afSub", af_sub1 ?? "");
           //pid added
           HelpMethod().customPrint('str >>> ${link}');
           try {
             if (link != null && link != '') {
               if (link.contains('pid')) {
                 var str = link.split('pid=');
                 HelpMethod().customPrint('str >>> ${str[0]}');
                 HelpMethod().customPrint('str >>> ${str[1].split('&')[0]}');
                 prefs.setString("pid",
                     str[1].split('&')[0] ?? ""); //pid added in sharedPref
               }
             }
           } catch (e) {
             HelpMethod().customPrint('str >>> error ${e.toString()}');
           }

           try {
             if (dp.deepLink!.isDeferred != null) {
               is_deferred = (dp.deepLink!.isDeferred ?? false)!;
             }
           } catch (E) {}

           is_deferred =
           (dp.deepLink!.isDeferred ?? false)!;
           prefs.setBool("isDeferred", is_deferred);
           HelpMethod().customPrint("DEEPLINGING VALUES========");
           break;
         case Status.NOT_FOUND:
           HelpMethod().customPrint("deep link not found");
           //  Fluttertoast.showToast(msg: "deep link not found ${dp.deepLink?.toString()}");

           SharedPreferences prefs = await SharedPreferences.getInstance();
           prefs.setString("page", "home");
           prefs.setString("id_Call", "");
           break;
         case Status.ERROR:
           HelpMethod().customPrint("deep link error: ${dp.error}");
           //   Fluttertoast.showToast(msg: "deep link error: ${dp.deepLink?.toString()}");

           SharedPreferences prefs = await SharedPreferences.getInstance();
           prefs.setString("page", "home");
           prefs.setString("id_Call", "");
           break;
         case Status.PARSE_ERROR:
         //  Fluttertoast.showToast(msg: "deep link error: ${Status.PARSE_ERROR}");

           SharedPreferences prefs = await SharedPreferences.getInstance();

           prefs.setString("page", "home");
           prefs.setString("id_Call", "");
           HelpMethod().customPrint("deep link status parsing error");
           break;
       }
     });
   }

  static logEventAf(String eventName, Map eventValues) async {
    bool? result;
    try {
      await appsflyerSdk!.logEvent(eventName, eventValues);
    } on Exception {}
    HelpMethod().customPrint("Result logEvent: $result");
  }

  Future<String?> getAppsFlyerID() {
    print("getAppsFlyerID");
    return appsflyerSdk!.getAppsFlyerUID();
  }
}
