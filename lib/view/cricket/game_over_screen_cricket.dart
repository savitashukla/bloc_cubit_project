import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cubit_project/model/gameEventList/pre_join_event.dart';
import 'package:cubit_project/utils/help_method.dart';
import 'package:cubit_project/utils/logger_utils.dart';
import 'package:cubit_project/view/cricket/game_cricket_list.dart';
import 'package:cubit_project/view/cricket/game_cricket_webview.dart';
import 'package:cubit_project/view/game_zop/game_zop_list.dart';
import 'package:cubit_project/view_model/cubit/gamezop_game_list/gamezop_event_list_cubit.dart';
import 'package:cubit_project/view_model/cubit/gamezop_game_list/gamezop_event_list_equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../../res/AppColor.dart';
import '../../data/service/web_services_helper.dart';
import '../../res/ImageRes.dart';
import '../../utils/weight/help_weight.dart';

class GameOverScreenCricket extends StatefulWidget {
  String? event_id;
  String? gameid;
  String? playAmount;

  GameOverScreenCricket(
    this.gameid,
    this.event_id,
    this.playAmount,
  );

  @override
  State<GameOverScreenCricket> createState() => GameOverScreenCricketState();
}

class GameOverScreenCricketState extends State<GameOverScreenCricket>
    with SingleTickerProviderStateMixin {
  bool popB = false;
  String? url1;

  bool cancel = false;

  GamezopEventListCubit? gamezopEventListCubit;

  SharedPreferences? prefs;
  String? user_id;
  String? token;

  late AnimationController transitionAnimation;

/*  Match_Making_Screen_Controller match_Making_Screen_Controlleer =
      Get.put(Match_Making_Screen_Controller(event_id,gameid));*/

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //print('Test GameZop:: 3 ${userController.getTotalBalnace()}');

    transitionAnimation = AnimationController(
      duration: const Duration(seconds: 40),
      vsync: this,
    );
    transitionAnimation!.repeat();
    HelpMethod().customPrint("game zob data call ");

    gamezopEventListCubit = context.read<GamezopEventListCubit>();
    getData();
  }

  Future<void> getData() async {
    gamezopEventListCubit!.paginationCurrentPage(0);
    await gamezopEventListCubit!.getUnityHistoryOnly("${widget.gameid}");

    getPreJoinEventGameZob("${widget.event_id}");
  }

/*  @override
  Future<void> initState() {
    // TODO: implement initState
    super.initState();
    getData();
    //print('Test GameZop:: 3 ${userController.getTotalBalnace()}');

    transitionAnimation = AnimationController(
      duration: const Duration(seconds: 15),
      vsync: this,
    );
    transitionAnimation!.repeat();
    HelpMethod().customPrint("game zob data call ");
  }*/

  @override
  dispose() {
    transitionAnimation!.dispose(); // you need this
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GamezopEventListCubit, GamezopEventListEquatable>(
        builder: (BuildContext context, state) {
      return SafeArea(
        child: Scaffold(
          backgroundColor:AppColor().colorPrimary,
          appBar: AppBar(
            flexibleSpace: Image(
              image: AssetImage(ImageRes().topBg),
              height: 55,
              fit: BoxFit.cover,
            ),
            backgroundColor: Colors.transparent,
            title: Center(
                child: Padding(
              padding: const EdgeInsets.only(right: 60),
              child: HelpWeight().testMethod(
                  40.0, FontWeight.w700, AppColor().textColorLight, "Earnzo"),
            )),
          ),

          body: WillPopScope(
            onWillPop: () async {
              bool isPop = false;
              await showAlertDialog(context, (alertResponse) {
                Navigator.of(context).pop();
                // This will dismiss the alert dialog
                isPop = alertResponse;
              });
              return isPop;
            },
            child: SingleChildScrollView(
              child: state.gameEventListHistoryR != null
                  ? state.gameEventListHistoryR! != null &&
                          state.gameEventListHistoryR!.length > 0 &&
                          state.gameEventListHistoryR![0].rounds![0]
                                  .result !=
                              null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                const SizedBox(
                                  height: 50,
                                ),
                                state.gameEventListHistoryR != null
                                    ? state.gameEventListHistoryR! !=
                                                null &&
                                            state.gameEventListHistoryR!
                                                    .length >
                                                0 &&
                                            state.gameEventListHistoryR!
                                                    [0].isWinner ==
                                                true
                                        ? Container(
                                            height: 130,
                                            child: Image.asset(
                                                "assets/images/you_won_image.png"))
                                        : Container(
                                            height: 130,
                                            child: Image.asset(
                                                "assets/images/you_lose_image.png"))
                                    : Shimmer.fromColors(
                                        baseColor: Colors.grey.withOpacity(0.2),
                                        highlightColor:
                                            Colors.grey.withOpacity(0.4),
                                        enabled: true,
                                        child: Container(
                                          height: 130,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          width:
                                              MediaQuery.of(context).size.width,
                                        ),
                                      ),

                                /*Container(
                             height: 130,
                             child:Shi)*/

                                const SizedBox(
                                  height: 50,
                                ),
                                state.gameEventListHistoryR! != null &&
                                        state.gameEventListHistoryR! !=
                                            null &&
                                        state.gameEventListHistoryR!
                                                .length >
                                            0 &&
                                        state.gameEventListHistoryR![0]
                                                .isWinner ==
                                            true
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              flex: 1,
                                              child: Stack(
                                                alignment: Alignment.topCenter,
                                                children: [
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 7,
                                                            top: 60,
                                                            left: 15),
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 0, top: 0),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                          color: AppColor()
                                                              .first_rank,
                                                          width: 5,
                                                        ),
                                                        color: AppColor()
                                                            .whiteColor),
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 15),
                                                      child: Column(
                                                        children: [
                                                          const SizedBox(
                                                            height: 70,
                                                          ),
                                                          Text(
                                                            state.profileDataC!.username ??
                                                                "------",
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontFamily:
                                                                        "Inter",
                                                                    color: Colors
                                                                        .black),
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          const Text(
                                                            "YOUR SCORE",
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontFamily:
                                                                    "Inter",
                                                                color: Colors
                                                                    .black54),
                                                          ),
                                                          state.gameEventListHistoryR !=
                                                                      null &&
                                                                  state
                                                                          .gameEventListHistoryR!

                                                                          .length >
                                                                      0
                                                              ? Text(
                                                                  state
                                                                          .gameEventListHistoryR!
                                                                          [
                                                                              0]
                                                                          .rounds![
                                                                              0]
                                                                          .result!
                                                                          .score ??
                                                                      "0",
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      fontFamily:
                                                                          "Inter",
                                                                      color: Colors
                                                                          .black),
                                                                )
                                                              : const Text(
                                                                  "0",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      fontFamily:
                                                                          "Inter",
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                          const SizedBox(
                                                            height: 40,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Center(
                                                    child: Container(
                                                        height: 150,
                                                        width: 150,
                                                        decoration:
                                                            const BoxDecoration(
                                                          image: DecorationImage(
                                                              image: AssetImage(
                                                                  "assets/images/first_rank_circle.png")),
                                                        ),
                                                        child:state.profileDataC!.photo!=null && state.profileDataC!.photo!.url !=null

                                                                ? Container(
                                                                    height: 20,
                                                                    width: 20,
                                                                    child: Center(
                                                                        child: Image(
                                                                      height:
                                                                          30,
                                                                      image: AssetImage(
                                                                          ImageRes()
                                                                              .team_group),
                                                                    )),
                                                                  )
                                                                : Center(
                                                                    child:
                                                                        ClipRRect(
                                                                      borderRadius:
                                                                          const BorderRadius
                                                                              .all(
                                                                        Radius.circular(
                                                                            50),
                                                                      ),
                                                                      child:
                                                                          CachedNetworkImage(
                                                                        width:
                                                                            88,
                                                                        height:
                                                                            88,
                                                                        fit: BoxFit
                                                                            .fill,
                                                                        imageUrl:
                                                                            ("${state.profileDataC!.photo!.url}"),
                                                                      ),
                                                                    ),
                                                                  )
                                                          ),
                                                  )
                                                ],
                                              )),
                                          Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 20),
                                                child: Stack(
                                                  alignment:
                                                      Alignment.topCenter,
                                                  children: [
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 8,
                                                              top: 70,
                                                              right: 15),
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 0,
                                                              top: 0),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                            color: AppColor()
                                                                .second_rank,
                                                            width: 5,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: AppColor()
                                                              .whiteColor),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 15),
                                                        child: Column(
                                                          children: [
                                                            const SizedBox(
                                                              height: 50,
                                                            ),
                                                            Text(
                                                              "${state.gameEventListHistoryR![0].opponents![0].housePlayerName ?? state.gameEventListHistoryR![0].opponents![0].userId!.username}",
                                                              style: const TextStyle(
                                                                  fontSize: 14,
                                                                  fontFamily:
                                                                      "Inter",
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            const Text(
                                                              "YOUR SCORE",
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontFamily:
                                                                      "Inter",
                                                                  color: Colors
                                                                      .black54),
                                                            ),
                                                            Text(
                                                              state
                                                                      .gameEventListHistoryR!
                                                                      [0]
                                                                      .opponents![
                                                                          0]
                                                                      .rounds![
                                                                          0]
                                                                      .result!
                                                                      .score ??
                                                                  "0",
                                                              style: const TextStyle(
                                                                  fontSize: 14,
                                                                  fontFamily:
                                                                      "Inter",
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                            const SizedBox(
                                                              height: 25,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Center(
                                                      child: Container(
                                                          height: 150,
                                                          width: 150,
                                                          decoration:
                                                              const BoxDecoration(
                                                            image: DecorationImage(
                                                                image: AssetImage(
                                                                    "assets/images/second_circle.png")),
                                                          ),
                                                          child: state
                                                                          .gameEventListHistoryR !=
                                                                      null &&
                                                                  state.gameEventListHistoryR!
                                                                           !=
                                                                      null &&
                                                                  state
                                                                          .gameEventListHistoryR!
                                                                          [
                                                                              0]
                                                                          .opponents![
                                                                              0]
                                                                          .userId!
                                                                          .photo !=
                                                                      null &&
                                                                  state
                                                                          .gameEventListHistoryR!
                                                                          [
                                                                              0]
                                                                          .opponents![
                                                                              0]
                                                                          .userId!
                                                                          .photo!
                                                                          .url !=
                                                                      null
                                                              ? Center(
                                                                  child:
                                                                      ClipRRect(
                                                                    borderRadius:
                                                                        const BorderRadius
                                                                            .all(
                                                                      Radius.circular(
                                                                          50),
                                                                    ),
                                                                    child:
                                                                        CachedNetworkImage(
                                                                      width: 85,
                                                                      height:
                                                                          85,
                                                                      fit: BoxFit
                                                                          .fill,
                                                                      imageUrl:
                                                                          ("${state.gameEventListHistoryR![0].opponents![0].userId!.photo!.url}"),
                                                                    ),
                                                                  ),
                                                                )
                                                              : Container(
                                                                  height: 20,
                                                                  width: 20,
                                                                  child: Center(
                                                                      child:
                                                                          Image(
                                                                    height: 30,
                                                                    image: AssetImage(
                                                                        ImageRes()
                                                                            .team_group),
                                                                  )),
                                                                )),
                                                    )
                                                  ],
                                                ),
                                              ))
                                        ],
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              flex: 1,
                                              child: Stack(
                                                alignment: Alignment.topCenter,
                                                children: [
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 7,
                                                            top: 60,
                                                            left: 15),
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 0, top: 0),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                          color: AppColor()
                                                              .first_rank,
                                                          width: 5,
                                                        ),
                                                        color: AppColor()
                                                            .whiteColor),
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 15),
                                                      child: Column(
                                                        children: [
                                                          const SizedBox(
                                                            height: 70,
                                                          ),

                                                                  state.gameEventListHistoryR! != null &&
                                                                  state
                                                                          .gameEventListHistoryR!

                                                                          .length >
                                                                      0
                                                              ? Text(
                                                                  "${state.gameEventListHistoryR![0].opponents![0].housePlayerName ?? state.gameEventListHistoryR![0].opponents![0].userId!.username}",
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      fontFamily:
                                                                          "Inter",
                                                                      color: Colors
                                                                          .black),
                                                                )
                                                              : const Text(
                                                                  "Lode",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      fontFamily:
                                                                          "Inter",
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          const Text(
                                                            "YOUR SCORE",
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontFamily:
                                                                    "Inter",
                                                                color: Colors
                                                                    .black54),
                                                          ),
                                                          state.gameEventListHistoryR != null &&
                                                                  state.gameEventListHistoryR!
                                                                           !=
                                                                      null &&
                                                                  state
                                                                          .gameEventListHistoryR!

                                                                          .length >
                                                                      0
                                                              ? Text(
                                                                  state
                                                                          .gameEventListHistoryR!
                                                                          [
                                                                              0]
                                                                          .opponents![
                                                                              0]
                                                                          .rounds![
                                                                              0]
                                                                          .result
                                                                          ?.score ??
                                                                      "0",
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      fontFamily:
                                                                          "Inter",
                                                                      color: Colors
                                                                          .black),
                                                                )
                                                              : const Text(
                                                                  "0",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      fontFamily:
                                                                          "Inter",
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                          const SizedBox(
                                                            height: 40,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Center(
                                                    child: Container(
                                                        height: 150,
                                                        width: 150,
                                                        decoration:
                                                            const BoxDecoration(
                                                          image: DecorationImage(
                                                              image: AssetImage(
                                                                  "assets/images/first_rank_circle.png")),
                                                        ),
                                                        child: state
                                                                        .gameEventListHistoryR !=
                                                                    null &&
                                                                state
                                                                        .gameEventListHistoryR!=
                                                                    null &&
                                                                state
                                                                        .gameEventListHistoryR!
                                                                        [
                                                                            0]
                                                                        .opponents![
                                                                            0]
                                                                        .userId!
                                                                        .photo !=
                                                                    null &&
                                                                state
                                                                        .gameEventListHistoryR!
                                                                        [
                                                                            0]
                                                                        .opponents![
                                                                            0]
                                                                        .userId!
                                                                        .photo!
                                                                        .url !=
                                                                    null
                                                            ? Center(
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      const BorderRadius
                                                                          .all(
                                                                    Radius
                                                                        .circular(
                                                                            50),
                                                                  ),
                                                                  child:
                                                                      CachedNetworkImage(
                                                                    width: 85,
                                                                    height: 85,
                                                                    fit: BoxFit
                                                                        .fill,
                                                                    imageUrl:
                                                                        ("${state.gameEventListHistoryR![0].opponents![0].userId!.photo!.url}"),
                                                                  ),
                                                                ),
                                                              )
                                                            : Container(
                                                                height: 20,
                                                                width: 20,
                                                                child: Center(
                                                                    child:
                                                                        Image(
                                                                  height: 30,
                                                                  image: AssetImage(
                                                                      ImageRes()
                                                                          .team_group),
                                                                )),
                                                              )),
                                                  )
                                                ],
                                              )),
                                          Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 20),
                                                child: Stack(
                                                  alignment:
                                                      Alignment.topCenter,
                                                  children: [
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 8,
                                                              top: 70,
                                                              right: 15),
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 0,
                                                              top: 0),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                            color: AppColor()
                                                                .second_rank,
                                                            width: 5,
                                                          ),
                                                          /*    image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: AssetImage("assets/images/store_back.png")),*/
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: AppColor()
                                                              .whiteColor),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 15),
                                                        child: Column(
                                                          children: [
                                                            const SizedBox(
                                                              height: 50,
                                                            ),
                                                            const Text(
                                                              "user_name",
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontFamily:
                                                                      "Inter",
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            const Text(
                                                              "YOUR SCORE",
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontFamily:
                                                                      "Inter",
                                                                  color: Colors
                                                                      .black54),
                                                            ),
                                                            state.gameEventListHistoryR !=
                                                                        null &&
                                                                    state
                                                                            .gameEventListHistoryR!

                                                                            .length >
                                                                        0
                                                                ? Text(
                                                                    state
                                                                            .gameEventListHistoryR!
                                                                            [0]
                                                                            .rounds![0]
                                                                            .result!
                                                                            .score ??
                                                                        "0",
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        fontFamily:
                                                                            "Inter",
                                                                        color: Colors
                                                                            .black),
                                                                  )
                                                                : const Text(
                                                                    "0",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        fontFamily:
                                                                            "Inter",
                                                                        color: Colors
                                                                            .black),
                                                                  ),
                                                            const SizedBox(
                                                              height: 25,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Center(
                                                      child: Container(
                                                          height: 150,
                                                          width: 150,
                                                          decoration:
                                                              const BoxDecoration(
                                                            image: DecorationImage(
                                                                image: AssetImage(
                                                                    "assets/images/second_circle.png")),
                                                          ),
                                                          child: state.profileDataC!.photo!=null && state.profileDataC!.photo!.url !=null
                                                                  ? Container(
                                                                      height:
                                                                          20,
                                                                      width: 20,
                                                                      child: Center(
                                                                          child: Image(
                                                                        height:
                                                                            30,
                                                                        image: AssetImage(
                                                                            ImageRes().team_group),
                                                                      )),
                                                                    )
                                                                  : Center(
                                                                      child:
                                                                          ClipRRect(
                                                                        borderRadius:
                                                                            const BorderRadius.all(
                                                                          Radius.circular(
                                                                              50),
                                                                        ),
                                                                        child:
                                                                            CachedNetworkImage(
                                                                          width:
                                                                              85,
                                                                          height:
                                                                              85,
                                                                          fit: BoxFit
                                                                              .fill,
                                                                          imageUrl:
                                                                              ("${state.profileDataC!.photo!.url}"),
                                                                        ),
                                                                      ),
                                                                    )
                                                            ),
                                                    )
                                                  ],
                                                ),
                                              )),
                                        ],
                                      ),
                                const SizedBox(
                                  height: 80,
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, bottom: 50),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 22),
                                      child: Container(
                                          height: 50,
                                          decoration: BoxDecoration(
                                              color: AppColor().textColorLight,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Stack(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0),
                                                child: AnimatedBuilder(
                                                  animation:
                                                      transitionAnimation,
                                                  builder: (context, child) {
                                                    return SlideTransition(
                                                        position: Tween<Offset>(
                                                          begin: const Offset(
                                                              -1, 0),
                                                          end: const Offset(
                                                              0, 0),
                                                        ).animate(CurvedAnimation(
                                                            curve: const Interval(
                                                                .01, 0.25,
                                                                curve: Curves
                                                                    .easeIn),
                                                            parent:
                                                                transitionAnimation)),
                                                        child: child);
                                                  },
                                                  child: Container(
                                                    height: 50,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    //    color:AppColor().colorPrimaryDark,

                                                    decoration: BoxDecoration(
                                                        color: AppColor()
                                                            .textColorLight,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  cancel = true;
                                                  try {
                                                    /*String depositeBalnace =
                                                            userController
                                                                .getDepositeBalnace();
                                                        int getBonuse = userController
                                                            .getBonuseCashBalanceInt();
                                                        var totalBaI = double.parse(
                                                            depositeBalnace);
                                                        double depositeBalnaceSum =
                                                            totalBaI + getBonuse;

                                                        if (depositeBalnaceSum <=
                                                            0) {
                                                          WalletPageController walletPageController = Get.put(WalletPageController());
                                                          walletPageController.alertLookBox("zero_amount");
                                                        } else {*/
                                                    getPreJoinEventCricketClick(
                                                        widget.event_id);
                                                    // }
                                                  } catch (E) {
                                                    print("comming ex$E");
                                                  }
                                                },
                                                child: Container(
                                                  color: Colors.transparent,
                                                  height: 50,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Text(
                                                        "Starting New Battle",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontFamily: "UltimaPro",
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Container(
                                                        width: 20,
                                                        child: Image.asset(
                                                            ImageRes()
                                                                .rupee_icon),
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        "${widget.playAmount}",
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            fontFamily: "UltimaPro",
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          )),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: InkWell(
                                      onTap: () {
                                        cancel = true;
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();
                                        /*  Get.to(() =>
                                      GameJobList(gameid, url1, "Ludo"));*/
                                      },
                                      child: Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                            color: AppColor().whiteColor,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Center(
                                          child: Text(
                                            "Cancel",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: "UltimaPro",
                                                color:
                                                    AppColor().reward_card_bg),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 50,
                            ),
                            Container(
                                height: 130,
                                child: Image.asset(
                                    "assets/images/gameover_test.png")),
                            const SizedBox(
                              height: 90,
                            ),
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Center(
                                        child: AspectRatio(
                                          aspectRatio: 2 / 1,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    fit: BoxFit.fill,
                                                    image: AssetImage(ImageRes()
                                                        .resultserror))),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 90,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, bottom: 50),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 22),
                                      child: Container(
                                          height: 50,
                                          decoration: BoxDecoration(
                                              color: AppColor().colorPrimary,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Stack(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0),
                                                child: AnimatedBuilder(
                                                  animation:
                                                      transitionAnimation,
                                                  builder: (context, child) {
                                                    return SlideTransition(
                                                        position: Tween<Offset>(
                                                          begin: const Offset(
                                                              -1, 0),
                                                          end: const Offset(
                                                              0, 0),
                                                        ).animate(CurvedAnimation(
                                                            curve: const Interval(
                                                                .01, 0.25,
                                                                curve: Curves
                                                                    .easeIn),
                                                            parent:
                                                                transitionAnimation)),
                                                        child: child);
                                                  },
                                                  child: Container(
                                                    height: 50,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    //    color:AppColor().colorPrimaryDark,

                                                    decoration: BoxDecoration(
                                                        color: AppColor()
                                                            .textColorLight,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  cancel = true;

                                                  try {
                                                    /*String depositeBalnace =
                                                            userController
                                                                .getDepositeBalnace();
                                                        int getBonuse = userController
                                                            .getBonuseCashBalanceInt();
                                                        var totalBaI = double.parse(
                                                            depositeBalnace);
                                                        double depositeBalnaceSum =
                                                            totalBaI + getBonuse;

                                                        if (depositeBalnaceSum <=
                                                            0) {
                                                          WalletPageController walletPageController = Get.put(WalletPageController());
                                                          walletPageController.alertLookBox("zero_amount");
                                                        } else {*/
                                                    getPreJoinEventCricketClick(
                                                        widget.event_id);
                                                    // }
                                                  } catch (E) {
                                                    print("comming ex$E");
                                                  }
                                                },
                                                child: Container(
                                                  color: Colors.transparent,
                                                  height: 50,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Text(
                                                        "Starting New Battle",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontFamily: "UltimaPro",
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Container(
                                                        width: 20,
                                                        child: Image.asset(
                                                            ImageRes()
                                                                .rupee_icon),
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        "${widget.playAmount}",
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            fontFamily: "UltimaPro",
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          )),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: InkWell(
                                      onTap: () {
                                        cancel = true;
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();
                                        //
                                        /*  Get.to(() =>
                                      GameJobList(gameid, url1, "Ludo"));*/
                                      },
                                      child: Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                            color: AppColor().whiteColor,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Center(
                                          child: Text(
                                            "Cancel",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: "UltimaPro",
                                                color:
                                                    AppColor().reward_card_bg),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        )
                  : Shimmer.fromColors(
                      baseColor: Colors.grey.withOpacity(0.2),
                      highlightColor: Colors.grey.withOpacity(0.4),
                      enabled: true,
                      child: Container(
                        height: 130,
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
            ),
          ),
        ),
      );
    });
  }

  Future<void> getPreJoinEventGameZob(String event_id) async {
    //print("event_id ===>${contest_id}");

    if(token==null)
    {
      prefs = await SharedPreferences.getInstance();
      token = prefs!.getString("token")!;
      user_id = prefs!.getString("userId")!;
    }

    HelpMethod().customPrint("user_id ===> ${user_id}");
    final param = {
      "userId": user_id,
      // "thirdParty": {"type": "gameZop", "gameCode": "SJRX12TXcRH"}
      // "thirdParty": {"type": "gameZop", "gameCode": "rkWfy2pXq0r"}
      "thirdParty": {"type": "freakx", "gameCode": ""}

    };

    Map<String, dynamic>? response = await WebServicesHelper()
        .getPreEventJoinGameJob(param, token!, event_id);
    debugPrint(' respone is finaly ${response}');
    if (response != null && response['statusCode'] == null) {
      PreJoinEvent preJoinResponseModel = PreJoinEvent.fromJson(response);
      if (preJoinResponseModel != null) {
        DeficitAmount? deficitAmount = preJoinResponseModel.deficitAmount;
        if (deficitAmount!.value! > 0) {
          //   userController.currentIndex.value = 4;
          //  Utils().alertInsufficientBalance(context);
        } else {
          Future.delayed(const Duration(seconds: 6), () {
            if (cancel) {
              // cancel = false;
              //Get.offAll(() => GameJobList(gameid, url1, "Ludo"));
            } else {


              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CricketWebView(preJoinResponseModel!.webViewUrl,
                          widget.gameid, widget.event_id, widget.playAmount)));


            }
          });
        }
      } else {
        HelpWeight().flutterCustomToast("${response!['statusCode']}");
      }
    } else if (response!['statusCode'] != 400) {
      HelpWeight().flutterCustomToast("${response!['statusCode']}");
    } else if (response!['statusCode'] != 500) {
      /* AppBaseResponseModel appBaseErrorModel =
      AppBaseResponseModel.fromMap(response);*/
      HelpWeight().flutterCustomToast("${response!['statusCode']}");
    } else {
      HelpMethod().customPrint('respone is finaly2${response}');
    }
  }

  Future<void> getPreJoinEventCricketClick(String? eventId) async {
    if(token==null)
    {
      prefs = await SharedPreferences.getInstance();
      token = prefs!.getString("token")!;
      user_id = prefs!.getString("userId")!;
    }
    final param = {
      "userId": user_id,
      //  "thirdParty": {"type": "gameZop", "gameCode": "SJRX12TXcRH"}
      // "thirdParty": {"type": "gameZop", "gameCode": "rkWfy2pXq0r"}
      "thirdParty": {"type": "freakx", "gameCode": ""}

    };

    Map<String, dynamic>? response = await WebServicesHelper()
        .getPreEventJoinGameJob(param, token!, eventId!);
    debugPrint(' respone is finaly ${response}');
    if (response != null && response['statusCode'] == null) {
      PreJoinEvent preJoinResponseModel = PreJoinEvent.fromJson(response);
      if (preJoinResponseModel != null) {
        DeficitAmount? deficitAmount = preJoinResponseModel.deficitAmount;
        if (deficitAmount!.value! > 0) {

        } else {


          Navigator.pushReplacement(
              navigatorKey.currentState!.context,
              MaterialPageRoute(
                  builder: (context) => CricketWebView(preJoinResponseModel!.webViewUrl,
                      widget.gameid, widget.event_id, widget.playAmount)));

          /*     Navigator.pushReplacement<void, void>(
            MaterialPageRoute<void>(
              builder: (BuildContext? context) => GameJobWebview(
                  preJoinResponseModel.webViewUrl,
                  gameid,
                  event_id,
                  playAmount,
                  url1),
            ) ,
          );*/
        }
      } else {}
    } else if (response!['statusCode'] != 400) {
      /*AppBaseResponseModel appBaseErrorModel =
      AppBaseResponseModel.fromMap(response);
      Utils().showErrorMessage("", appBaseErrorModel.error);*/
    } else if (response['statusCode'] != 500) {
      /* AppBaseResponseModel appBaseErrorModel =
      AppBaseResponseModel.fromMap(response);
      Utils().showErrorMessage("", appBaseErrorModel.error);*/
    } else {
      HelpMethod().customPrint('respone is finaly2${response}');
    }
  }



  Future showAlertDialog(
      BuildContext context, YesOrNoTapCallback isYesTapped) async {
    AlertDialog alert = AlertDialog(
      elevation: 24,
      content: const Text("Do you want to quit?"),
      actions: [
        TextButton(
            onPressed: () {
              cancel = true;
              Navigator.of(context).pop();
              Navigator.of(context).pop();

              Navigator.push(
                navigatorKey.currentState!.context,
                MaterialPageRoute(
                  builder: (BuildContext context) => CricketGameList(
                    "${widget.gameid}")
                ),
              );
              //   Get.to(() => GameJobList(gameid, url1, "Ludo"));
              // isYesTapped(true);
            },
            child: const Text("Yes")),
        TextButton(
            onPressed: () {
              isYesTapped(false);
              // Navigator.of(context).pop();
            },
            child: const Text("No")),
      ],
    );
    await showDialog(context: context, builder: (_) => alert);
  }
}

typedef YesOrNoTapCallback = Function(bool);
