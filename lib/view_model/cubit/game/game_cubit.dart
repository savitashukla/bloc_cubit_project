import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cubit_project/model/game/game_model.dart';
import 'package:cubit_project/utils/help_method.dart';
import 'package:cubit_project/view_model/cubit/game/game_equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/service/web_services_helper.dart';
import '../../../utils/helper_progressbar.dart';
import '../../../utils/logger_utils.dart';
import '../../../utils/weight/help_weight.dart';
import '../../../view/myteam11/myteam11_screen.dart';

class GameCubit extends Cubit<GameEquatable> {
  SharedPreferences? prefs;

  String? token;

  String? userId;

  GameCubit() : super(GameEquatable.init(isProcessing: false));

  void init() async {
    prefs = await SharedPreferences.getInstance();
    token = prefs!.getString("token");
    userId = prefs!.getString("userId");
    getHomePage();
  }

  Future<void> getHomePage() async {
    if (token == null) {
      prefs = await SharedPreferences.getInstance();
      token = prefs!.getString("token");
    }

    HelpMethod().customPrint("check create this  class");
    Map<String, dynamic>? response =
        await WebServicesHelper().getHomePage(token!);
    List<Games>? gameListShow = <Games>[];

    if (response != null) {
      GameModel? gameModelResV = GameModel.fromJson(response);
      emit(state.copyWith(gameModelRes: gameModelResV));

      if (gameModelResV.gameCategories != null &&
          gameModelResV.gameCategories!.isNotEmpty) {
        for (int i = 0; i < gameModelResV.gameCategories!.length; i++) {
          for (int j = 0;
              j < gameModelResV.gameCategories![i].games!.length;
              j++) {
            Games game = gameModelResV.gameCategories![i].games![j];

            if (game.name == "21 Card" ||
                game.name == "Fruit Chef" ||
                game.name == "Guns & Bottles") {
              gameListShow.add(game);
            }
            //Utils().customPrint('Home page ui ${game.name}');
            /* if (game.name == "Cricket" ||
                game.name == "CARROM" ||
                game.name == "GMNG Pool" ||
                game.name == "FANTASY" ||
                game.name == "Skill Ludo") {
              gameListShow.add(game);
            }*/
           // gameListShow.add(game);
            /*if (game.name == "FANTASY") {
              gameListShow.add(game);
            }*/
          }
        }
      }

      emit(state.copyWith(gameList: gameListShow));
      print("call here values ${gameListShow.length}");
      print("call here values state List ${state.gameList!.length}");
    }
  }

  Future<bool?> getLoginTeam11BB(BuildContext context, String GameId) async {
    showProgress();

    // SharedPreferences     prefs = await SharedPreferences.getInstance();
    // token = prefs.getString("token");
    // user_id = prefs.getString("user_id");

    Map<String, dynamic> paramseData = {"gameId": GameId};

    Map<String, dynamic>? responsestr =
        await WebServicesHelper().getTeam11BB("$token", "$userId", paramseData);
    if (responsestr != null) {
      hideProgress();

      if (responsestr["isThirdPartyLimitExhausted"] != null &&
          responsestr["isThirdPartyLimitExhausted"]) {
        HelpWeight.alertLimitExhausted();
        return true;
      } else {
        if (responsestr["url"] != null) {
          Navigator.push(
            navigatorKey.currentState!.context,
            MaterialPageRoute(
              builder: (BuildContext context) =>
                  MyTeam11Screen(responsestr["url"]),
            ),
          );
          // Get.toNamed(Routes.ballbaziGame, arguments: ballbaziModel.webViewUrl);
        } else {
          // Fluttertoast.showToast(msg: "Some Error");
        }
      }
    } else {
      hideProgress();
      HelpWeight().flutterCustomToast("Some Thing Went Wrong");
    }
  }
}
