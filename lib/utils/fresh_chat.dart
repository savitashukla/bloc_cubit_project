import 'package:freshchat_sdk/freshchat_sdk.dart';

import '../data/service/api_url.dart';

freshChatInitMethod()
{
  Freshchat.init(ApiUrl.freshchat_appid,
      ApiUrl.freshchat_appkey,ApiUrl.freshchat_domain);
}