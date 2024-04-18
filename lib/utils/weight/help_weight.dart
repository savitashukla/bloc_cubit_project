import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shimmer/shimmer.dart';

import '../../res/AppColor.dart';
import '../../res/ImageRes.dart';
import '../logger_utils.dart';

class HelpWeight {
  testMethod(var fontSize, var fontWeight, var colorsC, var textS) {
    return Text(
      '$textS',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: fontSize,
        fontFamily: "UltimaPro",
        color: colorsC,
        //  height: 1.0,
        fontWeight: fontWeight,
      ),
    );
  }

  buttonCreate(var textName, var fontSizeC,var colorsC,var buttonShadowC,testColor) {
    return Container(
      width: 140,
      height: 35,
      margin: const EdgeInsets.only(right: 0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: buttonShadowC,
              offset: const Offset(0, 3),
              blurRadius: 0,
              spreadRadius: 0)
        ],
        /*boxShadow: const [
          BoxShadow(
            offset: Offset(
              0.0,
              5.0,
            ),
            blurRadius: 3.2,
            spreadRadius: 0.3,
            color: Color(0xFFF19812),
            inset: true,
          ),
        ],*/
        color: colorsC,
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: Text(
        textName,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: fontSizeC,
            fontFamily: "UltimaPro",
            fontWeight: FontWeight.w900,
            color:testColor),
      ),
    );
  }


  flutterCustomToast(String messageC) {
    Fluttertoast.showToast(msg: messageC);
  }

  getSimmerWeight() {
   return Shimmer.fromColors(
      baseColor: Colors.grey.withOpacity(0.2),
      highlightColor: Colors.grey.withOpacity(0.4),
      enabled: true,
      child: ListView.builder(
          itemCount: 5,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.only(left: 13, right: 12),
              margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 5),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              width:
                  MediaQuery.of(navigatorKey.currentState!.context).size.width,
              height: 75,
            );
          }),
    );
  }


  getSimmerWeightGrid() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.withOpacity(0.2),
      highlightColor: Colors.grey.withOpacity(0.4),
      enabled: true,
      child: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 15,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          children: List.generate(3, (index) {
            return getAllGame();
          })),
    );
  }

  buttonCreateOnlyBorder(
      var textName, var colorsV, var fontWeight, var fontSizeC) {
    return Container(
      width: 191,
      height: 30,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: AppColor().textColorLight, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: Text(
        textName,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 16,
            fontFamily: "UltimaPro",
            fontWeight: FontWeight.w900,
            color: colorsV),
      ),
    );
  }

  void creatDealPopupError(String text) {
    showGeneralDialog(
      context: navigatorKey.currentState!.context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      pageBuilder: (_, __, ___) {
        return Center(
          child: Container(
            decoration: BoxDecoration(color: AppColor().colorPrimary
                /* image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(ImageRes().hole_popup_bg))*/
                ),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: 150,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Card(
              margin: const EdgeInsets.only(top: 25, bottom: 10),
              elevation: 0,
              //color: AppColor().wallet_dark_grey,
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.only(left: 12, right: 12),
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 0, top: 10, bottom: 30),
                      child: Text(
                        '$text',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 16,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Get.offAll(() => DashBord(4, ""));
                        Navigator.pop(navigatorKey.currentState!.context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 35,
                        margin: const EdgeInsets.only(
                            left: 0, right: 0, top: 10, bottom: 10),
                        width: MediaQuery.of(navigatorKey.currentState!.context)
                                .size
                                .width -
                            250,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              AppColor().textColorLight2,
                              AppColor().textColor,
                            ],
                          ),

                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(
                                0.0,
                                1.0,
                              ),
                              blurRadius: 1.0,
                              spreadRadius: .3,
                              color: AppColor().buttonShadowC,
                              //inset: true,
                            ),
                            const BoxShadow(
                              offset: Offset(00, 00),
                              blurRadius: 00,
                              color: Color(0xFFffffff),
                              //   inset: true,
                            ),
                          ],

                          border: Border.all(
                              color: AppColor().whiteColor, width: 2),
                          borderRadius: BorderRadius.circular(30),
                          // color: AppColor().whiteColor
                        ),
                        child: const Text(
                          "OK",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontFamily: "Nunito",
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  getAllGame() {
   return Container(
        width: 132,
        height: 132.998,
       decoration: const BoxDecoration(
         color: Colors.white,
         borderRadius: BorderRadius.all(Radius.circular(15)),
       ));
  }


  void tamashaLHistoryPending() {
    showGeneralDialog(
      context: navigatorKey.currentState!.context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      //barrierColor: Colors.black.withOpacity(0.5),
      // transitionDuration: Duration(milliseconds: 200),
      pageBuilder: (_, __, ___) {
        return Center(
          child: Container(
            decoration: BoxDecoration(
              color: AppColor().textColorLight
               /* image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(ImageRes().))*/),
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: 170,
            child: Card(
              margin: EdgeInsets.only(top: 20, bottom: 10),
              elevation: 0,
              //color: AppColor().wallet_dark_grey,
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.only(left: 12, right: 12),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Text(
                        "Some results may take some time to get updated please wait a few minutes and check again",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: "Montserrat",
                            color: AppColor().whiteColor),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () async {
                        Navigator.of(navigatorKey.currentState!.context).pop();
                      },
                      child: Container(
                        width: 150,
                        height: 40,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(ImageRes().submit)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text("OKAY",
                              style: TextStyle(
                                color: AppColor().whiteColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                                fontFamily: "Montserrat",
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            margin: EdgeInsets.symmetric(horizontal: 20),
          ),
        );
      },
    );
  }

  static void alertLimitExhausted() {
    showGeneralDialog(
      context: navigatorKey.currentState!.context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      //barrierColor: Colors.black.withOpacity(0.5),
      // transitionDuration: Duration(milliseconds: 200),
      pageBuilder: (_, __, ___) {
        return Center(
          child: Container(
            decoration: BoxDecoration(
              color: AppColor().colorPrimary
 /*               image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(ImageRes().hole_popup_bg))*/),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: 200,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Card(
              margin: const EdgeInsets.only(top: 25, bottom: 10),
              elevation: 0,
              //color: AppColor().wallet_dark_grey,
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.only(left: 12, right: 12),
                child: Column(
                  children: [
                    const Padding(
                      padding:
                      EdgeInsets.only(left: 0, top: 10, bottom: 20),
                      child: Text(
                        'Daily Limit Reached, \n Contact Support To increase the Limit',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(navigatorKey.currentState!.context);

                        //UserController controller = Get.put(UserController());
                      //  controller.SetFreshchatUser();
                     //   Freshchat.showFAQ();
                        // Get.offAll(() => DashBord(4, ""));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 35,
                        margin: const EdgeInsets.only(
                            left: 0, right: 0, top: 10, bottom: 10),
                        width: MediaQuery.of(navigatorKey.currentState!.context)
                            .size
                            .width -
                            250,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              AppColor().greenColorLight,
                              AppColor().greenColor,
                            ],
                          ),

                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(
                                0.0,
                                1.0,
                              ),
                              blurRadius: 1.0,
                              spreadRadius: .3,
                              color: Color(0xFF067906),
                              //inset: true,
                            ),
                            BoxShadow(
                              offset: Offset(00, 00),
                              blurRadius: 00,
                              color: Color(0xFFffffff),
                              //inset: true,
                            ),
                          ],

                          border: Border.all(
                              color: AppColor().whiteColor, width: 2),
                          borderRadius: BorderRadius.circular(30),
                          // color: AppColor().whiteColor
                        ),
                        child: const Text(
                          "Contact Support",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontFamily: "Nunito",
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
