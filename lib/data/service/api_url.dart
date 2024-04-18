class ApiUrl{
  //stage
   /*static const apiURL = "https://stg.gmng.in/api/";
  static const downloadUrl = "https://stg.gmng.in/";*/
  //live
  static const apiURL = "https://api.gmng.in/";
  static const downloadUrl = "https://api.gmng.in/";

  bool isPlayStore = false;
  bool isbb = false;
  bool is_debug_mode = true;

  static var status = "active";



  //testing
  static const String invoid_encription_key = "Fm6bkT8mX2m95Ba";
  static const String invoid_Auth_Key = "3345016e-74fd-454f-b98c-5b5afcf8cb3c";

  static const String freshchat_domain = "msdk.in.freshchat.com";
  static const String freshchat_appid = "c824a00d-7c07-47bd-b7d0-06899c41c19f";
  static const String freshchat_appkey = "840afe76-540b-4723-97f9-facf38075edb";

  //testing Ct Account
  static const String clevertap_account_id = "TEST-5WK-85W-K56Z";
  static const String clevertap_token = "TEST-05b-305";

  //appsflyers
  static const String APPSFLYERS_KEY = "zFR25zR86SjqtBzRJKAUhJ";

  //Rozerpay
  // staging
  //static const String ROZERPAY_KEY = "rzp_test_bKghF3P0aA8nzz";
  //live
  static const String ROZERPAY_KEY = "rzp_live_EseohIFyL8Jbie";
  static const String ROZERPAY_SECRET = "WpC9nYCKEasaTmRNa7Gf4D3q";
  //cashfree key
  static const String CASHFREE_SECRET =
      "TEST5c024afe5d0a7159abe16e2ba5528e7944d6b031";
  static const String client_ID = "2941898caf4124a4904ae9cfe3981492";

  static const String DATA = "DATA";
  static const String DATA1 = "DATA1";
  static const String DATA2 = "DATA2";
  static const String DATA3 = "DATA3";

  static const API_METHOD_TYPE_GET = "GET";
  static const API_METHOD_TYPE_POST = "POST";

  static const DOCUMENT_TYPE_DL = "drivingLicense";
  static const DOCUMENT_TYPE_PANCARD = "pan";
  static const DOCUMENT_TYPE_PASSPORT = "passport";
  static const DOCUMENT_TYPE_AADHAR_CARD = "aadhar_card";
  static const DOCUMENT_SUBTYPE_FRONT = "front";
  static const DOCUMENT_SUBTYPE_BACK = "back";

  static const URL_CMS_HOW_TO_PLAY = "https://gmng.pro/how-to-play/";

  // static const URL_CMS_PLAY_POCKER = "https://gmng.pro/how-to-play-poker/";
  static const URL_CMS_PLAY_POCKER = "https://gmng.pro/p0876645";
  static const URL_CMS_PRIVCY_POLICY = "https://gmng.pro/privacy-policy/";
  static const URL_CMS_T_C = "https://gmng.pro/terms-conditions/";

  static const API_URL_LOGIN = "${apiURL}user/login";
  static const API_URL_OTP_VERIFY = "${apiURL}user/verifyOTP";
  static const API_URL_OTP_RESEND = "${apiURL}user/resendOTP";

  static const API_URL_BANNER = "${apiURL}banner";
  var API_URL_GAME = "${apiURL}game?status=$status";

  var API_URL_GAME_ESport =
      "${apiURL}game?status=$status&gameCategoryId=62de6baad6fc1704f21b0a88";

  //  game id  remove
/*
  var API_URL_GAME_ESport =
      API_URL + "game?status=$status";*/


  var API_URL_USER_WALLATE = "${apiURL}user/%s/wallet";
  var API_URL_GET_USER_DETAILS = "${apiURL}user/%s";
  var API_URL_HOME_PAGE =
      "${apiURL}dashboard/app/home-page"; //?expand=banners.gameId
  var API_URL_IN_GAME_CHECK = "${apiURL}user/";
  var API_URL_JOINED_DETAILS = "${apiURL}user/";
  var API_URL_PRE_JOIN_EVENT = "${apiURL}event/";
  var API_URL_JOIN_EVENT = "${apiURL}event/";
  var API_URL_APP_SETTING = "${apiURL}setting";
  var Version_Update_Api = apiURL;

  var API_URL_FACEBOOK_EVENT = "${apiURL}app/event";

  var API_URL_STORE = "${apiURL}store/item?gameId=";
  var API_URL_BUY_STORE = "${apiURL}store/purchase";


  var API_URL_UNITY_HIS = "$apiURL/event/rmg/history?appTypes=lootBox&opponents=true&gameId=";

  var API_URL_USER = "${apiURL}user/";

  //ballebaazi implimentation
  var API_URL_BALLBAZI_LOGIN = "${apiURL}user/%s/ballebaazi/auth";

  var API_USER_PROFILE_SUMMARY = "${apiURL}user/%s/event/summary";

  //leaderBoarApi
  var API_LEADERBOARD_LIST = "${apiURL}leaderboard/winning/event?type=";

  //clan
  var API_CLAN_LIST = "${apiURL}clan";
  var API_JOINED_CLAN_LIST = "${apiURL}user/";
  var API_REWARDS = "${apiURL}leaderboard/referral?type=";

  //pocket 52
  var API_URL_POCKET_LOGIN = "${apiURL}user/%s/pocket52/auth";

  // var API_URL_INVOID_AADAHAR="https://api.overwatch.stg.bureau.id/v1/suppliers/init-doc-fetch";
  var API_URL_INVOID_AADAHAR =
      "https://api.overwatch.bureau.id/v1/suppliers/init-doc-fetch";
  var INVOID_CALLBACK_URL = "${apiURL}bureau/callback/";
  var INVOID_CALLBACK_CANCEL_URL = "${apiURL}bureau/cancel/";
  var INVOID_AUTH_KEY = "d9e90bda-e889-43b6-b964-dfebc4f02b9c";

  //live
  var INVOID_USERNAME = 'accebaac-aaa4-4598-88a3-7d5c90014a5a';
  var INVOID_PASSWORD = '2c3d7d22-c612-4afc-82e6-e1b8dc7b80a2';

  var API_RAZOREPAY_CREATE_ORDER = "${apiURL}razorpay/order";
  var API_RAZOREPAY_PAYMENT_SUCCESS = "${apiURL}razorpay/payment-success";
  var API_URL_FTD = apiURL;

  //CountryRestrictions
  var API_URL_CountryRestrictions = "${apiURL}setting/country-restrictions";
  var setting_public = "${apiURL}setting/public";

  //Rummy hash generation
  static const API_URL_HASH_RUMMY = "${apiURL}grid-logic/auth";
  static const API_URL_GUPSHUP_OPT_IN = "${apiURL}user/opt-in";



  static const API_URL_CHASHFREE = "${apiURL}cashfree/order-cf-token";
  static const API_URL_VIPlevel = "${apiURL}vip-level?status=active";

  // tamash web url
  static const API_URL_WEBTAMASHA = "$apiURL/tamasha/ludo/webview/";
  static const API_URL_TAMASHA_EVENT_LIST = "${apiURL}tamasha/ludo/contest?appTypes=lootBox";

  var MYTEAM11_BB = "${apiURL}user/%s/myteam11/auth";
  var TRAGO_BB = "$apiURL/user/%s/trago/auth";
  var FAVORITE_GAME_LIST = "$apiURL/user/%s/favorite-game?expand=gameId";
  var FAVORITE_GAME = "$apiURL/user/%s/favorite-game";
}
