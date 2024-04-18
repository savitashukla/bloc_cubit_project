import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freshchat_sdk/freshchat_sdk.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:cubit_project/res/ImageRes.dart';
import 'package:cubit_project/view/game/game.dart';
import 'package:cubit_project/view/wallet/wallet.dart';
import 'package:cubit_project/view_model/cubit/loot_box_cubit/loot_box_cubit.dart';

import '../../res/AppColor.dart';
import '../../view_model/cubit/game/game_cubit.dart';
import '../../view_model/cubit/gamezop_game_list/gamezop_event_list_cubit.dart';
import '../home/loot_box.dart';
import '../reword/reword.dart';
import '../wallet/transaction.dart';
import 'appbar_custom.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  var titile = "";

  GamezopEventListCubit? gameZopEventList;

  List<Widget> _children = [
    const Game(),
    const Reword(),
    LootBox(),
    const TransactionHistory(),
    Wallet(),
  ];

  @override
  void initState() {
    // TODO: implement initState

    gameZopEventList = context.read<GamezopEventListCubit>();
    gameZopEventList!.getProfileData();
    checkForUpdate();
    if (context
            .read<LootBoxCubit>()
            .state
            .onlyNumber!
            .compareTo("9829953786") ==
        0) {
      _children = [const Game()];
      context.read<LootBoxCubit>().changeIndex(0);
    } else {
      context.read<LootBoxCubit>().changeIndex(2);
      [
        const Game(),
        const Reword(),
        LootBox(),
        const TransactionHistory(),
        Wallet(),
      ];
    }

    super.initState();
  }

  Future<bool> onWillPop() async {
    Fluttertoast.showToast(msg: "msg call will pop");

    //  SystemNavigator.pop();
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GameCubit>(
          create: (context) => GameCubit(),
        ),
        /*    BlocProvider<WalletCubit>(
          create:  (context) => WalletCubit(),
        ),*/
      ],
      child: WillPopScope(
        onWillPop: () async {
          bool isPop = false;
          await showAlertDialog(context, (alertResponse) {
            Navigator.of(context).pop();
            // This will dismiss the alert dialog
            isPop = alertResponse;
          });
          return isPop;
        },
        child: SafeArea(child: BlocBuilder<LootBoxCubit, LootBoxEquatable>(
          builder: (BuildContext context, state) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: AppColor().colorPrimary,
              appBar: AppbarCustom(
                title: titile,
                menuicon: true,
                menuback: false,
                iconnotifiction: true,
                is_wallaticon: true,
                is_supporticon: false,
                is_whatsappicon: false,
              ),
              body: _children[state.currentIndex],
              bottomNavigationBar: context
                          .read<LootBoxCubit>()
                          .state
                          .onlyNumber!
                          .compareTo("9829953786") !=
                      0
                  ? BottomAppBar(
                      color: AppColor().bottomBar,
                      shape: const CircularNotchedRectangle(),
                      //shape of notch
                      notchMargin: 4,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, bottom: 8.0, right: 15, left: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                context.read<LootBoxCubit>().changeIndex(0);
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.only(right: 0, top: 0),
                                child: state.currentIndex == 0
                                    ? Column(

                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ImageIcon(
                                            AssetImage(ImageRes().gameIcoPng),
                                            color: AppColor().textColorLight,
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            "Game",
                                            style: TextStyle(
                                              color: AppColor().textColorLight,
                                              fontFamily: "UltimaPro",
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      )
                                    : Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ImageIcon(
                                            AssetImage(ImageRes().gameIcoPng),
                                            color: AppColor().whiteColor,
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            "Game",
                                            style: TextStyle(
                                              color: AppColor().whiteColor,
                                              fontSize: 12.0,
                                              fontFamily: "UltimaPro",
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                            ),
                            GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                context.read<LootBoxCubit>().changeIndex(1);
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.only(right: 0, top: 0),
                                child: state.currentIndex == 1
                                    ? Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ImageIcon(
                                            AssetImage(
                                                ImageRes().transferReferral),
                                            color: AppColor().textColorLight,
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            "Refer",
                                            style: TextStyle(
                                              color: AppColor().textColorLight,
                                              fontFamily: "UltimaPro",
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      )
                                    : Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ImageIcon(
                                            AssetImage(
                                                ImageRes().transferReferral),
                                            color: AppColor().whiteColor,
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            "Refer",
                                            style: TextStyle(
                                              color: AppColor().whiteColor,
                                              fontSize: 12.0,
                                              fontFamily: "UltimaPro",
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 25, left: 8),
                              padding: EdgeInsets.only(top: 0, left: 8),
                              child: Text(
                                "Earnzo",
                                style: TextStyle(
                                  fontSize: 12.0,

                                  fontFamily: "UltimaPro",
                                  color: state.currentIndex == 2
                                      ? AppColor().textColorLight
                                      : const Color(0xffFFFFFF),
                                  // fontFamily: "Montserrat",
                                ),
                              ),
                            ),
                            GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                // context.read<LootBoxCubit>().changeIndex(3);

                                gameZopEventList!.SetFreshchatUser();
                                Freshchat.showFAQ();
                              },
                              child: Container(
                                padding: const EdgeInsets.only(right: 0),
                                child: state.currentIndex == 3
                                    ? Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ImageIcon(
                                            AssetImage(ImageRes().support),
                                            color: AppColor().textColorLight,
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            "Support",
                                            style: TextStyle(
                                              color: AppColor().textColorLight,
                                              fontSize: 12.0,
                                              fontFamily: "UltimaPro",
                                            ),
                                          ),
                                        ],
                                      )
                                    : Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ImageIcon(
                                            AssetImage(ImageRes().support),
                                            color: AppColor().whiteColor,
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            "Support",
                                            style: TextStyle(
                                              color: AppColor().whiteColor,
                                              fontSize: 12.0,
                                              fontFamily: "UltimaPro",
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                            ),
                            GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                context.read<LootBoxCubit>().changeIndex(4);
                              },
                              child: Container(
                                padding: const EdgeInsets.only(right: 0),
                                child: state.currentIndex == 4
                                    ? Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ImageIcon(
                                            AssetImage(
                                                ImageRes().walletIconPng),
                                            color: AppColor().textColorLight,
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            "Wallet",
                                            style: TextStyle(
                                              color: AppColor().textColorLight,
                                              fontSize: 12.0,
                                              fontFamily: "UltimaPro",
                                            ),
                                          ),
                                        ],
                                      )
                                    : Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ImageIcon(
                                            AssetImage(
                                                ImageRes().walletIconPng),
                                            color: AppColor().whiteColor,
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            "Wallet",
                                            style: TextStyle(
                                              color: AppColor().whiteColor,
                                              fontSize: 12.0,
                                              fontFamily: "UltimaPro",
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : const SizedBox(height: 20),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    80,
                  ),
                  border: Border.all(
                    color: const Color(0xff263364),
                    width: 2,
                    style: BorderStyle.solid,
                  ),
                ),
                child: FloatingActionButton(
                  backgroundColor: AppColor().colorPrimaryLight,
                  onPressed: () async {
                    if (context
                            .read<LootBoxCubit>()
                            .state
                            .onlyNumber!
                            .compareTo("9829953786") ==
                        0) {
                      context.read<LootBoxCubit>().changeIndex(0);
                    } else {
                      context.read<LootBoxCubit>().changeIndex(2);
                    }
                  },
                  child: state.currentIndex == 2
                      ? Image.asset(
                          ImageRes().homePage,
                          height: 30,
                          fit: BoxFit.fill,
                          width: 30,
                        )
                      : Image.asset(
                          ImageRes().homePageWhite,
                          height: 30,
                          fit: BoxFit.fill,
                          width: 30,
                        ),
                ),
              ),
            );
          },
        )),
      ),
    );
  }


  Future<void> checkForUpdate() async {
    InAppUpdate.checkForUpdate().then((info) {
      setState(() {
        AppUpdateInfo _updateInfo = info;
        if (_updateInfo?.updateAvailability ==
            UpdateAvailability.updateAvailable) {
          InAppUpdate.performImmediateUpdate()
              .catchError((e) => Fluttertoast.showToast(msg: e.toString()));
        } else {
        // Fluttertoast.showToast(msg: "Update not Available");
        }
      });
    }).catchError((e) {
      print("checkForUpdate");
      print(e.toString());
      //showSnack(e.toString());
    });
  }

  Future showAlertDialog(
      BuildContext context, YesOrNoTapCallback isYesTapped) async {
    AlertDialog alert = AlertDialog(
      elevation: 24,
      content: const Text("Do you want to quit?"),
      actions: [
        TextButton(
            onPressed: () {
              SystemNavigator.pop();
              isYesTapped(true);
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
