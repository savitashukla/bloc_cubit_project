import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cubit_project/model/gameEventList/pre_join_event.dart';
import 'package:cubit_project/utils/help_method.dart';
import 'package:cubit_project/utils/logger_utils.dart';
import 'package:cubit_project/view/tamasha/game_tamasha_list.dart';
import 'package:cubit_project/view/tamasha/game_tamasha_webview.dart';
import 'package:cubit_project/view_model/cubit/gamezop_game_list/gamezop_event_list_cubit.dart';
import 'package:cubit_project/view_model/cubit/gamezop_game_list/gamezop_event_list_equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../res/AppColor.dart';
import '../../data/service/web_services_helper.dart';
import '../../res/ImageRes.dart';
import '../../utils/weight/help_weight.dart';

class Tamasha_Game_Over extends StatefulWidget {
  String? event_id;
  String? gameid;
  String? entry_fee;

  bool? isWinnerTrue;
  int? Score;

  Tamasha_Game_Over(this.gameid, this.event_id, this.entry_fee,
      this.isWinnerTrue, this.Score);

  @override
  State<Tamasha_Game_Over> createState() => _Tamasha_Game_OverState();
}

class _Tamasha_Game_OverState extends State<Tamasha_Game_Over>
    with SingleTickerProviderStateMixin {
  var user_name = "", user_photo = "";
  bool popB = false;

  bool cancel = false;

  SharedPreferences? prefs;
  String? user_id;
  String? token;

  late AnimationController transitionAnimation;

  PreJoinEvent? preJoinResponseModel;

  GamezopEventListCubit? gamezopEventListCubit;

/*  Match_Making_Screen_Controller match_Making_Screen_Controlleer =
      Get.put(Match_Making_Screen_Controller(event_id,gameid));*/

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getData();

    transitionAnimation = AnimationController(
      duration: const Duration(seconds: 40),
      vsync: this,
    );
    transitionAnimation!.repeat();
  }

  @override
  dispose() {
    transitionAnimation!.dispose(); // you need this
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<GamezopEventListCubit, GamezopEventListEquatable>(
          builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.transparent,
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
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                widget.isWinnerTrue == true
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          Container(
                              height: 130,
                              child:
                                  Image.asset("assets/images/you_won_image.png")),
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Stack(
                                alignment: Alignment.topCenter,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: const EdgeInsets.only(
                                        left: 8, top: 70, right: 15),
                                    padding:
                                        const EdgeInsets.only(bottom: 0, top: 0),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: AppColor().first_rank,
                                          width: 5,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColor().whiteColor),
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 60,
                                          ),
                                           Text(
                                            "${state.profileDataC!.username}",
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontFamily: "UltimaPro",
                                                color: Colors.black),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Text(
                                            "YOUR SCORE",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: "UltimaPro",
                                                color: Colors.black54),
                                          ),
                                          Text(
                                            "${widget.Score}",
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontFamily: "UltimaPro",
                                                color: Colors.black),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Container(
                                      height: 150,
                                      width: 150,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/images/second_circle.png")),
                                      ),
                                      child: state.profileDataC != null &&

                                          state.profileDataC!.photo!.url !=null
                                              ? Center(
                                            child: ClipRRect(
                                              borderRadius:
                                              const BorderRadius.all(
                                                Radius.circular(50),
                                              ),
                                              child: CachedNetworkImage(
                                                width: 85,
                                                height: 85,
                                                fit: BoxFit.fill,
                                                imageUrl:
                                                ("${state.profileDataC!.photo!.url}"),
                                              ),
                                            ),
                                          )
                                              :
                                          Container(
                                        height: 20,
                                        width: 20,
                                        child: Center(
                                            child: Image(
                                          height: 30,
                                          image:
                                              AssetImage(ImageRes().team_group),
                                        )),
                                      )
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 90,
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          Container(
                              height: 130,
                              child: Image.asset(
                                  "assets/images/you_lose_image.png")),
                          /*  Container(
                            height: 130,
                            child: Image.asset(
                                "assets/images/gameover_test.png")),*/
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Stack(
                                alignment: Alignment.topCenter,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: const EdgeInsets.only(
                                        left: 8, top: 70, right: 15),
                                    padding:
                                        const EdgeInsets.only(bottom: 0, top: 0),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: AppColor().second_rank,
                                          width: 5,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColor().whiteColor),
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 60,
                                          ),
                                           Text(
                                            "${state.profileDataC!.username}",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: "UltimaPro",
                                                color: Colors.black),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Text(
                                            "YOUR SCORE",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: "UltimaPro",
                                                color: Colors.black54),
                                          ),
                                          Text(
                                            "${widget.Score}",
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontFamily: "UltimaPro",
                                                color: Colors.black),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Container(
                                      height: 150,
                                      width: 150,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/images/second_circle.png")),
                                      ),
                                      child: /*Obx(
                                              () => user_photo.value != null &&
                                              user_photo.value.isNotEmpty &&
                                              user_photo.value != "-"
                                              ? Center(
                                            child: ClipRRect(
                                              borderRadius:
                                              BorderRadius.all(
                                                Radius.circular(50),
                                              ),
                                              child: CachedNetworkImage(
                                                width: 85,
                                                height: 85,
                                                fit: BoxFit.fill,
                                                imageUrl:
                                                ("${user_photo.value}"),
                                              ),
                                            ),
                                          )
                                              :*/
                                          Container(
                                        height: 20,
                                        width: 20,
                                        child: Center(
                                            child: Image(
                                          height: 30,
                                          image:
                                              AssetImage(ImageRes().team_group),
                                        )),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 90,
                          ),
                        ],
                      ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, bottom: 50),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 22),
                          child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  color: AppColor().colorPrimaryLight2,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 0),
                                    child: AnimatedBuilder(
                                      animation: transitionAnimation,
                                      builder: (context, child) {
                                        return SlideTransition(
                                            position: Tween<Offset>(
                                              begin: const Offset(-1, 0),
                                              end: const Offset(0, 0),
                                            ).animate(CurvedAnimation(
                                                curve: const Interval(.01, 0.25,
                                                    curve: Curves.easeIn),
                                                parent: transitionAnimation)),
                                            child: child);
                                      },
                                      child: Container(
                                        height: 50,
                                        width: MediaQuery.of(context).size.width,
                                        //    color:AppColor().colorPrimaryDark,
                                        decoration: BoxDecoration(
                                            color: AppColor().textColorLight,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      cancel = true;
                                      try {
                                        getPreJoinEventTamashaClick(
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
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Text(
                                            "Starting New Battle",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: "UltimaPro",
                                                color: Colors.white),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Container(
                                            width: 20,
                                            child: Image.asset(
                                                ImageRes().rupee_icon),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "${widget.entry_fee}",
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontFamily: "UltimaPro",
                                                color: Colors.white),
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                     TamashaGameList(widget.gameid),
                              ),
                            );
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                color: AppColor().whiteColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: "UltimaPro",
                                    color: AppColor().reward_card_bg),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )),
          ),
        );
      }),
    );
  }

  Future<void> getPreJoinEventTamasha(String contestId) async {
    //API Call

    if (token == null) {
      prefs = await SharedPreferences.getInstance();
      token = prefs!.getString("token")!;
    }
    final param = {
      "contestId": contestId,
    };
    Map<String, dynamic>? response =
        await WebServicesHelper().getTamashaWebView(token!, param);
    //Utils.launchURLApp(response_str["webViewUrl"]);
    //return;

    PreJoinEvent preJoinResponseModel = PreJoinEvent.fromJson(response!);

    HelpMethod().customPrint('["webViewUrl"]: ');
    if (preJoinResponseModel != null) {
      Future.delayed(const Duration(seconds: 6), () {
        if (cancel) {
          // cancel = false;
          //Get.offAll(() => GameJobList(gameid, url1, "Ludo"));
        } else {
          //RE PLAY event

          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => TamashaWebView(
                      preJoinResponseModel.webViewUrl,
                      widget.gameid,
                      widget.event_id,
                      widget.entry_fee)));
        }
      });
    }
  }

  Future<void> getPreJoinEventTamashaClick(String? contestId) async {
    //API Call
    if (token == null) {
      prefs = await SharedPreferences.getInstance();
      token = prefs!.getString("token")!;
    }
    final param = {
      "contestId": "$contestId",
    };
    Map<String, dynamic>? response_str =
        await WebServicesHelper().getTamashaWebView(token!, param);
    //Utils.launchURLApp(response_str["webViewUrl"]);
    //return;
    if (response_str != null) {
      PreJoinEvent webViewData = PreJoinEvent.fromJson(response_str);
      HelpMethod().customPrint('getCallGameUrlTamasha ${webViewData}');

      Navigator.pushReplacement(
          navigatorKey.currentState!.context,
          MaterialPageRoute(
              builder: (context) => TamashaWebView(webViewData!.webViewUrl,
                  widget.gameid, widget.event_id, widget.entry_fee)));
    }
  }

  Future<void> getData() async {
    gamezopEventListCubit = context.read<GamezopEventListCubit>();

    //  await gamezopEventListCubit!.getUnityHistoryOnly("${widget.gameid}");

   // getPreJoinEventTamasha("${widget.event_id}");
  }

  Future showAlertDialog(
      BuildContext context, YesOrNoTapCallback isYesTapped) async {
    AlertDialog alert = AlertDialog(
      elevation: 24,
      content: const Text("Do you want to quit?"),
      actions: [
        TextButton(
            onPressed: () {
              //cancel = true;
              Navigator.of(context).pop();
              Navigator.of(context).pop();

              Navigator.push(
                navigatorKey.currentState!.context,
                MaterialPageRoute(
                  builder: (BuildContext context) => TamashaGameList(
                    "${widget.gameid}",
                  ),
                ),
              );
              //  Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      TamashaGameList(widget.gameid),
                ),
              );
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
