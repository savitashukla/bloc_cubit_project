import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:cubit_project/model/gameEventList/pre_join_event.dart';
import 'package:cubit_project/utils/help_method.dart';
import 'package:cubit_project/utils/helper_progressbar.dart';
import 'package:cubit_project/view_model/cubit/gamezop_game_list/gamezop_event_list_cubit.dart';
import 'package:cubit_project/view_model/cubit/gamezop_game_list/gamezop_event_list_equatable.dart';
import 'package:cubit_project/view_model/cubit/loot_box_cubit/loot_box_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../data/service/api_url.dart';
import '../../data/service/web_services_helper.dart';
import '../../res/AppColor.dart';
import '../../res/AppString.dart';
import '../../res/ImageRes.dart';
import '../../utils/logger_utils.dart';
import '../../utils/weight/help_weight.dart';
import 'game_tamasha_webview.dart';

class TamashaGameList extends StatefulWidget {
  String? gameId;

  TamashaGameList(this.gameId, {Key? key}) : super(key: key);

  @override
  State<TamashaGameList> createState() => _TamashaGameListState();
}

class _TamashaGameListState extends State<TamashaGameList> {
  GamezopEventListCubit? gamezopEventListCubit;
  LootBoxCubit? lootBoxCubit;
  var scrollcontroller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    gamezopEventListCubit = context.read<GamezopEventListCubit>();

    gamezopEventListCubit!.callEventList();
    gamezopEventListCubit!.getTamashaEventList();
    gamezopEventListCubit!.getProfileData();
    gamezopEventListCubit!.getBanner("${widget.gameId}");
    gamezopEventListCubit!.paginationCurrentPage(0);

    scrollcontroller.addListener(() {
      if (scrollcontroller.position.atEdge &&
          scrollcontroller.position.pixels != 0) {
        if (gamezopEventListCubit!.state.totalLimit >
            gamezopEventListCubit!.state.currentPage) {
          gamezopEventListCubit!.paginationCurrentPage(
              gamezopEventListCubit!.state.currentPage + 10);

          gamezopEventListCubit!.getUnityHistoryOnly("${widget.gameId}");
        }
        //     Utils().customPrint("data pagination");
      }
    });

    lootBoxCubit = context.read<LootBoxCubit>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GamezopEventListCubit, GamezopEventListEquatable>(
      builder: (BuildContext context, state) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: AppColor().colorPrimary,
            appBar: AppBar(
              flexibleSpace: Image(
                image: AssetImage(ImageRes().topBg),
                height: 55,
                fit: BoxFit.cover,
              ),
              backgroundColor: Colors.transparent,
              title: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: HelpWeight().testMethod(
                40.0, FontWeight.w700, AppColor().textColorLight, "Earnzo"),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      HelpWeight().flutterCustomToast('banner click!');
                      HelpMethod().customPrint('banner click!');
                    },
                    child: state.bannerModelR != null &&
                            state.bannerModelR!.data != null
                        ? state.bannerModelR!.data!.length > 0
                            ? state.bannerModelR!.data!.length > 1
                                ? CarouselSlider(
                                    items: state.bannerModelR!.data!
                                        .map(
                                          (item) => Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 6),
                                            child: Center(
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  child: CachedNetworkImage(
                                                    height: 100,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    fit: BoxFit.cover,
                                                    imageUrl:
                                                        ("${item.image!.url}"),
                                                    errorWidget: (BuildContext
                                                            context,
                                                        String exception,
                                                        dynamic stackTrace) {
                                                      return Container();
                                                    },
                                                  )),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                    options: CarouselOptions(
                                      height: 120.0,
                                      autoPlay: true,
                                      disableCenter: true,
                                      viewportFraction: .9,
                                      aspectRatio: 3,
                                      enlargeCenterPage: false,
                                      autoPlayCurve: Curves.fastOutSlowIn,
                                      enableInfiniteScroll: true,
                                      autoPlayAnimationDuration:
                                          const Duration(milliseconds: 1000),
                                      onPageChanged: (index, reason) {
                                        // controller.currentIndexSlider.value = index;
                                      },
                                    ),
                                  )
                                : Container(
                                    height: 130,
                                    margin: const EdgeInsets.only(
                                        top: 10, right: 10, left: 10),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: state.bannerModelR != null &&
                                              state.bannerModelR!.data !=
                                                  null &&
                                              state.bannerModelR!.data!
                                                      .length >=
                                                  1
                                          ? Image(
                                              height: 120,
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  "${state.bannerModelR!.data![0].image!.url}"),
                                            )
                                          : Image(
                                              height: 120,
                                              fit: BoxFit.cover,
                                              image: AssetImage(ImageRes()
                                                  .store_banner_wallet),
                                            ),
                                    ),
                                  )
                            : Container(
                                height: 0,
                              )
                        : Shimmer.fromColors(
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              height: MediaQuery.of(context).size.width * 0.3,
                              width: MediaQuery.of(context).size.width,
                            ),
                            baseColor: Colors.grey.withOpacity(0.2),
                            highlightColor: Colors.grey.withOpacity(0.4),
                            enabled: true,
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 35, bottom: 15),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: () {
                                gamezopEventListCubit!.callEventList();
                              },
                              child: Column(
                                children: [
                                  const Text(
                                    "All Battles",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: "UltimaPro",
                                        color: Colors.white),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 5),
                                    color: state.colorPrimaryGameZopEvent,
                                    height: 3,
                                  )
                                ],
                              ),
                            )),
                        Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: () {
                                gamezopEventListCubit!.paginationCurrentPage(0);
                                gamezopEventListCubit!.historyCall();

                                gamezopEventListCubit!
                                    .getUnityHistoryOnly("${widget.gameId}");

                                /*   try {
                                  if (controller
                                      .unity_history_userRegistrations !=
                                      null &&
                                      controller.unity_history_userRegistrations
                                          .length >
                                          0) {
                                    controller.unity_history_userRegistrations
                                        .clear();
                                  }
                                } catch (E) {}
                                currentpage.value = 0;
                                controller.getUnityHistoryOnly(gameid);*/
                              },
                              child: Column(
                                children: [
                                  const Text(
                                    "History",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: "UltimaPro",
                                        color: Colors.white),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 5),
                                    color: state.colorwhiteGameZopEvent,
                                    height: 3,
                                  )
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.centerLeft,
                    child: state.checkTurnOffGameZopEvent
                        ? const Text(
                            "Contest",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: "UltimaPro",
                                color: Colors.white),
                          )
                        : InkWell(
                            onTap: () {
                              HelpWeight().tamashaLHistoryPending();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(
                                    height: 20,
                                    color: Colors.red,
                                    width: 20,
                                    image: AssetImage(ImageRes().warning_tl)),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  "Don't see your result here?",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "UltimaPro",
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Visibility(
                    visible: state.checkTurnOffGameZopEvent,
                    child: state.tamashaEventListR != null
                        ? state.tamashaEventListR! != null
                            ? ListView.builder(
                                itemCount: state.tamashaEventListR?.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, int index) {
                                  return triviaListother(context, index);
                                })
                            : const SizedBox()
                        : Container(
                            height: 100,
                            width: 100,
                            color: Colors.transparent,
                            child: const Image(
                                height: 100,
                                width: 100,
                                //color: Colors.transparent,
                                fit: BoxFit.fill,
                                image: AssetImage(
                                    "assets/images/progresbar_images.gif")),
                          ),
                  ),
                  Offstage(
                    offstage: state.checkTurnOffGameZopEvent,
                    child: state.gameEventListHistoryR != null
                        ? state.gameEventListHistoryR!.length > 0
                            ? ListView.builder(
                                itemCount: state.gameEventListHistoryR!.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return listHistoryUnity(context, index);
                                })
                            : const SizedBox(
                                height: 0,
                              )
                        : Container(
                            height: 100,
                            width: 100,
                            color: Colors.transparent,
                            child: const Image(
                                height: 100,
                                width: 100,
                                //color: Colors.transparent,
                                fit: BoxFit.fill,
                                image: AssetImage(
                                    "assets/images/progresbar_images.gif")),
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget listHistoryUnity(BuildContext context, int index) {
    return InkWell(
      onTap: () {
        HelpMethod().customPrint("--------> clicked");
        /* Get.to(() => UnityDetails(url != null ? url : "",
            controller.unity_history_userRegistrations.value, index));*/
      },
      child: gamezopEventListCubit!.state.gameEventListHistoryR! != null
          ? Container(
              margin: const EdgeInsets.only(
                  bottom: 5, top: 10, right: 10, left: 10),
              decoration: BoxDecoration(
                  border:
                      Border.all(color: AppColor().textColorLight, width: 1),
                  // color: AppColor().whiteColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15.0, right: 15, top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        gamezopEventListCubit!
                                        .state
                                        .gameEventListHistoryR![index]
                                        .opponents !=
                                    null &&
                                gamezopEventListCubit!
                                        .state
                                        .gameEventListHistoryR![index]
                                        .opponents!
                                        .length >
                                    0
                            ? gamezopEventListCubit!
                                        .state
                                        .gameEventListHistoryR![index]
                                        .opponents![0]
                                        .housePlayerName !=
                                    null
                                ? Text(
                                    "${gamezopEventListCubit!.state.gameEventListHistoryR![index].opponents![0].housePlayerName}",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "UltimaPro",
                                        color: AppColor().whiteColor))
                                : Text(
                                    "${gamezopEventListCubit!.state.gameEventListHistoryR![index].opponents![0].userId!.username}",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "UltimaPro",
                                        color: AppColor().whiteColor))
                            : Text("--",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "UltimaPro",
                                    color: AppColor().whiteColor)),
                        /*  Text(
                    (gamezopEventListCubit!.state.gameEventListHistoryR!.data[index]
                        .opponents !=
                        null &&
                        gamezopEventListCubit!.state.gameEventListHistoryR!.data[index]
                            .opponents.length >
                            0)
                        ? gamezopEventListCubit!.state.gameEventListHistoryR!.data[index]
                        .opponents[0].housePlayerName !=
                        null
                        ? gamezopEventListCubit!.state.gameEventListHistoryR!.data[index]
                        .opponents[0].housePlayerName
                        : gamezopEventListCubit!.state.gameEventListHistoryR!.data[index]
                        .opponents[0].userId !=
                        null
                        ? gamezopEventListCubit!.state.gameEventListHistoryR!.data[
                    index]
                        .opponents[0]
                        .userId
                        .username !=
                        null &&
                        gamezopEventListCubit!.state.gameEventListHistoryR!.data[
                        index]
                            .opponents[0]
                            .userId
                            .username !=
                            null
                        ? gamezopEventListCubit!.state.gameEventListHistoryR!.data[index]
                        .opponents[0]
                        .userId
                        .username
                        : ""
                        : ""
                        : "",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: "UltimaPro",
                        color: AppColor().whiteColor),
                  ),*/
                       /* Text(
                          "Entry Fee \u{20B9} ${gamezopEventListCubit!.state.gameEventListHistoryR![index].eventId != null && gamezopEventListCubit!.state.gameEventListHistoryR![index].eventId!.entry != null && gamezopEventListCubit!.state.gameEventListHistoryR![index].eventId!.entry!.fee != null && gamezopEventListCubit!.state.gameEventListHistoryR![index].eventId!.entry!.fee!.value! > 0 ? gamezopEventListCubit!.state.gameEventListHistoryR![index].eventId!.entry!.fee!.value! ~/ 100 : "Free"}",
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontFamily: "UltimaPro",
                              fontSize: 12),
                        )*/
                      ],
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, top: 13),
                      child: gamezopEventListCubit!
                                      .state
                                      .gameEventListHistoryR![index]
                                      .rounds!
                                      .length >
                                  0 &&
                              gamezopEventListCubit!
                                      .state
                                      .gameEventListHistoryR![index]
                                      .rounds![0]
                                      .result !=
                                  null
                          ? gamezopEventListCubit!
                                          .state
                                          .gameEventListHistoryR![index]
                                          .isWinner !=
                                      null &&
                                  gamezopEventListCubit!
                                          .state
                                          .gameEventListHistoryR![index]
                                          .isWinner ==
                                      true
                              ? Text(
                                  "You Won",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "UltimaPro",
                                      color: AppColor().whiteColor),
                                )
                              : Text(
                                  "You Lost",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "UltimaPro",
                                      color: AppColor().whiteColor),
                                )
                          : Text(
                              "Pending",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "UltimaPro",
                                  color: AppColor().whiteColor),
                            ),
                    ),
                  ),
                  Container(
                    height: 12,
                  ),

                  /* Container(
              height: 12,
            ),*/
                  GestureDetector(
                    onTap: () async {},
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, bottom: 12, top: 12),
                      alignment: Alignment.center,
                      /* decoration: BoxDecoration(
                    color: AppColor().colorPrimary,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(12),
                        bottomLeft: Radius.circular(12))),*/
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 0,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: const Image(
                                  height: 20,
                                  width: 20,
                                  color: Colors.white,
                                  fit: BoxFit.cover,
                                  image: AssetImage('assets/images/ic_vs.png'),
                                ),
                              ),
                              Container(
                                width: 5,
                              ),
                              /* url != null && url.isNotEmpty
                            ? ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image(
                              height: 35,
                              width: 35,
                              fit: BoxFit.cover,
                              image: NetworkImage(url)

                            // AssetImage('assets/images/images.png'),
                          ),
                        )
                            :*/
                               Image(
                                height: 35,
                                width: 35,
                                fit: BoxFit.cover,
                                image:
                                    AssetImage(ImageRes().skill_ludo_icon),
                              ),
                              Container(
                                width: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: (gamezopEventListCubit!
                                                .state.gameEventListHistoryR !=
                                            null &&
                                        gamezopEventListCubit!.state
                                                .gameEventListHistoryR!.length >
                                            0 &&
                                        gamezopEventListCubit!
                                                .state
                                                .gameEventListHistoryR![index]
                                                .opponents !=
                                            null &&
                                        gamezopEventListCubit!
                                                .state
                                                .gameEventListHistoryR![index]
                                                .opponents!
                                                .length >
                                            0)
                                    ? Text(
                                        "${gamezopEventListCubit!.state.gameEventListHistoryR![index].opponents![0].userId!.username}",
                                        style: const TextStyle(
                                            color: Colors.white),
                                      )
                                    : const Text(""),
                              ),
                            ],
                          ),
                          Text(
                            gamezopEventListCubit!
                                            .state
                                            .gameEventListHistoryR![index]
                                            .opponents !=
                                        null &&
                                    gamezopEventListCubit!
                                            .state
                                            .gameEventListHistoryR![index]
                                            .opponents!
                                            .length >
                                        0 &&
                                    gamezopEventListCubit!
                                            .state
                                            .gameEventListHistoryR![index]
                                            .opponents![0]
                                            .createdAt !=
                                        null
                                ? getStartTimeHHMMSS(gamezopEventListCubit!
                                    .state
                                    .gameEventListHistoryR![index]
                                    .opponents![0]
                                    .createdAt)
                                : "",
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontFamily: "UltimaPro",
                                fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          : const SizedBox(),
    );
  }

  Widget triviaListotherNotUse(BuildContext context, int index) {
    return Container(
        child: GestureDetector(
      onTap: () async {
        getPreJoinEventGameZob(
            index,
            gamezopEventListCubit!.state.tamashaEventListR![index].contestId,
            context,
            gamezopEventListCubit!
                .state.tamashaEventListR![index].entryFee!.value);
      },
      child: Container(
          height: 120,
          margin:
              const EdgeInsets.only(bottom: 5, top: 10, right: 10, left: 10),
          decoration: BoxDecoration(
              border: Border.all(color: AppColor().textColorLight, width: 1.5),
              // color: AppColor().whiteColor,
              borderRadius: BorderRadius.circular(10)),
          child: Wrap(
            children: [
              Container(
                height: 10,
              ),
              Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          gamezopEventListCubit!
                              .state.tamashaEventListR![index].contestName!
                              .toUpperCase(),
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontFamily: "UltimaPro",
                              color: AppColor().whiteColor),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          getPreJoinEventGameZob(
                              index,
                              gamezopEventListCubit!
                                  .state.tamashaEventListR![index].contestId,
                              context,
                              gamezopEventListCubit!.state
                                  .tamashaEventListR![index].entryFee!.value);
                        },
                        child: Container(
                          width: 120,
                          margin: const EdgeInsets.only(right: 10),
                          height: 35,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                AppColor().buttonBgReadLight,
                                AppColor().buttonBgReadDark,
                              ],
                            ),

                            /*     boxShadow: const [
                                        BoxShadow(
                                          offset: const Offset(
                                            0.0,
                                            5.0,
                                          ),
                                          blurRadius: 1.0,
                                          spreadRadius: .3,
                                          color: Color(0xFFA73804),
                                        ),
                                        BoxShadow(
                                          offset: Offset(00, 00),
                                          blurRadius: 00,
                                          color: Color(0xFFffffff),

                                        ),
                                      ],*/

                            border: Border.all(
                                color: AppColor().whiteColor, width: 2),
                            borderRadius: BorderRadius.circular(30),
                            // color: AppColor().whiteColor
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 10,
                              ),
                              Text(
                                "Play",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: "UltimaPro",
                                    color: AppColor().whiteColor),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.only(right: 10, left: 10),
                                child: gamezopEventListCubit!
                                            .state
                                            .tamashaEventListR![index]
                                            .entryFee!
                                            .value! >
                                        0
                                    ? Text(
                                        "${AppString().txtCurrencySymbol} ${gamezopEventListCubit!.state.tamashaEventListR![index].entryFee!.value}",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: "UltimaPro",
                                            color: AppColor().whiteColor),
                                      )
                                    : Text(
                                        "Free",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: "UltimaPro",
                                            color: AppColor().whiteColor),
                                      ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25, left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Win",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "UltimaPro",
                                      color: AppColor().whiteColor),
                                ),
                                Container(
                                  width: 5,
                                ),
                              ],
                            ),
                            Container(
                              height: 10,
                            ),
                            Center(
                              child: Text(
                                "\u{20B9} ${gamezopEventListCubit!.state.tamashaEventListR![index].reward!.amount!.value}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "UltimaPro",
                                    color: AppColor().whiteColor),
                              ),
                            ),
                            Container(
                              height: 45,
                            ),
                            Container(
                              width: 60,
                            ),
                            /*))*/
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 8, left: 10, top: 5),
                height: 33,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10)),
                  // color: AppColor().whiteColor,
                  color: Colors.transparent,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        showWinningBreakupDialog(
                            context,
                            gamezopEventListCubit!
                                .state
                                .tamashaEventListR![index]
                                .reward!
                                .amount!
                                .value);
                      },
                      child: Container(
                        child: Image.asset(
                          ImageRes().ivInfo,
                          width: 15,
                          height: 15,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            child: CircleAvatar(
                          radius: 8.0,
                          backgroundColor: Colors.transparent,
                          child: Image.asset(ImageRes().team_group,
                              color: Colors.white),
                        )),
                        Padding(
                          padding: const EdgeInsets.only(right: 15, left: 10),
                          child: Text(
                            "${gamezopEventListCubit!.state.tamashaEventListR![index].onlinePlayers}",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: "UltimaPro",
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          )),
    ));
  }



  Widget triviaListother(BuildContext context, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20,right: 5,left: 5),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
                color: Color(0xff46558c),
                offset: Offset(0, 4),
                blurRadius: 2,
                spreadRadius: 0)
          ]),
      child: Container(
        padding: const EdgeInsets.only(left: 13, right: 12),
        width: MediaQuery.of(navigatorKey.currentState!.context).size.width,
        height: 75,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: Color(0xffd9d9d9)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Container(
                    width: 50,
                    height: 49,
                    decoration: BoxDecoration(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(10)),
                        image: DecorationImage(
                            image: AssetImage(ImageRes().skill_ludo_icon)))),
                const SizedBox(width: 14),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /*    Text(
                      "${gamezopEventListCubit!.state.gameEventListRCricket!.data![index].name!.length > 25 ?  "${gamezopEventListCubit!.state.gameEventListRCricket!.data![index].name!.substring(0, 25)}..." : gamezopEventListCubit!.state.gameEventListRCricket!.data![index].name}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: "UltimaPro",
                        color: AppColor().textColorLightMedium,
                        fontWeight: FontWeight.w400,
                      ),
                    ),*/
                    Row(
                      children: [

                        Padding(
                          padding: const EdgeInsets.only(top: 2,right: 7),
                          child: Text(
                            "Win",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              height: 0,
                              fontWeight: FontWeight.w800,
                              fontFamily: "UltimaPro",
                              color: AppColor().textColorLightMedium,
                            ),
                          ),
                        ),

                        Image(
                            height: 20,
                            width: 20,
                            image: AssetImage(
                                ImageRes().earnzoCoinIcon)),
                        Padding(
                          padding: const EdgeInsets.only(top: 2,left: 7),
                          child: Text(
                            "${gamezopEventListCubit!.state.tamashaEventListR![index].reward!.amount!.value}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              height: 0,
                              fontWeight: FontWeight.w800,
                              fontFamily: "UltimaPro",
                              color: AppColor().textColorLightMedium,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 0),
                InkWell(
                  onTap: () {
                    getPreJoinEventGameZob(
                        index,
                        gamezopEventListCubit!
                            .state.tamashaEventListR![index].contestId,
                        context,
                        gamezopEventListCubit!.state
                            .tamashaEventListR![index].entryFee!.value);
                  },
                  child: Container(
                      width: 120,
                      height: 35,
                      margin: const EdgeInsets.only(top: 0),
                      // padding: EdgeInsets.only(right: 10,left: 10),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                                color: Color(0xff1e2540),
                                offset: Offset(0, 4),
                                blurRadius: 2,
                                spreadRadius: 0)
                          ],
                          color: Color(0xff46558c)),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Center(
                          child: Text(
                            "Play Free",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: "UltimaPro",
                              color: AppColor().whiteColor,
                              height: 1.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }



  String getStartTimeHHMMSS(String? date_c) {
    return DateFormat("yyyy-MM-dd' 'HH:mm:ss").format(
        DateFormat("yyyy-MM-ddTHH:mm:ssZ").parse("$date_c", true).toLocal());
  }

  Future<void> getPreJoinEventGameZob(
      int index, String? event_id, BuildContext context, int? amount) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs!.getString("token");
    String? userId = prefs!.getString("userId");
    showProgress();

    final param = {
      "contestId": "$event_id",
    };
    Map<String, dynamic>? response =
        await WebServicesHelper().getTamashaWebView("$token", param);

    hideProgress();
    if (response != null && response['statusCode'] == null) {
      //print(' respone is finaly1 ${response}');
      PreJoinEvent preJoinResponseModel = PreJoinEvent.fromJson(response);
      if (preJoinResponseModel != null  && preJoinResponseModel.webViewUrl!.isNotEmpty) {
        Navigator.push(
          navigatorKey.currentState!.context,
          MaterialPageRoute(
            builder: (BuildContext context) => TamashaWebView(
              preJoinResponseModel.webViewUrl,
              "${widget.gameId}",
              event_id,
              "${gamezopEventListCubit!.state.tamashaEventListR![index].entryFee!.value! > 0?gamezopEventListCubit!.state.tamashaEventListR![index].entryFee!.value!~/100:"0"}",
            ),
          ),
        );

       /* DeficitAmount? deficitAmount = preJoinResponseModel.deficitAmount;
        if (deficitAmount!.value! > 0) {
          Fluttertoast.showToast(msg: "Do not have sufficient Balance");

          // Utils().alertInsufficientBalance(context);
        } else {
          showPreJoinBox(index, context, "$event_id", preJoinResponseModel);

          //  showPreJoinBox(context, event_id, preJoinResponseModel);
        }*/
      } else {}
    } else if (response!['statusCode'] == 401) {
    } else if (response!['statusCode'] != 400) {
    } else if (response!['statusCode'] != 500) {
    } else {
      //hideLoader();
    }
  }

  void showPreJoinBox(int index, BuildContext context, String event_id,
      PreJoinEvent preJoinResponseModel) {
    print("pre join data call here  ${preJoinResponseModel.webViewUrl}");

    var areYouPaying =
        "${((((preJoinResponseModel.deposit!.value! + (preJoinResponseModel.winning!.value)!) ~/ 100)))}";
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",

      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      // transitionDuration: Duration(milliseconds: 200),
      pageBuilder: (_, __, ___) {
        return Center(
          child: Container(
            decoration: BoxDecoration(
              color: AppColor().textColorLight,
                borderRadius: BorderRadius.circular(25)
              /*      image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(ImageRes().new_re,ctangle_box_blank)),*/
            ),
            height: 370,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Card(
              color: Colors.transparent,
              elevation: 0,
              margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "            ",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: "UltimaPro",
                            color: Colors.white),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 10),
                        height: 50,
                        child: Image.asset("assets/images/bonus_coin.png"),
                      ),
                      IconButton(
                          icon: const Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.pop(navigatorKey.currentState!.context);
                          })
                    ],
                  ),
                  Text(
                    "CONFIRM",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: "UltimaPro",
                        color: AppColor().colorPrimary),
                  ),
                  Text(
                    "CHARGES",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: "UltimaPro",
                        color: AppColor().whiteColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          child: Text("ENTRY FEE",
                              style: TextStyle(
                                  color: AppColor().whiteColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  fontFamily: "UltimaPro")),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Wrap(
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              height: 20,
                              child:
                                  Image.asset("assets/images/bonus_coin.png"),
                            ),
                            Text(
                                "${gamezopEventListCubit!.state.tamashaEventListR![index].entryFee!.value! > 0 ? gamezopEventListCubit!.state.tamashaEventListR![index].entryFee!.value! : "Free"}")
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          child: Text("You are paying",
                              style: TextStyle(
                                  color: AppColor().color_side_menu_header,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  fontFamily: "UltimaPro")),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Wrap(
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              height: 20,
                              child:
                                  Image.asset("assets/images/bonus_coin.png"),
                            ),
                            Text(
                              areYouPaying,
                              style: TextStyle(
                                  color: AppColor().color_side_menu_header),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    height: 1,
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          child: Text("From Bonus Cash",
                              style: TextStyle(
                                  color: AppColor().whiteColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  fontFamily: "UltimaPro")),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Wrap(
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              height: 20,
                              child:
                                  Image.asset("assets/images/bonus_coin.png"),
                            ),
                            Text(
                                "${ApiUrl().isPlayStore ? "" : '\u{20B9}'} ${preJoinResponseModel.bonus!.value}",
                                style: TextStyle(
                                    color: AppColor().whiteColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    fontFamily: "UltimaPro"))
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          child: Text("From Deposited Cash & Winning Cash",
                              maxLines: 2,
                              style: TextStyle(
                                  color: AppColor().whiteColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  fontFamily: "UltimaPro")),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Wrap(
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              height: 20,
                              child: Image.asset(
                                  "assets/images/winning_coin.webp"),
                            ),
                            Text(
                                "${ApiUrl().isPlayStore ? "" : '\u{20B9}'} ${(preJoinResponseModel.deposit!.value! / 100 + preJoinResponseModel.winning!.value! / 100)}",
                                style: TextStyle(color: AppColor().whiteColor))
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _Button(index,context, "CONFIRM", "${preJoinResponseModel.webViewUrl}",
                      event_id, ""),
                  const SizedBox(
                    height: 0,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _Button(int index,BuildContext context, String values, String? gameZopWebViewUrl,
      String event_id, String url) {
    return GestureDetector(
      onTap: () async {
        print("gameZopWebViewUrl $gameZopWebViewUrl");

        //FIREBASE EVENT

        Navigator.pop(context);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => TamashaWebView(
              gameZopWebViewUrl,
              "${widget.gameId}",
              event_id,
              "${gamezopEventListCubit!.state.tamashaEventListR![index].entryFee!.value! > 0?gamezopEventListCubit!.state.tamashaEventListR![index].entryFee!.value!~/100:"0"}",
            ),
          ),
        );

        /*   Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => GameJobWebview(
                gameZopWebViewUrl,
                gameid,
                event_id,
                "${_contestModel.entry.fee.value > 0 ? _contestModel.entry.fee.value ~/ 100 : "Free"}",
                url),
          ),
        );*/
      },
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 34),
          height: 50,
          width: 180,
          decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill, image: AssetImage(ImageRes().submit)),
            // color: AppColor().colorPrimary,
          ),
          child: Center(
            child: Text(
              values,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 18.0,
                  fontStyle: FontStyle.normal,
                  color: Colors.white),
            ),
          )),
    );
  }

  void showWinningBreakupDialog(BuildContext context, int? amountWIN) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Wrap(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text(
                            "WINNING BREAKUP",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: "UltimaPro",
                                color: Colors.white),
                          ),
                        ),
                        new IconButton(
                            icon: const Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.pop(navigatorKey.currentState!.context);
                            })
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Total Amount",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18.0,
                          fontStyle: FontStyle.normal,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "\u{20B9} ${amountWIN}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontStyle: FontStyle.normal,
                        color: AppColor().colorPrimary,
                      ),
                    ),
                    getWeightView(amountWIN!)
                  ],
                ),
              ),
            ],
          );
        });
  }

  Widget getWeightView(int amountWIN) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Rank 1",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16, fontFamily: "UltimaPro", color: Colors.white),
            ),
            Text(
              "\u{20B9} ${amountWIN}",
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 16, fontFamily: "UltimaPro", color: Colors.white),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          width: double.infinity,
          height: 1,
          color: Colors.grey,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Rank 2",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16, fontFamily: "UltimaPro", color: Colors.white),
            ),
            const Text(
              "\u{20B9} 0",
              //"${list[index].amount.isBonuseType()?list[index].amount.value :"\u{20B9} ${(list[index].amount.value)}"}",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16, fontFamily: "UltimaPro", color: Colors.white),
            ),
          ],
        ),
      ],
    );
  }
}
