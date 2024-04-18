
import 'package:flutter/material.dart';
import 'package:cubit_project/view/game_zop/game_zop_list.dart';

import '../../view/SplashScreen.dart';
import '../../view/dashboard/dashboard.dart';
import '../../view/login/login_screen.dart';
import '../../view/login/otp_screen.dart';
import '../../view/reword/reword.dart';
import '../../view/wallet/transaction.dart';


class Routes {
  // Route name constants
  static const String splash = '/';
  static const String login = 'login';
  static const String otpScreen = 'OtpScreen';
  static const String dashBoard = 'DashBoard';
  static const String reword = 'reword';
  static const String transaction = 'transaction';
  static const String gameZopList = 'GameZopList';

  /// The map used to define our routes, needs to be supplied to [MaterialApp]
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      Routes.splash: (context) =>  const Splash(),
      Routes.login: (context) =>  LoginScreen(),
      //Routes.otpScreen: (context) =>  OtpScreen(),
      Routes.dashBoard: (context) =>  const DashBoard(),
      Routes.reword: (context) =>  const Reword(),
      Routes.transaction: (context) =>   const TransactionHistory(),
     // Routes.gameZopList: (context) =>   const GameZopList(),

    };
  }
}
