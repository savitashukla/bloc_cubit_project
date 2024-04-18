import 'dart:io';

import 'package:cubit_project/utils/AppsflyerMain.dart';
import 'package:cubit_project/utils/firebase_event.dart';
import 'package:cubit_project/utils/fresh_chat.dart';
import 'package:cubit_project/utils/help_method.dart';
import 'package:cubit_project/view_model/cubit/gamezop_game_list/gamezop_event_list_cubit.dart';
import 'package:cubit_project/view_model/cubit/loot_box_cubit/loot_box_cubit.dart';
import 'package:cubit_project/view_model/cubit/wallet/wallet_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/app.dart';
import 'data/service/LocalNotification.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  if (Platform.isIOS) {
    Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyCFIM2nago1xrYULh1XlsJMO6IDGxs-j4k",
            appId: "1:123245046616:ios:b7bc675575d879566c532d",
            messagingSenderId: "123245046616",
            projectId: "gmng-1524f"));
  } else {
    Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyC35Gkip0LkV20Y4VWLTatTT5okySMGRxY",
            appId: "1:123245046616:android:dc48d57fdb1904d56c532d",
            messagingSenderId: "123245046616",
            projectId: "gmng-1524f"));
  }

  await Firebase.initializeApp();
  AppsflyerMain.initCall();
  freshChatInitMethod();
  Map<String, Object> map = new Map<String, Object>();
  map["App_Type"] = "lootBox";
  AppsflyerMain.logEventAf("af_complete_lootbox", map);
  FirebaseEvent().firebaseEvent("af_complete_lootbox", map);

  LocalNotificationService.initialize();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);

  //SentryFlutter Code for Error Detection
  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://6ac71903d38b45dfb2dfc7829d5ffd04@o4505520604643328.ingest.sentry.io/4505525122105344'; //LIVE
      //options.dsn = 'https://d084463f6478432bab3c9b3c276410f0@o4505520604643328.ingest.sentry.io/4505549739196416'; //STAGING
      //options.dsn = 'https://a952bcbc1d574a69b2617894b73dd151@o4505327396257792.ingest.sentry.io/4505327402680320'; //TEST1
      // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
      // We recommend adjusting this value in production.
      options.tracesSampleRate = 1.0;
    },
    appRunner: () => runApp(const MyApp()),
  );
}

Future<void> backgroundHandler(RemoteMessage message) async {
  Map<dynamic, dynamic> bodyCal;
  bodyCal = message.data;
  HelpMethod().customPrint(
      "backgroundHandler ============================================>>>>>>>>>$bodyCal");
  //LocalNotificationService.showNotificationWithDefaultSound("");

  try {
    if (bodyCal["type"] != null &&
        bodyCal["type"] == "instantCashAddedFromGamePlay") {
      print("instantCashAdded true ${bodyCal["type"]}");
    }
  } catch (A) {}

  try {
    String body_values = bodyCal["body"];
    String source = bodyCal["source"];

    if (source.compareTo("freshchat_user") == 0) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("channel_id", "${bodyCal["channel_id"]}");
      prefs.setString("source", "${source}");
      HelpMethod().customPrint(
          "backgroundHandler call============================================>>>>>>>>>$body_values");
      LocalNotificationService.showNotificationWithDefaultSound(body_values);
    }
  } catch (E) {

  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LootBoxCubit>(
          create: (context) => LootBoxCubit()..getSettingPublicM(),
        ),
        BlocProvider<WalletCubit>(
          create: (context) => WalletCubit(),
        ),
        BlocProvider<GamezopEventListCubit>(
            create: (context) => GamezopEventListCubit()),
      ],
      child: const AppWidget(),
    );
  }
}
