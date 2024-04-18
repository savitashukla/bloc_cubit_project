import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:cubit_project/utils/help_method.dart';
import 'package:cubit_project/view_model/cubit/loot_box_cubit/loot_box_cubit.dart';

import '../../res/AppColor.dart';
import '../../res/ImageRes.dart';
import '../../utils/weight/help_weight.dart';

class LootBoxDetails extends StatefulWidget {
  int index;

  LootBoxDetails(this.index, {Key? key}) : super(key: key);

  @override
  State<LootBoxDetails> createState() => _LootBoxDetailsState();
}

class _LootBoxDetailsState extends State<LootBoxDetails> {
  late final LootBoxCubit createStoriesCubit;

  @override
  void initState() {
    // TODO: implement initState

    createStoriesCubit = context.read<LootBoxCubit>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
       child : BlocBuilder<LootBoxCubit, LootBoxEquatable>(
        builder: (context, state) {
      return Scaffold(
        backgroundColor: AppColor().colorPrimary,
        appBar: AppBar(


          backgroundColor:  const Color(0xff46558c),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 60),
                    child: HelpWeight().testMethod(
                        32.0, FontWeight.w700, AppColor().whiteColor, "${state.lootBoxAdvertisers!.data![widget.index].name}"),
                  )),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                        top: 10,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            //color: AppColor().reward_card_bg,
                            border: Border.all(
                              width: 1,
                              color: AppColor().whiteColor,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: state.lootBoxAdvertisers!.data != null &&
                                  state.lootBoxAdvertisers!.data![widget.index]
                                          .logoUrl !=
                                      null
                              ? Image(
                                  //color: AppColor().whiteColor,
                                  width: 80,
                                  height: 80,
                                  //fit: BoxFit.cover,
                                  image: NetworkImage(
                                      "${state.lootBoxAdvertisers!.data![widget.index].logoUrl}"))
                              : const Image(
                                  height: 80,
                                  width: 80,
                                  fit: BoxFit.cover,
                                  image:
                                      AssetImage('assets/images/netflix.png'),
                                ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 0, top: 0),
                            child: Text(
                              "${state.lootBoxAdvertisers!.data![widget.index].name}",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: "UltimaPro",
                                  fontWeight: FontWeight.w600,
                                  color: AppColor().whiteColor),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 0, top: 5),
                            child: Text(
                              '${state.lootBoxAdvertisers!.data![widget.index].description}',
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontFamily: "UltimaPro",
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20.0, top: 5),
                  child: Container(
                    height: 70,
                    width: 120,
                    decoration: BoxDecoration(
                        color: AppColor().colorPrimaryLight,
                        border: Border.all(
                          width: 1,
                          color: AppColor().colorPrimaryLight,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Total Earnings",
                          style: TextStyle(
                              fontSize: 14,
                              height: 1.0,
                              fontFamily: "UltimaPro",
                              fontWeight: FontWeight.w500,
                              color: AppColor().whiteColor),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(top: 0, left: 5),
                              child: Image.asset(
                                ImageRes().earnzoCoinIcon,
                                width: 31,
                                height: 31,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 0, top: 3),
                              child: Text(
                                (state.lootBoxAdvertisers!.data![widget.index]
                                            .userEarning!.value! /
                                        100)
                                    .toStringAsFixed(0),
                                style: TextStyle(
                                    fontSize: 32,
                                    fontFamily: "UltimaPro",
                                    fontWeight: FontWeight.w700,
                                    color: AppColor().textColor),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Visibility(
                visible: isTrue(widget.index),
                //  visible: true,
                child: Padding(
                  padding:
                  const EdgeInsets.only(left: 20.0, top: 20, right: 20),
                  child: Container(
                    //height: 100,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: AppColor().colorPrimaryLight,
                        border: Border.all(
                          width: 1,
                          color: AppColor().colorPrimaryLight,
                        ),
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          const SizedBox(height: 5,),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Task Progress ",
                              style: TextStyle(
                                  color: Color(0xffffffff),
                                  fontWeight: FontWeight.w900,
                                  fontFamily: "UltimaPro",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 20.0),
                            ),
                          ),
                          const SizedBox(height: 5,),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [

                                Container(
                                  height: 50,
                                  padding: const EdgeInsets.only(right: 10),
                                  decoration: const BoxDecoration(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                      color: Color(0xff1e2540)),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Stack(
                                            children: [
                                              Container(
                                                  width: 23,
                                                  height: 23,
                                                  decoration: const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Color(0xff46558c))),

                                              Padding(
                                                padding: const EdgeInsets.only(left: 5,bottom: 0),
                                                child: Image(
                                                    height: 20,
                                                    width: 20,
                                                    image: AssetImage(
                                                        ImageRes().checkMarkar)),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Text(
                                            'Click on Install Button',
                                            style: TextStyle(
                                                color: Color(0xffffffff),
                                                fontWeight: FontWeight.w400,
                                                fontFamily: "UltimaPro",
                                                fontStyle: FontStyle.normal,
                                                fontSize: 16.0),
                                          ),
                                        ],
                                      ),
                                      Image(
                                          height: 15,
                                          width: 12,
                                          image: AssetImage(
                                              ImageRes().arrowThink)),
                                    ],
                                  ),
                                ),
                                /*  Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Checkbox(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      side: MaterialStateBorderSide.resolveWith(
                                        (states) => const BorderSide(
                                            width: 2.0, color: Colors.white),
                                      ),
                                      onChanged: (value) {
                                        print(value);
                                        //checkbox_bool2.value = value;
                                        //Utils().customPrint('checkbox_bool 1 ${checkbox_bool2}');
                                      },
                                      value: false, //checkbox_bool2.value,
                                    ),
                                    const Text(
                                      'Install and open the application',
                                      style: TextStyle(
                                          fontFamily: "UltimaPro",
                                          color: Colors.white,
                                          fontSize: 13.0,
                                          fontStyle: FontStyle.normal),
                                    ),
                                  ],
                                ),*/

                                const SizedBox(height: 11,),

                                Container(
                                  height: 50,
                                  padding: const EdgeInsets.only(right: 10),
                                  decoration: const BoxDecoration(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                      color: Color(0xff1e2540)),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Stack(
                                            children: [
                                              Container(
                                                  width: 23,
                                                  height: 23,
                                                  decoration: const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Color(0xff46558c))),

                                              /* Padding(
                                                padding: const EdgeInsets.only(left: 5,bottom: 0),
                                                child: Image(
                                                    height: 20,
                                                    width: 20,
                                                    image: AssetImage(
                                                        ImageRes().checkMarkar)),
                                              )*/
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Text(
                                            'Install and open the application',
                                            style: TextStyle(
                                                fontFamily: "UltimaPro",
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16.0,
                                                fontStyle: FontStyle.normal),
                                          ),
                                        ],
                                      ),
                                      Image(
                                          height: 15,
                                          width: 12,
                                          image: AssetImage(
                                              ImageRes().arrowThink)),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10,),



                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Offstage(
                offstage: isTrue(widget.index),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 30, right: 20),
                  child: Container(
                    //height: 70,
                    //width: 120,
                    decoration: BoxDecoration(
                        color: AppColor().colorPrimaryLight,
                        border: Border.all(
                          width: 1,
                          color: AppColor().colorPrimaryLight,
                        ),
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 10, right: 10, top: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 0, left: 5),
                                child: Text(
                                  "Steps",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: "UltimaPro",
                                      height: 1.0,
                                      fontWeight: FontWeight.w900,
                                      color: AppColor().whiteColor),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 15),
                                height: 40,
                                width: 80,
                                decoration: BoxDecoration(
                                    color: const Color(0xff1e2540),
                                    /*   border: Border.all(
                                      width: 1,
                                      color: AppColor().whiteColor,
                                    ),*/
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 0, top: 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(
                                            top: 5, left: 5, bottom: 5, right: 5),
                                        child: Image.asset(
                                          ImageRes().earnzoCoinIcon,
                                          width: 31,
                                          height: 31,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 0, top: 2, bottom: 0),
                                        child: Text(
                                          (state
                                                      .lootBoxAdvertisers!
                                                      .data![widget.index]
                                                      .userEarning!
                                                      .value! /
                                                  100)
                                              .toStringAsFixed(0),
                                          style: TextStyle(
                                              fontSize: 32,
                                              fontFamily: "UltimaPro",
                                              fontWeight: FontWeight.w700,
                                              color:
                                                  AppColor().textColorLightLarge),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, top: 0, bottom: 10),
                            child: HtmlWidget(
                              // the first parameter (`html`) is required
                              '''
${state.lootBoxAdvertisers!.data![widget.index].details}
                        ''',

                              customStylesBuilder: (element) {
                                if (element.classes.contains('foo')) {
                                  return {'color': 'red'};
                                }
                                return null;
                              },

                              // render a custom widget
                              customWidgetBuilder: (element) {
                                /*  if (element.attributes['foo'] == 'bar') {
                            return FooBarWidget();
                          }*/

                                return null;
                              },

                              onErrorBuilder: (context, element, error) =>
                                  Text('$element error: $error'),
                              onLoadingBuilder:
                                  (context, element, loadingProgress) =>
                                      const CircularProgressIndicator(),

                              renderMode: RenderMode.column,

                              // set the default styling for text
                              textStyle: const TextStyle(
                                  color: Color(0xffffffff),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "UltimaPro",
                                  //  height: 1.0,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 16.0),
                            )),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 15, right: 20),
                child: Container(
                  //height: 70,
                  padding: const EdgeInsets.only(top: 5, bottom: 10, left: 10),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: AppColor().colorPrimaryLight,
                      border: Border.all(
                        width: 1,
                        color: AppColor().colorPrimaryLight,
                      ),
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Important",
                            style: TextStyle(
                                color: Color(0xffffffff),
                                fontWeight: FontWeight.w900,
                                fontFamily: "UltimaPro",
                                fontStyle: FontStyle.normal,
                                fontSize: 20.0),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.0, left: 5),
                          child: Text(
                            "If You have installed the app before You won’t get the rewards.",
                            style: TextStyle(
                                color: Color(0xffffffff),
                                fontWeight: FontWeight.w400,
                                fontFamily: "UltimaPro",
                                fontStyle: FontStyle.normal,
                                fontSize: 16.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),

        bottomNavigationBar: BottomAppBar(
          color: Colors.transparent,
          elevation: 0,
          child: GestureDetector(
            onTap: () async {
              String appInstalled = "false";
              if (createStoriesCubit.state.lootBoxAdvertisers!.data![widget.index]
                  .appPackage !=
                  null &&
                  createStoriesCubit.state.lootBoxAdvertisers!.data![widget.index]
                      .appPackage!.android !=
                      null) {
                HelpMethod().customPrint(
                    "open App: ${await findAppByPkgName(createStoriesCubit.state.lootBoxAdvertisers!.data![widget.index].appPackage!.android!)}");
                appInstalled = await findAppByPkgName(
                    "${createStoriesCubit.state.lootBoxAdvertisers!.data![widget.index].appPackage!.android}");
              }

              final param = {
                "advertiserDealId":
                "${createStoriesCubit.state.lootBoxAdvertisers!.data![widget.index].id}",
                "appInstalled": appInstalled,
                "deviceId": await HelpMethod().getUniqueDeviceId()
              };
              //return;

              await createStoriesCubit.createUserDeal(context, param);
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10.0, left: 50, right: 50),
              child: Container(
                width: 280,
                height: 55,
                margin: const EdgeInsets.only(right: 10),
                /*  padding:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 15),*/
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(
                        0.0,
                        5.0,
                      ),
                      blurRadius: 0,
                      spreadRadius: 0,
                      color: Color(0xFF0d4b48),
                    ),
                  ],

                  color: AppColor().greenColorLightS,
                  /* gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                AppColor().greenColorLight,
                AppColor().greenColor,
              ],
            ),*/
                  //  border: Border.all(color: AppColor().whiteColor, width: 2),
                  borderRadius: BorderRadius.circular(15),
                  // color: AppColor().whiteColor
                ),
                alignment: Alignment.center,
                child: const Text(
                  "INSTALL",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 24,
                      fontFamily: "UltimaPro",
                      fontWeight: FontWeight.w900,
                      color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      );
    }),
      );


  }

  findAppByPkgName(String pkgName) async {
    try {
      bool isInstalled = await DeviceApps.isAppInstalled(pkgName);
      if (isInstalled) {
        HelpMethod().customPrint('open App...IF');
        return "true";
      } else {
        HelpMethod().customPrint('open App...ELSE');
        return "false";
      }
    } catch (e) {
      HelpMethod().customPrint('open App...E');
      return "false";
    }
  }

  bool isTrue(int index) {
    bool tmpBool = false;
    createStoriesCubit.state.lootBoxAdvertisers!.data![index].userDeal !=
                null &&
            HelpMethod().subtractDate((DateTime.parse(
                    "${createStoriesCubit.state.lootBoxAdvertisers!.data![index].userDeal!.expireDate}"))) >
                0
        ? tmpBool = true
        : tmpBool = false;
    return tmpBool;
  }
}
