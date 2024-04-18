import 'package:equatable/equatable.dart';
import 'package:cubit_project/model/gameEventList/GameAccordingBannerModel.dart';
import 'package:cubit_project/model/gameEventList/GameEventList.dart';
import 'package:cubit_project/model/gameEventList/tamasha_eventlist.dart';

import '../../../model/gameEventList/gameEvnetListHistory.dart';
import '../../../model/profile_data.dart';

class GamezopEventListEquatable extends Equatable {
  final bool isProcessing;

  GameEventList? gameEventListR;
  GameEventList? gameEventListRCricket;
  List<HistoryData>? gameEventListHistoryR;

  bool checkTurnOffGameZopEvent;
  var colorPrimaryGameZopEvent;
  var colorwhiteGameZopEvent;

  var currentPage;
  var totalLimit;

  List<TamashaEventList>? tamashaEventListR;
  ProfileDataR? profileDataC;
  BannerModelR? bannerModelR;

  GamezopEventListEquatable({
    required this.isProcessing,
    this.gameEventListRCricket,
    this. gameEventListR,
    this.tamashaEventListR,
    this.gameEventListHistoryR,
    this.profileDataC,
    this.bannerModelR,
    required this.checkTurnOffGameZopEvent,
    required this.colorPrimaryGameZopEvent,
    required this.colorwhiteGameZopEvent,
    required this.totalLimit,
    required this.currentPage
  });

  GamezopEventListEquatable.init({
    required this.isProcessing,
    this.gameEventListRCricket,
    this.gameEventListR,
    this.tamashaEventListR,
    this.gameEventListHistoryR,
    this.profileDataC,
    this.bannerModelR,
    required this.checkTurnOffGameZopEvent,
    required this.colorPrimaryGameZopEvent,
    required this.colorwhiteGameZopEvent,
    required this.totalLimit,
    required this.currentPage
  });

  GamezopEventListEquatable copyWith({
    bool? isProcessing,
    GameEventList? gameEventListR,
    GameEventList? gameEventListRCricket,
    List<TamashaEventList>? tamashaEventListR,
   List <HistoryData>? gameEventListHistoryR,
    ProfileDataR? profileDataC,
    BannerModelR? bannerModelR,
    bool? checkTurnOffGameZopEvent,
    var colorPrimaryGameZopEvent,
    var colorwhiteGameZopEvent,

    var currentPage,
    var totalLimit,
  }) {
    return GamezopEventListEquatable(
        isProcessing: isProcessing ?? this.isProcessing,
        gameEventListR: gameEventListR ?? this.gameEventListR,
        gameEventListRCricket: gameEventListRCricket ?? this.gameEventListRCricket,
        profileDataC: profileDataC ?? this.profileDataC,
        bannerModelR: bannerModelR ?? this.bannerModelR,
        tamashaEventListR: tamashaEventListR ?? this.tamashaEventListR,
        gameEventListHistoryR:
            gameEventListHistoryR ?? this.gameEventListHistoryR,
        checkTurnOffGameZopEvent:
            checkTurnOffGameZopEvent ?? this.checkTurnOffGameZopEvent,
        colorPrimaryGameZopEvent:
            colorPrimaryGameZopEvent ?? this.colorPrimaryGameZopEvent,
        colorwhiteGameZopEvent: colorwhiteGameZopEvent ?? this.colorwhiteGameZopEvent,
        totalLimit: totalLimit ?? this.totalLimit,
        currentPage: currentPage ?? this.currentPage


    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        isProcessing,
        gameEventListR,
    tamashaEventListR,
        checkTurnOffGameZopEvent,
        colorPrimaryGameZopEvent,
        colorwhiteGameZopEvent,
        gameEventListHistoryR,
    profileDataC,
    bannerModelR,
    totalLimit,currentPage,
    gameEventListRCricket
      ];
}
