import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:cubit_project/res/ImageRes.dart';
import 'package:cubit_project/utils/weight/help_weight.dart';
import 'package:cubit_project/view/home/loot_box_details.dart';
import 'package:cubit_project/view_model/cubit/loot_box_cubit/loot_box_cubit.dart';

import '../../res/AppColor.dart';
import '../../utils/logger_utils.dart';

class LootBox extends StatefulWidget {
  LootBox({Key? key}) : super(key: key);

  @override
  State<LootBox> createState() => _LootBoxState();
}

class _LootBoxState extends State<LootBox> {
  late final LootBoxCubit createStoriesCubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createStoriesCubit = context.read<LootBoxCubit>();

    createStoriesCubit.getAdvertisersDeals();
  }

  Future<bool> onWillPop() async {
    SystemNavigator.pop();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: BlocBuilder<LootBoxCubit, LootBoxEquatable>(
          builder: (contest, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 22),
                child: Column(
                  children: [
                    Container(
                        width: 413,
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(ImageRes()
                                  .offerWallBanner)), /* color: const Color(0xffd9d9d9)*/
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 21, bottom: 10),
                      child: Row(
                        children: [
                          Expanded(
                              child: InkWell(
                            onTap: () {
                              createStoriesCubit.offerCall();
                              createStoriesCubit.getAdvertisersDeals();
                            },
                            child: Column(
                              children: [
                                HelpWeight().testMethod(14.0, FontWeight.w400,
                                    AppColor().whiteColor, "Offers"),
                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  color: state.colorPrimaryOfferWall,
                                  height: 3,
                                ),
                              ],
                            ),
                          )),
                          Expanded(
                              child: InkWell(
                            onTap: () {
                              createStoriesCubit.historyCall();
                              createStoriesCubit.getUserDeals();
                            },
                            child: Column(
                              children: [
                                HelpWeight().testMethod(14.0, FontWeight.w400,
                                    AppColor().whiteColor, "History"),
                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  color: state.colorwhiteOfferWall,
                                  height: 3,
                                ),
                              ],
                            ),
                          ))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Visibility(
                      visible: createStoriesCubit.state.checkTurnOffLootBox,
                      child: state.lootBoxAdvertisers != null
                          ? ListView.builder(
                              itemCount: state.lootBoxAdvertisers!.data!.length,
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return listOffer(index, state);
                              })
                          : HelpWeight().getSimmerWeight(),
                    ),
                    Offstage(
                      offstage: state.checkTurnOffLootBox,
                      child: state.userDealHistory != null
                          ? state.userDealHistory!.data!.length > 0
                              ? ListView.builder(
                                  itemCount:
                                      state.userDealHistory!.data!.length,
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return listHistory(index);
                                  })
                              : Center(child: const Text("Data Not Found"))
                          : HelpWeight().getSimmerWeight(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    ));
  }

  Widget listOffer(int index, state) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
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
                            image: NetworkImage(state
                                .lootBoxAdvertisers!
                                .data[index]
                                .logoUrl) /*AssetImage(ImageRes().byjus)*/))),
                const SizedBox(width: 14),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${state.lootBoxAdvertisers!.data[index].name}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: "UltimaPro",
                        color: AppColor().textColorLightMedium,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      '${state.lootBoxAdvertisers!.data[index].description}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: "UltimaPro",
                        color: AppColor().textColorLightMedium,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            InkWell(
              onTap: () {
                if (context
                        .read<LootBoxCubit>()
                        .state
                        .onlyNumber!
                        .compareTo("9829953786") ==
                    0) {
                  Fluttertoast.showToast(msg: "Under Maintenance");
                } else {
                  Navigator.push(
                    navigatorKey.currentState!.context,
                    MaterialPageRoute(
                        builder: (context) => LootBoxDetails(index)),
                  );
                }
              },
              child: Container(
                  width: 120,
                  height: 35,
                  margin: const EdgeInsets.only(right: 0),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: HelpWeight().testMethod(20.0, FontWeight.w700,
                            AppColor().whiteColor, "Get"),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Image(
                          height: 22,
                          width: 22,
                          image: AssetImage(ImageRes().earnzoCoinIcon)),
                      const SizedBox(
                        width: 2,
                      ),
                      /*HelpWeight().testMethod(
                            20.0, FontWeight.w700, AppColor().whiteColor, "5"),*/

                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          '${state.lootBoxAdvertisers!.data[index].userEarning.value ~/ 100}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: "UltimaPro",
                            color: AppColor().whiteColor,
                            height: 1.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget listHistory(int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
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
                        image: createStoriesCubit.state.userDealHistory!
                                    .data![index].advertiserDealId!.banner !=
                                null
                            ? DecorationImage(
                                image: NetworkImage(
                                    "${createStoriesCubit.state.userDealHistory!.data![index].advertiserDealId!.banner!.url}"))
                            : DecorationImage(
                                image: AssetImage(ImageRes().byjus)))),
                const SizedBox(width: 14),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${createStoriesCubit.state.userDealHistory!.data![index].advertiserDealId!.name}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: "UltimaPro",
                        color: AppColor().textColorLightMedium,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      '${createStoriesCubit.state.userDealHistory!.data![index].advertiserDealId!.description!.length > 23 ? createStoriesCubit.state.userDealHistory!.data![index].advertiserDealId!.description!.substring(0, 23) + '...' : createStoriesCubit.state.userDealHistory!.data![index].advertiserDealId!.description}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: "UltimaPro",
                        color: AppColor().textColorLightMedium,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 2),
                InkWell(
                  onTap: () {},
                  child: Container(
                      width: 120,
                      height: 35,
                      margin: const EdgeInsets.only(top: 5),
                      // padding: EdgeInsets.only(right: 10,left: 10),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            // Colors are easy thanks to Flutter's Colors class.
                            createStoriesCubit.state.userDealHistory!
                                        .data![index].status ==
                                    'completed'
                                ? AppColor().greenColorLight
                                : AppColor().buttonBgReadLight,
                            createStoriesCubit.state.userDealHistory!
                                        .data![index].status! ==
                                    'completed'
                                ? AppColor().greenColor
                                : AppColor().buttonBgReadDark,
                          ],
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: const [
                          BoxShadow(
                              color: Color(0xFF333232),
                              offset: Offset(0, 4),
                              blurRadius: 2,
                              spreadRadius: 0)
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Center(
                          child: Text(
                            createStoriesCubit
                                .state.userDealHistory!.data![index].status!
                                .toUpperCase(),
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
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    getStartTimeHHMMSS(createStoriesCubit
                        .state.userDealHistory!.data![index].dealDate),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 9,
                        fontFamily: "UltimaPro",
                        fontWeight: FontWeight.w400,
                        color: AppColor().colorPrimary),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  String getStartTimeHHMMSS(String? date_c) {
    return DateFormat("yyyy-MM-dd").format(
        DateFormat("yyyy-MM-ddTHH:mm:ssZ").parse("$date_c", true).toLocal());
  }
}
