import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freshchat_sdk/freshchat_sdk.dart';
import 'package:freshchat_sdk/freshchat_user.dart';
import 'package:cubit_project/model/gameEventList/GameEventList.dart';
import 'package:cubit_project/model/gameEventList/gameEvnetListHistory.dart';
import 'package:cubit_project/model/profile_data.dart';
import 'package:cubit_project/utils/help_method.dart';
import 'package:cubit_project/view_model/cubit/gamezop_game_list/gamezop_event_list_equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/service/web_services_helper.dart';
import '../../../model/gameEventList/GameAccordingBannerModel.dart';
import '../../../model/gameEventList/tamasha_eventlist.dart';
import '../../../utils/helper_progressbar.dart';
import '../../../utils/weight/help_weight.dart';

class GamezopEventListCubit extends Cubit<GamezopEventListEquatable> {
  SharedPreferences? prefs;

  String? token;
  String? userId;

  GamezopEventListCubit()
      : super(GamezopEventListEquatable.init(
            checkTurnOffGameZopEvent: true,
            colorPrimaryGameZopEvent: const Color(0xff46558c),
            colorwhiteGameZopEvent: const Color(0xffffffff),
            currentPage: 0,
            totalLimit: 0,
            isProcessing: false));

  void init() async {
    prefs = await SharedPreferences.getInstance();
    token = prefs!.getString("token");
    userId = prefs!.getString("userId");
    /* getGameEventList();

    getUnityHistoryOnly("645e040cf8c57fe56f9d6c24");*/
    getProfileData();
  }

  void callEventList() {
    emit(state.copyWith(
        checkTurnOffGameZopEvent: true,
        colorPrimaryGameZopEvent: const Color(0xFF46558C),
        colorwhiteGameZopEvent: const Color(0xFFffffff)));
  }

  void historyCall() {
    emit(state.copyWith(
        checkTurnOffGameZopEvent: false,
        colorwhiteGameZopEvent: const Color(0xFF46558C),
        colorPrimaryGameZopEvent: const Color(0xFFffffff)));
  }

  void paginationCurrentPage(var currentPageCount) {
    emit(state.copyWith(currentPage: currentPageCount));
  }

  Future<void> setVaNull() async {
    emit(state.copyWith(gameEventListR: null));
  }

  Future<void> getGameEventList(String gameId) async {
    emit(state.copyWith(gameEventListR: null));

    if (token == null) {
      prefs = await SharedPreferences.getInstance();
      token = prefs!.getString("token");
      userId = prefs!.getString("userId");
    }
    Map<String, dynamic>? response = await WebServicesHelper()
        .getUnitEventList(token!, gameId, "", "", userId!, "active");
    if (response != null) {
      GameEventList unityEventList = GameEventList.fromJson(response);
      emit(state.copyWith(gameEventListR: unityEventList));
    } else {
      HelpWeight().flutterCustomToast("Some Error");
    }
  }


  Future<void> getGameEventListCricket(String gameId) async {
    emit(state.copyWith(gameEventListRCricket: null));

    if (token == null) {
      prefs = await SharedPreferences.getInstance();
      token = prefs!.getString("token");
      userId = prefs!.getString("userId");
    }
    Map<String, dynamic>? response = await WebServicesHelper()
        .getUnitEventList(token!, gameId, "", "", userId!, "active");
    if (response != null) {
      GameEventList unityEventList = GameEventList.fromJson(response);
      emit(state.copyWith(gameEventListRCricket: unityEventList));
    } else {
      HelpWeight().flutterCustomToast("Some Error");
    }
  }

  Future<void> getProfileData() async {
    if (userId == null) {
      prefs = await SharedPreferences.getInstance();
      token = prefs!.getString("token");
      userId = prefs!.getString("userId");
    }
    Map<String, dynamic>? response =
        await WebServicesHelper().getProfileData(token!, userId!);
    if (response != null) {
      ProfileDataR profileDataR = ProfileDataR.fromJson(response);

      emit(state.copyWith(profileDataC: profileDataR));
    } else {
      HelpWeight().flutterCustomToast("Some Error");
    }
  }



  Future<void> SetFreshchatUser() async {
    try {
      FreshchatUser freshchatUser = await Freshchat.getUser;
      if (state.profileDataC!.username != null) {
        freshchatUser.setFirstName("${state.profileDataC!.username}");
      }

      if (state.profileDataC!.name != null &&
          state.profileDataC!.name!.last != null) {
        freshchatUser.setLastName("${state.profileDataC!.name!.last}");
      }
      if ( state.profileDataC!.email != null &&
          state.profileDataC!.email!.address != null) {
        freshchatUser.setEmail("${state.profileDataC!.email!.address}");
      }
      if (state.profileDataC!.mobile != null &&
          state.profileDataC!.mobile!.number != null) {
        freshchatUser.setPhone(
            "+91", state.profileDataC!.mobile!.number.toString());
      }
      Freshchat.setUser(freshchatUser);
    } catch (e) {}
  }

  Future<void> getUnityHistoryOnly(String gameId) async {
    if (token == null) {
      prefs = await SharedPreferences.getInstance();
      token = prefs!.getString("token");
      userId = prefs!.getString("userId");
    }

    if (state.currentPage < 1) {
      emit(state.copyWith(gameEventListHistoryR: [], totalLimit: 0));
    }

    showProgress();
    Map<String, dynamic>? response = await WebServicesHelper()
        .getUnityHistory(token!, userId!, gameId, 10, state.currentPage);
    hideProgress();
    if (response != null) {
      GameEventListHistory unityEventList =
          GameEventListHistory.fromJson(response);

      List<HistoryData>? listHistoryData = <HistoryData>[];

      listHistoryData = unityEventList!.data;

      if (state!.gameEventListHistoryR != null &&
          state!.gameEventListHistoryR!.length > 0) {
        print(
            "call history data ${state!.gameEventListHistoryR ?? state!.gameEventListHistoryR!.length}");

        for (int index = 0;
            state.gameEventListHistoryR!.length > index;
            index++) {
          listHistoryData!.add(state!.gameEventListHistoryR![index]);
        }
        ;

        //   listHistoryData!.add(new HistoryData.fromJson(v));
        //  listHistoryData!.addAll(state!.gameEventListHistoryR);
      }

      emit(state.copyWith(
          gameEventListHistoryR: listHistoryData,
          totalLimit: unityEventList.pagination!.total));
    } else {
      HelpWeight().flutterCustomToast("Some Error");
    }
  }

  Future<void> getTamashaEventList() async {
    emit(state.copyWith(tamashaEventListR: null));
    prefs = await SharedPreferences.getInstance();

    token = prefs!.getString("token");

    Map<String, dynamic>? response =
        await WebServicesHelper().getTamashaEventList(token!);
    if (response != null) {
      TamashaEventListD? tamashaEventListV =
          TamashaEventListD.fromJson(response);
      List<TamashaEventList>? listData = <TamashaEventList>[];

      listData = tamashaEventListV!.data;

      /*  if (state!.tamashaEventListR!.isNotEmpty) {
   //     listData!.addAll(state!.tamashaEventListR);
      }*/

      emit(state!.copyWith(tamashaEventListR: listData));
    } else {
      HelpWeight().flutterCustomToast("Some Error");
    }
  }

  Future<void> getBanner(String game_id) async {
    HelpMethod().customPrint('Tamasha Banner: $game_id');
    emit(state.copyWith(bannerModelR: null));
    prefs = await SharedPreferences.getInstance();
    token = prefs!.getString("token");

    Map<String, dynamic>? response_str =
        await WebServicesHelper().getBannerViaGameId("$token", game_id);
    if (response_str != null) {
      BannerModelR bannerModelRV = BannerModelR.fromJson(response_str);
      emit(state.copyWith(bannerModelR: bannerModelRV));

      // HelpMethod().customPrint('Unity Banner: ${bannerModelRV.data.length}');
    }
  }
}
