import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:cubit_project/model/gameEventList/pre_join_event.dart';
import 'package:cubit_project/utils/help_method.dart';
import 'package:cubit_project/utils/helper_progressbar.dart';
import 'package:cubit_project/view_model/cubit/gamezop_game_list/gamezop_event_list_cubit.dart';
import 'package:cubit_project/view_model/cubit/gamezop_game_list/gamezop_event_list_equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../data/service/api_url.dart';
import '../../data/service/web_services_helper.dart';
import '../../res/AppColor.dart';
import '../../res/AppString.dart';
import '../../res/ImageRes.dart';
import '../../utils/logger_utils.dart';
import '../../utils/weight/help_weight.dart';
import 'game_cricket_webview.dart';

class CricketGameList extends StatefulWidget {
  String gameId;

  CricketGameList(this.gameId, {Key? key}) : super(key: key);

  @override
  State<CricketGameList> createState() => _CricketGameListState();
}

class _CricketGameListState extends State<CricketGameList> {
  GamezopEventListCubit? gamezopEventListCubit;
  var scrollcontroller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    gamezopEventListCubit = context.read<GamezopEventListCubit>();
    gamezopEventListCubit!.callEventList();
    gamezopEventListCubit!.init();

    gamezopEventListCubit!.getGameEventListCricket(widget.gameId);
    gamezopEventListCubit!.getBanner("${widget.gameId}");
    gamezopEventListCubit!.paginationCurrentPage(0);

    scrollcontroller.addListener(() {
      if (scrollcontroller.position.atEdge &&
          scrollcontroller.position.pixels != 0) {
        print(
            "call pagination data ${gamezopEventListCubit!.state.totalLimit} and li${gamezopEventListCubit!.state.currentPage}");
        if (gamezopEventListCubit!.state.totalLimit >
            gamezopEventListCubit!.state.currentPage) {
          //   currentpage.value = currentpage.value + 10;
          gamezopEventListCubit!.paginationCurrentPage(
              gamezopEventListCubit!.state.currentPage + 10);

          gamezopEventListCubit!.getUnityHistoryOnly(widget.gameId);
        }
        //     Utils().customPrint("data pagination");
      }
    });

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
              controller: scrollcontroller,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      HelpWeight().flutterCustomToast('banner click!');
                      HelpMethod().customPrint('banner click!');
                      if (state.bannerModelR != null &&
                          state.bannerModelR!.data != null &&
                          state.bannerModelR!.data!.length >= 1 &&
                          state.bannerModelR!.data![0].name!
                                  .compareTo("lootbox_refferal") ==
                              0) {
                        //wallet page call
                        /* WalletPageController walletPageController =
                        Get.put(WalletPageController());
                        walletPageController.getAdvertisersDeals();
                        AppString.isClickFromHome = false;
                        Get.to(() => OfferWallScreen());
                        await walletPageController.getUserDeals();*/
                      }
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
                                          Duration(milliseconds: 1000),
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
                            baseColor: Colors.grey.withOpacity(0.2),
                            highlightColor: Colors.grey.withOpacity(0.4),
                            enabled: true,
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
                                gamezopEventListCubit!.getGameEventListCricket(
                                    "${widget.gameId}");
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
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: "UltimaPro",
                                color: Colors.white),
                          )
                        : const Text(""),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Visibility(
                    visible: state.checkTurnOffGameZopEvent,
                    child: state.gameEventListRCricket != null
                        ? state.gameEventListRCricket!.data != null
                            ? ListView.builder(
                                itemCount:
                                    state.gameEventListRCricket?.data?.length,
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
                        ? state.gameEventListHistoryR!.length > 1
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
      child: Container(
        margin: const EdgeInsets.only(bottom: 5, top: 10, right: 10, left: 10),
        decoration: BoxDecoration(
            border: Border.all(color: AppColor().textColorLight, width: 1),
            // color: AppColor().whiteColor,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15, top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  gamezopEventListCubit!.state.gameEventListHistoryR![index]
                              .opponents!.length >
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
               /*   Text(
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
                child: gamezopEventListCubit!.state
                                .gameEventListHistoryR![index].rounds!.length >
                            0 &&
                        gamezopEventListCubit!
                                .state
                                .gameEventListHistoryR![index]
                                .rounds![0]
                                .result !=
                            null
                    ? gamezopEventListCubit!.state.gameEventListHistoryR![index]
                                    .isWinner !=
                                null &&
                            gamezopEventListCubit!.state
                                    .gameEventListHistoryR![index].isWinner ==
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
                          image: AssetImage(ImageRes().cricket),
                        ),
                        Container(
                          width: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: (gamezopEventListCubit!
                                          .state.gameEventListHistoryR !=
                                      null &&
                                  gamezopEventListCubit!
                                          .state.gameEventListHistoryR!.length >
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
                                  style: const TextStyle(color: Colors.white),
                                )
                              : const Text(""),
                        ),
                      ],
                    ),
                    Text(
                      gamezopEventListCubit!.state.gameEventListHistoryR![index]
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
      ),
    );
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
                            image: "64b14d7e64c1d7e7f5c849d1".compareTo("${widget.gameId}")==0?

                            AssetImage(
                                ImageRes().cards):"64b14ab8bfb189357219453f".compareTo("${widget.gameId}")==0?

                            AssetImage(
                                ImageRes().fruitchep):"62de6babd6fc1704f21b0aaf".compareTo("${widget.gameId}")==0? AssetImage(
                                ImageRes().guns_bottols):AssetImage(
                                ImageRes().cricket)
                        )


                    )),
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
                            "${gamezopEventListCubit!.state.gameEventListRCricket!.data![index].winner!.prizeAmount!.value! ~/ 100}",
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
                            .state.gameEventListRCricket!.data![index].id,
                        context);
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

  Widget triviaListotherGame(BuildContext context, int index) {
    return Container(
        child: gamezopEventListCubit!.state.gameEventListRCricket!.data![index]
                    .entry!.feeBonusPercentage! >=
                100
            ? GestureDetector(
                onTap: () async {
                  getPreJoinEventGameZob(
                      index,
                      gamezopEventListCubit!
                          .state.gameEventListRCricket!.data![index].id,
                      context);

                  /*  if (AppString.joiænContest.value == 'inactive') {
              Fluttertoast.showToast(msg: 'Join contest disable!');
              return;
            }

            _contestModel = controller.unityEventList.value.data[index];
            getPreJoinEventGameZob(
                controller.unityEventList.value.data[index].id,
                context,
                controller.unityEventList.value.data[index].entry.fee
                    .type ==
                    'bonus'
                    ? controller
                    .unityEventList.value.data[index].entry.fee.value
                    : controller.unityEventList.value.data[index].entry.fee
                    .value ~/
                    100);*/
                },
                child: Stack(
                  children: [
                    Container(
                        height: 130,
                        margin: const EdgeInsets.only(
                            bottom: 5, top: 30, right: 5, left: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: AppColor().textColorLight, width: 1),
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage(ImageRes().gameListBg))),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 10, right: 10, left: 10),
                          child: Wrap(
                            children: [
                              Container(
                                height: 10,
                              ),
                              Stack(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          gamezopEventListCubit!
                                              .state
                                              .gameEventListRCricket!
                                              .data![index]
                                              .name!
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
                                                  .state
                                                  .gameEventListRCricket!
                                                  .data![index]
                                                  .id,
                                              context);
                                        },
                                        child: Container(
                                          width: 120,
                                          margin:
                                              const EdgeInsets.only(right: 10),
                                          height: 35,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: AssetImage(
                                                      ImageRes().gameListBonus)
                                                  /* image: AssetImage(
                                                "assets/images/orange_gradient_back.png")*/
                                                  ),
                                              /*        border: Border.all(
                                            width: 2, color: AppColor().whiteColor),*/
                                              //color: AppColor().colorPrimary,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
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
                                                    color:
                                                        AppColor().whiteColor),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    right: 10, left: 10),
                                                child: gamezopEventListCubit!
                                                            .state
                                                            .gameEventListRCricket!
                                                            .data![index]
                                                            .entry!
                                                            .fee!
                                                            .value! >
                                                        0
                                                    ? Text(
                                                        gamezopEventListCubit!
                                                                    .state
                                                                    .gameEventListRCricket!
                                                                    .data![
                                                                        index]
                                                                    .entry!
                                                                    .fee!
                                                                    .type ==
                                                                'bonus'
                                                            ? gamezopEventListCubit!
                                                                .state
                                                                .gameEventListRCricket!
                                                                .data![index]
                                                                .entry!
                                                                .fee!
                                                                .value
                                                                .toString()
                                                            : "${AppString().txtCurrencySymbol} ${gamezopEventListCubit!.state.gameEventListRCricket!.data![index].entry!.fee!.value! ~/ 100}",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontFamily: "Inter",
                                                            color: AppColor()
                                                                .whiteColor),
                                                      )
                                                    : Text(
                                                        "Free",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontFamily: "Inter",
                                                            color: AppColor()
                                                                .whiteColor),
                                                      ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 25, left: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Win",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 19,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontFamily: "UltimaPro",
                                                      color: AppColor()
                                                          .whiteColor),
                                                ),
                                                Container(
                                                  width: 5,
                                                ),
                                              ],
                                            ),
                                            Container(
                                              height: 10,
                                            ),
                                            /* Container(
                                      width: 60,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1,
                                              color: AppColor().color_side_menu_header),
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                      child:*/
                                            Center(
                                              child: Text(
                                                "\u{20B9} ${gamezopEventListCubit!.state.gameEventListRCricket!.data![index].winner!.prizeAmount!.value! ~/ 100}",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 19,
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: "UltimaPro",
                                                    color:
                                                        AppColor().whiteColor),
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
                                padding: const EdgeInsets.only(
                                    bottom: 8, left: 10, top: 5),
                                height: 33,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10)),
                                  // color: AppColor().whiteColor,
                                  color: Colors.transparent,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        /*   showWinningBreakupDialog(
                                      context,
                                      controller.unityEventList.value
                                          .data[index]);*/
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          "Bonus cash Used ",
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "UltimaPro",
                                            color: Colors.white70,
                                          ),
                                        ),
                                        Container(
                                            child: CircleAvatar(
                                          radius: 8.0,
                                          // child: Image.asset("assets/images/bonuscoin.webp"),
                                          backgroundColor: Colors.transparent,
                                          child: Image.asset(
                                              "assets/images/bonus_coin.png"),
                                        )),
                                        const Text(
                                          "000",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: "UltimaPro",
                                            color: Colors.white70,
                                          ),
                                        )
                                        /* Padding(
                                    padding: const EdgeInsets.only(
                                        right: 8.0, left: 5),
                                    child: _userController
                                        .getBonuseCashBalanceInt() >=
                                        controller.unityEventList.value
                                            .data[index].entry
                                            .getBonuse()
                                        ? Text(
                                      "${gamezopEventListCubit!.state.gameEventListRCricket!.data![index].entry!.getBonuse()}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: "UltimaPro",
                                        color: Colors.white70,
                                      ),
                                    )
                                        : Text(
                                      "${_userController.getBonuseCashBalanceInt()}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: "UltimaPro",
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ),*/
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 15),
                          height: 50,
                          width: MediaQuery.of(context).size.width - 165,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage(ImageRes().listGameTop))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // lottie_files
                              Container(
                                padding: const EdgeInsets.only(left: 0),
                                height: 60,
                                width: 65,
                                /* child: Lottie.asset(
                            'assets/lottie_files/lottie_fire.json',
                            repeat: true,
                            fit: BoxFit.fill,
                          ),*/
                              ),
                              Text(
                                "Match Of The Day",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: "UltimaPro",
                                    color: AppColor().whiteColor),
                              ),
                              Text(
                                "      ",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: "UltimaPro",
                                    color: AppColor().whiteColor),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            : GestureDetector(
                onTap: () async {
                  getPreJoinEventGameZob(
                      index,
                      gamezopEventListCubit!
                          .state.gameEventListRCricket!.data![index].id,
                      context);
                },
                child: Container(
                    height: 80,
                    margin: const EdgeInsets.only(
                        bottom: 5, top: 10, right: 10, left: 10),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: AppColor().textColorLight, width: 1.5),
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
                                        .state
                                        .gameEventListRCricket!
                                        .data![index]
                                        .name!
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
                                            .state
                                            .gameEventListRCricket!
                                            .data![index]
                                            .id,
                                        context);
                                  },
                                  child: Container(
                                    width: 120,
                                    margin: const EdgeInsets.only(right: 10),
                                    height: 35,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image:
                                                AssetImage(ImageRes().newPayNow)
                                            /* image: AssetImage(
                                          "assets/images/orange_gradient_back.png")*/
                                            ),
                                        /*        border: Border.all(
                                      width: 2, color: AppColor().whiteColor),*/
                                        //color: AppColor().colorPrimary,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                          padding: const EdgeInsets.only(
                                              right: 10, left: 10),
                                          child: gamezopEventListCubit!
                                                      .state
                                                      .gameEventListRCricket!
                                                      .data![index]
                                                      .entry!
                                                      .fee!
                                                      .value! >
                                                  0
                                              ? Text(
                                                  gamezopEventListCubit!
                                                              .state
                                                              .gameEventListRCricket!
                                                              .data![index]
                                                              .entry!
                                                              .fee!
                                                              .type ==
                                                          'bonus'
                                                      ? gamezopEventListCubit!
                                                          .state
                                                          .gameEventListRCricket!
                                                          .data![index]
                                                          .entry!
                                                          .fee!
                                                          .value
                                                          .toString()
                                                      : "${AppString().txtCurrencySymbol} ${gamezopEventListCubit!.state.gameEventListRCricket!.data![index].entry!.fee!.value! ~/ 100}",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontFamily: "UltimaPro",
                                                      color: AppColor()
                                                          .whiteColor),
                                                )
                                              : Text(
                                                  "Free",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontFamily: "UltimaPro",
                                                      color: AppColor()
                                                          .whiteColor),
                                                ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            /* Padding(
                              padding: const EdgeInsets.only(top: 25, left: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
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
                                      */ /* Container(
                                width: 60,
                                height: 30,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1,
                                        color: AppColor().color_side_menu_header),
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                                child:*/ /*
                                      Center(
                                        child: Text(
                                          "\u{20B9} ${gamezopEventListCubit!.state.gameEventListRCricket!.data![index].winner!.prizeAmount!.value! ~/ 100}",
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
                                      */ /*))*/ /*
                                    ],
                                  ),
                                ],
                              ),
                            ),*/
                          ],
                        ),
                        /* Container(
                          padding: const EdgeInsets.only(
                              bottom: 8, left: 10, top: 5),
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
                                onTap: () {},
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
                                  const Text(
                                    "Bonus cash Used ",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "UltimaPro",
                                      color: Colors.white70,
                                    ),
                                  ),
                                  Container(
                                      child: CircleAvatar(
                                    radius: 8.0,
                                    backgroundColor: Colors.transparent,
                                    child: Image.asset(
                                        "assets/images/bonus_coin.png"),
                                  )),
// only show bonus entry not check wallet condition
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 8.0, left: 5),
                                    child: Text(
                                      "${((gamezopEventListCubit!.state.gameEventListRCricket!.data![index].entry!.fee!.value! / 100 * gamezopEventListCubit!.state.gameEventListRCricket!.data![index].entry!.feeBonusPercentage!) / 100)}",
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontFamily: "UltimaPro",
                                        color: Colors.white70,
                                      ),
                                    ),
                                  )
                                  // bonus code here
                                  */ /*  Padding(
                              padding: const EdgeInsets.only(
                                  right: 8.0, left: 5),
                              child: _userController
                                  .getBonuseCashBalanceInt() >=
                                  controller.unityEventList.value
                                      .data[index].entry
                                      .getBonuse()
                                  ? Text(
                                "${gamezopEventListCubit!.state.gameEventListRCricket!.data![index].entry.g}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: "UltimaPro",
                                  color: Colors.white70,
                                ),
                              )
                                  : Text(
                                "${_userController.getBonuseCashBalanceInt()}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: "UltimaPro",
                                  color: Colors.white70,
                                ),
                              ),
                            ),*/ /*
                                ],
                              )
                            ],
                          ),
                        )*/
                      ],
                    )),
              ));
  }

  String getStartTimeHHMMSS(String? date_c) {
    return DateFormat("yyyy-MM-dd' 'HH:mm:ss").format(
        DateFormat("yyyy-MM-ddTHH:mm:ssZ").parse("$date_c", true).toLocal());
  }

  Future<void> getPreJoinEventGameZob(
      int index, String? event_id, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs!.getString("token");
    String? userId = prefs!.getString("userId");

    final param = {
      "userId": "$userId",
      "thirdParty": {"type": "freakx", "gameCode": ""}
      /*  "gameZopGameCode": "SkhljT2fdgb"*/
    };

    /*  final param = {
      "userId": userId,
      // "thirdParty": {"type": "gameZop", "gameCode": "SJRX12TXcRH"} //gameZob
      "thirdParty": {"type": "gameZop", "gameCode": "hgempP8Sc"} //gameZob
      //"thirdParty": {"type": "gameZop", "gameCode": "rkWfy2pXq0r"}//fruitChop
      */ /*  "gameZopGameCode": "SkhljT2fdgb"*/ /*
    };*/

    showProgress();

    Map<String, dynamic>? response = await WebServicesHelper()
        .getPreEventJoinGameJob(param, "$token", "$event_id");
    //print(' respone is finaly ${response}');
    hideProgress();
    if (response != null && response['statusCode'] == null) {
      //print(' respone is finaly1 ${response}');
      PreJoinEvent preJoinResponseModel = PreJoinEvent.fromJson(response);
      if (preJoinResponseModel.webViewUrl != null &&
          preJoinResponseModel.webViewUrl!.isNotEmpty) {
        Navigator.push(
          navigatorKey.currentState!.context,
          MaterialPageRoute(
            builder: (BuildContext context) => CricketWebView(
              preJoinResponseModel.webViewUrl,
              widget.gameId,
              event_id,
              "${gamezopEventListCubit!.state.gameEventListRCricket!.data![index].entry!.fee!.value! > 0 ? gamezopEventListCubit!.state.gameEventListRCricket!.data![index].entry!.fee!.value! ~/ 100 : "0"}",
            ),
          ),
        );
      }
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
                                "${gamezopEventListCubit!.state.gameEventListRCricket!.data![index].entry!.fee!.value! > 0 ? gamezopEventListCubit!.state.gameEventListRCricket!.data![index].entry!.fee!.value! ~/ 100 : "Free"}")
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
                  _Button(index, context, "CONFIRM",
                      preJoinResponseModel.webViewUrl, event_id, ""),
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

  Widget _Button(int index, BuildContext context, String values,
      String? gameZopWebViewUrl, String event_id, String url) {
    return GestureDetector(
      onTap: () async {
        print("gameZopWebViewUrl $gameZopWebViewUrl");

        //FIREBASE EVENT

        Navigator.pop(context);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => CricketWebView(
              gameZopWebViewUrl,
              widget.gameId,
              event_id,
              "${gamezopEventListCubit!.state.gameEventListRCricket!.data![index].entry!.fee!.value! > 0 ? gamezopEventListCubit!.state.gameEventListRCricket!.data![index].entry!.fee!.value! ~/ 100 : "0"}",
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
}
