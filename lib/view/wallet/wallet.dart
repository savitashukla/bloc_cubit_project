import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cubit_project/res/AppColor.dart';
import 'package:cubit_project/res/ImageRes.dart';
import 'package:cubit_project/utils/logger_utils.dart';
import 'package:cubit_project/utils/weight/help_weight.dart';
import 'package:cubit_project/view_model/cubit/wallet/wallet_cubit.dart';
import 'package:cubit_project/view_model/cubit/wallet/wallet_equatable.dart';

import '../../data/route/Routes.dart';
import '../../view_model/cubit/loot_box_cubit/loot_box_cubit.dart';

class Wallet extends StatefulWidget {
  Wallet({Key? key}) : super(key: key);

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  final TextEditingController controller = TextEditingController();

  WalletCubit? walletCubit;

  String? enterAmountV;

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    // TODO: implement initState

    walletCubit = context.read<WalletCubit>();

    walletCubit!.init();
    // walletCubit!.getWithdrawalData();
    super.initState();
  }

  Future<bool> onWillPop() async {
    SystemNavigator.pop();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: () {
        return Future.delayed(const Duration(seconds: 2), () async {
          walletCubit!.getWalletData();
          walletCubit!.getWithdrawalData();
        });
      },
      child: SafeArea(
          child: WillPopScope(
        onWillPop: onWillPop,
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: BlocBuilder<WalletCubit, WalletEquatable>(
              builder: (BuildContext context, state) {
                return SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      Container(
                          margin: const EdgeInsets.only(
                              left: 14, right: 14, top: 26),
                          width: MediaQuery.of(context).size.width,
                          height: 320,
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              color: AppColor().colorPrimaryLight2),
                          child: Column(
                            children: [
                              const SizedBox(height: 32),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image(
                                      height: 87,
                                      width: 87,
                                      image: AssetImage(
                                          ImageRes().earnzoCoinIcon)),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                 Padding(padding: EdgeInsets.only(top: 13),
                                   child:  state.walletCoin != null
                                       ? HelpWeight().testMethod(
                                       48.0,
                                       FontWeight.w900,
                                       AppColor().textColorLight2,
                                       "${state.walletCoin!.balance}")
                                       : HelpWeight().testMethod(
                                       48.0,
                                       FontWeight.w900,
                                       AppColor().textColorLight2,
                                       "0"),


                                 )
                                ],
                              ),
                              const SizedBox(height: 19),
                              Container(
                                // padding: EdgeInsets.only(bottom: 0),
                                margin: const EdgeInsets.symmetric(horizontal: 25),
                                height: 52,

                                child: TextField(
                                  controller: controller,
                                  textAlign: TextAlign.start,
                                  textAlignVertical: TextAlignVertical.bottom,
                                  onTap: () {},
                                  style: TextStyle(color: AppColor().colorGray, fontFamily: "UltimaPro"),
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: const EdgeInsets.fromLTRB(28.0, 0.0, 00.0, 18.0),

                                      filled: true,
                                      fillColor: AppColor().colorPrimaryLight,
                                      hintStyle: TextStyle(
                                        color: AppColor().whiteColor,
                                        fontFamily: "UltimaPro",
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide:
                                        BorderSide(color: AppColor().colorPrimaryLight, width: 1.5),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide:
                                        BorderSide(color: AppColor().colorPrimaryLight, width: 1.5),
                                      ),
                                      hintText: "Enter Your Amount"),
                                  onChanged: (text) {
                                    // walletCubit!.enterUPIValues(text);
                                    //  Utils().customPrint("First text field: $text");
                                  },
                                  autofocus: false,
                                ),
                              ),
                              const SizedBox(height: 20),
                              state.walletCoin != null
                                  ? HelpWeight().testMethod(
                                      16.0,
                                      FontWeight.w900,
                                      AppColor().textColorLight2,
                                      "${state.walletCoin!.balance}  Coins = ${state.walletCoin!.balance! ~/ 10} Rs")
                                  : HelpWeight().testMethod(
                                      16.0,
                                      FontWeight.w900,
                                      AppColor().textColorLight2,
                                      ""),
                              /*  HelpWeight().testMethod(
                                      16.0,
                                      FontWeight.w900,
                                      AppColor().textColorLight2,
                                      "100 Coins = 10.00 Rs"),*/
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          context.read<LootBoxCubit>().changeIndex(0);
                                        /*  if (controller.text.length > 0) {
                                            if (walletCubit!.state.upiLink !=
                                                null) {
                                              showBottomWithdrwa(context);
                                            } else {
                                              showBottomSheetInfo(context);
                                            }
                                          } else {
                                            Fluttertoast.showToast(
                                                msg: "Enter Your Amount");
                                          }*/
                                          print("pay data here");
                                        },
                                        child: HelpWeight().buttonCreate(
                                            "Play & Earn",
                                            14.0,
                                            const Color(0xff46558c),
                                            const Color(0xff1e2540),AppColor().whiteColor)

                                        /*Container(
                                                height: 35,
                                                decoration: const BoxDecoration(
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(10)),
                                                    color: Color(0xff46558c)),
                                                child: Center(
                                                  child: HelpWeight().testMethod(
                                                      20.0,
                                                      FontWeight.w900,
                                                      AppColor().buttonText,
                                                      "Play & Earn"),
                                                ))*/
                                        ,
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: HelpWeight().testMethod(
                                          20.0,
                                          FontWeight.w900,
                                          AppColor().colorPrimaryLightMore,
                                          "OR"),
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          if (controller.text.length > 0) {
                                            if (walletCubit!.state.upiLink !=
                                                null) {
                                              showBottomWithdrwa(context);
                                            } else {
                                              showBottomSheetInfo(context);
                                            }
                                          } else {
                                            Fluttertoast.showToast(
                                                msg: "Enter Your Amount");
                                          }
                                        },
                                        child: HelpWeight().buttonCreate(
                                            "Redeem",
                                            14.0,
                                            const Color(0xff1a8415),
                                            const Color(0xff0b541b),AppColor().whiteColor)
                                        /*Container(
                                                height: 35,
                                                decoration: const BoxDecoration(
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(10)),
                                                    color: Color(0xff46558c)),
                                                child: Center(
                                                  child: HelpWeight().testMethod(
                                                      20.0,
                                                      FontWeight.w900,
                                                      AppColor().buttonText,
                                                      "Redeem"),
                                                ))*/
                                        ,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )),
                      const SizedBox(
                        height: 26,
                      ),
                      InkWell(
                        onTap: () {
                          // LocalNotificationService.showNotificationWithDefaultSound("call nere");

                          Navigator.pushNamed(context, Routes.transaction);
                        },
                        child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 14),
                            width: 401,
                            height: 61,
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                color: Color(0xff46558c)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Text("Transaction History",
                                      style: TextStyle(
                                          color: Color(0xffe3e3e3),
                                          fontWeight: FontWeight.w900,
                                          fontFamily: "UltimaPro",
                                          fontStyle: FontStyle.normal,
                                          fontSize: 20.0),
                                      textAlign: TextAlign.left),

                                  Text(">",
                                      style: TextStyle(
                                          color: Color(0xffe3e3e3),
                                          fontWeight: FontWeight.w900,
                                          fontFamily: "UltimaPro",
                                          fontStyle: FontStyle.normal,
                                          fontSize: 20.0),
                                      textAlign: TextAlign.right),


                                 /* Image(
                                      image: AssetImage(ImageRes().arrowRight))*/
                                ],
                              ),
                            )),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // faq Com.......
                      /* Container(
                          margin: const EdgeInsets.symmetric(horizontal: 14),
                          width: 401,
                          height: 61,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              color: Color(0xff46558c)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, right: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text("FAQ",
                                    style: TextStyle(
                                        color: Color(0xffe3e3e3),
                                        fontWeight: FontWeight.w900,
                                        fontFamily: "UltimaPro",
                                        fontStyle: FontStyle.normal,
                                        fontSize: 20.0),
                                    textAlign: TextAlign.left),
                                Image(image: AssetImage(ImageRes().arrowRight))
                              ],
                            ),
                          )),
                      const SizedBox(
                        height: 10,
                      ),*/
                     /* InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.reword);
                          //  Navigator.pushNamed(context, Routes.reword);
                        },
                        child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 14),
                            width: 401,
                            height: 61,
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                color: Color(0xff46558c)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text("Refer & Earn",
                                      style: TextStyle(
                                          color: Color(0xffe3e3e3),
                                          fontWeight: FontWeight.w900,
                                          fontFamily: "UltimaPro",
                                          fontStyle: FontStyle.normal,
                                          fontSize: 20.0),
                                      textAlign: TextAlign.left),
                                  Image(
                                      image: AssetImage(ImageRes().arrowRight))
                                ],
                              ),
                            )),
                      ),*/
                    ],
                  ),
                );
              },
            )),
      )),
    );
  }

  Widget _editTitleTextFieldNumber() {
    controller.selection = TextSelection.fromPosition(
        TextPosition(offset: controller.text.length));
    return Container(
      // padding: EdgeInsets.only(bottom: 0),
      margin: const EdgeInsets.symmetric(horizontal: 25),
      height: 52,

      child: TextField(
        controller: controller,
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.bottom,
        onTap: () {},
        style: TextStyle(color: AppColor().colorGray, fontFamily: "UltimaPro"),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            border: InputBorder.none,
            filled: true,
            contentPadding: const EdgeInsets.fromLTRB(28.0, 0.0, 00.0, 18.0),

            fillColor: AppColor().colorPrimaryLight,
            hintStyle: TextStyle(
              color: AppColor().whiteColor,
              fontFamily: "UltimaPro",
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),

              borderSide:
                  BorderSide(color: AppColor().colorPrimaryLight, width: 1.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide:
                  BorderSide(color: AppColor().colorPrimaryLight, width: 1.5),
            ),
            hintText: "Enter Your Amount"),
        onChanged: (text) {
          // walletCubit!.enterUPIValues(text);
          //  Utils().customPrint("First text field: $text");
        },
        autofocus: false,
      ),
    );
  }

  void showBottomSheetInfo(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Wrap(
              children: [
                Container(
                  height: 220,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Stack(
                          children: [
                            Container(
                              height: 220,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: const Color(0xff46558c),
                                  // Set the border color to red
                                  width: 4,
                                ),
                              ),
                            ),
                            Container(
                              height: 220,
                              margin: const EdgeInsets.only(top: 4, right: 3),
                              // Adjust the margin as needed to control the border thickness
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                  color: Color(
                                      0xffd9d9d9) // Set the background color of the container
                                  ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Padding(
                                        padding: EdgeInsets.only(top: 20),
                                        child: Text("Add UPI Address",
                                            style: TextStyle(
                                                color: Color(0xff46558c),
                                                fontWeight: FontWeight.w900,
                                                fontFamily: "UltimaPro",
                                                height: 1.0,
                                                fontStyle: FontStyle.normal,
                                                fontSize: 16.0),
                                            textAlign: TextAlign.center),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    // padding: EdgeInsets.only(bottom: 0),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 25),
                                    height: 52,

                                    child: TextField(
                                      textAlign: TextAlign.start,
                                      autofocus: true,
                                      textAlignVertical:
                                          TextAlignVertical.bottom,
                                      onTap: () {},
                                      style: TextStyle(
                                          color: AppColor().colorGray,
                                          fontWeight: FontWeight.w900,

                                          fontFamily: "UltimaPro"),
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          contentPadding: const EdgeInsets.fromLTRB(24.0, 0.0, 00.0, 18.0),

                                          filled: true,
                                          fillColor: AppColor().whiteColor,
                                          hintStyle: TextStyle(
                                            color: AppColor().editTestColor,
                                            fontWeight: FontWeight.w900,

                                            fontFamily: "UltimaPro",
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            borderSide: BorderSide(
                                                color: AppColor()
                                                    .colorPrimaryLight,
                                                width: 1.5),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            borderSide: BorderSide(
                                                color: AppColor()
                                                    .colorPrimaryLight,
                                                width: 1.5),
                                          ),
                                          hintText: "Enter UPI ID"),
                                      onChanged: (text) {
                                        walletCubit!.enterUPIValues(text);
                                        //walletCubit!.updatteUPI(text);

                                        //  Utils().customPrint("First text field: $text");
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  const Text(
                                      "*This UPI will be used for all your future transactions*",
                                      style: TextStyle(
                                          color: Color(0xffff0000),
                                          fontWeight: FontWeight.w700,
                                          fontFamily: "UltimaPro",
                                          fontStyle: FontStyle.normal,
                                          fontSize: 12.0),
                                      textAlign: TextAlign.center),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (walletCubit!.state.upiLink != null) {
                                        walletCubit!.getWithdrawalClick(
                                            controller.text);
                                      } else {
                                        if (walletCubit!.state.enterUPIValues !=
                                            null) {
                                          walletCubit!
                                              .getWithdrawalUPI(context);
                                        } else {
                                          Fluttertoast.showToast(
                                              msg: "Enter Your UPI Id");
                                        }

                                        //Fluttertoast.showToast(msg: "Enter Upi ID");
                                      }
                                    },
                                    child: HelpWeight().buttonCreate(
                                        "PROCEED",
                                        16.0,
                                        AppColor().textColorLight,
                                        AppColor().buttonShadowC,AppColor().whiteColor),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5, right: 3),
                            child: Container(
                              width: 26,
                              height: 26,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xff46558c)),
                              child: InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Center(
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 3, left: 1),
                                      child: Text("X",
                                          style: TextStyle(
                                              color: Color(0xffffffff),
                                              fontWeight: FontWeight.w900,
                                              fontFamily: "UltimaPro",
                                              fontStyle: FontStyle.normal,
                                              fontSize: 16.0),
                                          textAlign: TextAlign.left),
                                    ),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  void showBottomSheetEditUPI(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Wrap(
              children: [
                Container(
                  width: double.infinity,
                  height: 220,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Stack(
                          children: [
                            Container(
                              height: 220,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: const Color(0xff46558c),
                                  // Set the border color to red
                                  width: 4,
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 4, right: 3),
                              // Adjust the margin as needed to control the border thickness
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                  color: Color(
                                      0xffd9d9d9) // Set the background color of the container
                                  ),

                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Padding(
                                        padding: EdgeInsets.only(top: 20),
                                        child: Text("Add UPI Address",
                                            style: TextStyle(
                                                color: Color(0xff46558c),
                                                fontWeight: FontWeight.w900,
                                                fontFamily: "UltimaPro",
                                                height: 1.0,
                                                fontStyle: FontStyle.normal,
                                                fontSize: 16.0),
                                            textAlign: TextAlign.center),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    // padding: EdgeInsets.only(bottom: 0),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 25),
                                    height: 52,

                                    child: TextField(
                                      textAlign: TextAlign.start,
                                      textAlignVertical:
                                          TextAlignVertical.bottom,
                                      onTap: () {},
                                      style: TextStyle(
                                          color: AppColor().colorGray,
                                          fontWeight: FontWeight.w900,
                                          fontFamily: "UltimaPro"),
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          contentPadding: const EdgeInsets.fromLTRB(24.0, 0.0, 00.0, 18.0),

                                          filled: true,
                                          fillColor: AppColor().whiteColor,
                                          hintStyle: TextStyle(
                                            color: AppColor().editTestColor,
                                            fontWeight: FontWeight.w900,
                                            fontFamily: "UltimaPro",
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            borderSide: BorderSide(
                                                color: AppColor()
                                                    .colorPrimaryLight,
                                                width: 1.5),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            borderSide: BorderSide(
                                                color: AppColor()
                                                    .colorPrimaryLight,
                                                width: 1.5),
                                          ),
                                          hintText: "Enter UPI ID"),
                                      onChanged: (text) {
                                        walletCubit!.enterUPIValues(text);
                                        //walletCubit!.updatteUPI(text);

                                        //  Utils().customPrint("First text field: $text");
                                      },
                                      autofocus: false,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  const Text(
                                      "*This UPI will be used for all your future transactions*",
                                      style: TextStyle(
                                          color: Color(0xffff0000),
                                          fontWeight: FontWeight.w700,
                                          fontFamily: "UltimaPro",
                                          fontStyle: FontStyle.normal,
                                          fontSize: 12.0),
                                      textAlign: TextAlign.center),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (walletCubit!.state.enterUPIValues !=
                                          null) {
                                        walletCubit!
                                            .getWithdrawalUPIUpdate(context);
                                      } else {}
                                    },
                                    child: HelpWeight().buttonCreate(
                                        "PROCEED",
                                        16.0,
                                        AppColor().textColorLight,
                                        AppColor().buttonShadowC,AppColor().whiteColor),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5, right: 3),
                            child: Container(
                              width: 26,
                              height: 26,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xff46558c)),
                              child: InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Center(
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 3, left: 1),
                                      child: Text("X",
                                          style: TextStyle(
                                              color: Color(0xffffffff),
                                              fontWeight: FontWeight.w900,
                                              fontFamily: "UltimaPro",
                                              fontStyle: FontStyle.normal,
                                              fontSize: 16.0),
                                          textAlign: TextAlign.left),
                                    ),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  void showBottomWithdrwa(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Wrap(
            children: [
              Container(
                height: 170,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Stack(
                        children: [
                          Container(
                            height: 150,
                            decoration: BoxDecoration(
                              color: const Color(0xffd9d9d9),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: const Color(0xff46558c),
                                // Set the border color to red
                                width: 4,
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(top: 4, right: 3),
                            // Adjust the margin as needed to control the border thickness
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                                color: Color(
                                    0xffd9d9d9) // Set the background color of the container
                                ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.only(top: 20),
                                      child: Text("Your UPI",
                                          style: TextStyle(
                                              color: Color(0xff46558c),
                                              fontWeight: FontWeight.w900,
                                              fontFamily: "UltimaPro",
                                              height: 1.0,
                                              fontStyle: FontStyle.normal,
                                              fontSize: 16.0),
                                          textAlign: TextAlign.center),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    HelpWeight().testMethod(
                                        16.0,
                                        FontWeight.w900,
                                        AppColor().colorAccent,
                                        "${walletCubit!.state.upiLink}"),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    walletCubit!.state.upiData!.upi_array![0]
                                                .isUpdateByUser ==
                                            true
                                        ? const SizedBox(
                                            height: 0,
                                          )
                                        : InkWell(
                                            onTap: () {
                                              Navigator.pop(navigatorKey
                                                  .currentState!.context);
                                              showBottomSheetEditUPI(context);
                                              //  walletCubit!.getWithdrawalUPI(context);

                                              //Fluttertoast.showToast(msg: "Enter Upi ID");
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 2),
                                              child: Text("EDIT UPI",
                                                  style: TextStyle(
                                                      color: AppColor()
                                                          .buttonShadowBlue,
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      fontFamily: "UltimaPro",
                                                      decoration: TextDecoration
                                                          .underline,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontSize: 14.0),
                                                  textAlign: TextAlign.center),
                                            ),
                                          )
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                const Text(
                                    "*This UPI will be used for all your future transactions*",
                                    style: TextStyle(
                                        color: Color(0xffff0000),
                                        fontWeight: FontWeight.w700,
                                        fontFamily: "UltimaPro",
                                        fontStyle: FontStyle.normal,
                                        fontSize: 12.0),
                                    textAlign: TextAlign.center),
                                const SizedBox(
                                  height: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    if (walletCubit!.state.upiLink != null) {
                                      walletCubit!
                                          .getWithdrawalClick(controller.text);
                                    } else {
                                      if (walletCubit!.state.enterUPIValues !=
                                          null) {
                                        walletCubit!.getWithdrawalUPI(context);
                                      }

                                      //Fluttertoast.showToast(msg: "Enter Upi ID");
                                    }
                                  },
                                  child: HelpWeight().buttonCreate(
                                      "PROCEED",
                                      16.0,
                                      AppColor().textColorLight,
                                      AppColor().buttonShadowC,AppColor().whiteColor),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5, right: 3),
                          child: Container(
                            width: 26,
                            height: 26,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xff46558c)),
                            child: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 3, left: 1),
                                    child: Text("X",
                                        style: TextStyle(
                                            color: Color(0xffffffff),
                                            fontWeight: FontWeight.w900,
                                            fontFamily: "UltimaPro",
                                            fontStyle: FontStyle.normal,
                                            fontSize: 16.0),
                                        textAlign: TextAlign.left),
                                  ),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }
}
