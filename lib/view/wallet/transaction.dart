import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freshchat_sdk/freshchat_sdk.dart';
import 'package:intl/intl.dart';
import 'package:cubit_project/model/gameEventList/gameEvnetListHistory.dart';
import 'package:cubit_project/utils/help_method.dart';
import 'package:cubit_project/utils/logger_utils.dart';
import 'package:cubit_project/view_model/cubit/wallet/wallet_cubit.dart';
import 'package:cubit_project/view_model/cubit/wallet/wallet_equatable.dart';

import '../../model/wallet/transaction_history.dart';
import '../../res/AppColor.dart';
import '../../res/ImageRes.dart';
import '../../utils/weight/help_weight.dart';

class TransactionHistory extends StatefulWidget {
  const TransactionHistory({Key? key}) : super(key: key);

  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  WalletCubit? walletCubit;
  var scrollcontroller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState

    walletCubit = context.read<WalletCubit>();

    walletCubit!.paginationCurrentPage(0);
    walletCubit!.getTransaction();
    walletCubit!.clickWalletTypePass(true, false, false);

    scrollcontroller.addListener(() {
      if (scrollcontroller.position.atEdge &&
          scrollcontroller.position.pixels != 0) {
        if (walletCubit!.state.totalLimit > walletCubit!.state.currentPage) {
          print("check datta call ${walletCubit!.state.currentPage}");
          walletCubit!
              .paginationCurrentPage(walletCubit!.state.currentPage + 10);
          walletCubit!.getTransaction();
        }

        HelpMethod().customPrint("data pagination");
        /* if (maxPaginationCount.value > paginationPage.value) {
            pageLoading.value = true;
            getProductList();
          } else {
            noMoreItems.value = true;
          }*/
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: BlocBuilder<WalletCubit, WalletEquatable>(
        builder: (BuildContext context, state) {
      return Scaffold(
        backgroundColor: AppColor().colorPrimary,
        appBar: AppBar(
          flexibleSpace: Image(
            image: AssetImage(ImageRes().topBg),
            height: 55,
            fit: BoxFit.cover,
          ),
          backgroundColor: Colors.transparent,
          title: Padding(
            padding: const EdgeInsets.only(right: 0),
            child: HelpWeight().testMethod(
            23.0, FontWeight.w900, AppColor().whiteColor, "Transaction History"),
          ),
        ),
        body: SingleChildScrollView(
          controller: scrollcontroller,
          child: Column(
            children: [
              const SizedBox(height: 39),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        walletCubit!.clickWalletTypePass(true, false, false);
                      },
                      child: Text(
                        "All",
                        style: TextStyle(
                            color: state.allWallListCheck == true
                                ? const Color(0xffffb801)
                                : const Color(0xffe3e3e3),
                            fontWeight: FontWeight.w900,
                            fontFamily: "UltimaPro",
                            fontStyle: FontStyle.normal,
                            fontSize: 20.0),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        walletCubit!.clickWalletTypePass(false, false, true);
                      },
                      child: Text(
                        "Credited",
                        style: TextStyle(
                            color: state.creditListCheck == true
                                ? const Color(0xffffb801)
                                : const Color(0xffe3e3e3),
                            fontWeight: FontWeight.w900,
                            fontFamily: "UltimaPro",
                            fontStyle: FontStyle.normal,
                            fontSize: 20.0),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        walletCubit!.clickWalletTypePass(false, true, false);
                      },
                      child: Text(
                        "Debited",
                        style: TextStyle(
                            color: state.debitListCheck == true
                                ? const Color(0xffffb801)
                                : const Color(0xffe3e3e3),
                            fontWeight: FontWeight.w900,
                            fontFamily: "UltimaPro",
                            fontStyle: FontStyle.normal,
                            fontSize: 20.0),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
        /*      Center(
                child: Visibility(
                  visible: state.allDataWallet==true,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: state.allDataWallet != null
                        ? state.allDataWallet!.isNotEmpty
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemCount: state.allDataWallet!.length,
                                itemBuilder: (context, index) {
                                  return getTransactionList(state.allDataWallet,index);
                                })
                            : HelpWeight().testMethod(16.0, FontWeight.w900,
                                AppColor().textColorLight, "No Data Found")
                        : HelpWeight().getSimmerWeight(),
                  ),
                ),
              ),*/
              Visibility(
                visible: state.allWallListCheck==true,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: state.allDataWallet != null
                        ? state.allDataWallet!.isNotEmpty
                        ? ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.allDataWallet!.length,
                        itemBuilder: (context, index) {
                          return getTransactionList(state.allDataWallet,index);
                        })
                        : HelpWeight().testMethod(16.0, FontWeight.w900,
                        AppColor().textColorLight, "No Data Found")
                        : HelpWeight().getSimmerWeight(),
                  ),
                ),
              ),
              Visibility(
                visible: state.debitListCheck==true,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: state.debitList != null
                        ? state.debitList!.isNotEmpty
                        ? ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.debitList!.length,
                        itemBuilder: (context, index) {
                          return getTransactionList(state.debitList,index);
                        })
                        : HelpWeight().testMethod(16.0, FontWeight.w900,
                        AppColor().textColorLight, "No Data Found")
                        : HelpWeight().getSimmerWeight(),
                  ),
                ),
              ),
              Visibility(
                visible: state.creditListCheck==true,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: state.creditList != null
                        ? state.creditList!.isNotEmpty
                        ? ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.creditList!.length,
                        itemBuilder: (context, index) {
                          return getTransactionList(state.creditList,index);
                        })
                        : HelpWeight().testMethod(16.0, FontWeight.w900,
                        AppColor().textColorLight, "No Data Found")
                        : HelpWeight().getSimmerWeight(),
                  ),
                ),
              )


            ],
          ),
        ),
      );
    }));
  }

  Widget getTransactionList(List<TransactionList>? historyListData,int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      width: MediaQuery.of(navigatorKey.currentState!.context).size.width,
      height: 78,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                color: Color(0xff1e2540),
                offset: Offset(0, 4),
                blurRadius: 2,
                spreadRadius: 0)
          ],
          color: Color(0x8046558c)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 75,
                margin: const EdgeInsets.only(left: 0),
                height: MediaQuery.of(navigatorKey.currentState!.context)
                    .size
                    .height,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    gradient: LinearGradient(
                        begin: Alignment(
                            1.357142917355707, -3.3306690738754696e-16),
                        end: Alignment(
                            0.07142875206712085, 1.1102230246251565e-16),
                        colors: [Color(0xff46558c), Color(0xff46558c)])),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                        height: 28,
                        width: 28,
                        image: AssetImage(ImageRes().earnzoCoinIcon)),
                    const SizedBox(
                      width: 2,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Text(
                        '${historyListData![index].amount!.value ~/ 100}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24.0,
                          fontFamily: "UltimaPro",
                          color: AppColor().whiteColor,
                          height: 1.0,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "${historyListData![index].description!.length > 33 ? "${historyListData![index].description!.substring(0, 33)}..." : historyListData![index].description}",
                        style: const TextStyle(
                            color: Color(0xffe3e3e3),
                            fontWeight: FontWeight.w900,
                            fontFamily: "UltimaPro",
                            height: 1.0,
                            fontStyle: FontStyle.normal,
                            fontSize: 14.0),
                        textAlign: TextAlign.left),
                    const SizedBox(height: 5),
                    Text(
                        getStartTimeHHMMSS(
                            "${walletCubit!.state.allDataWallet![index].date}"),
                        style: const TextStyle(
                            color: Color(0xff6f80c0),
                            fontWeight: FontWeight.w700,
                            fontFamily: "UltimaPro",
                            height: 1.0,
                            fontStyle: FontStyle.normal,
                            fontSize: 12.0),
                        textAlign: TextAlign.left),
                    const SizedBox(height: 10),
                    Text(
                        "Transaction ID: ${historyListData![index].id!.length > 50 ? '${historyListData![index].id!.substring(50)}..' : historyListData![index].id}",
                        style: const TextStyle(
                            color: Color(0xffe3e3e3),
                            fontWeight: FontWeight.w500,
                            fontFamily: "UltimaPro",
                            height: 1.0,
                            fontStyle: FontStyle.normal,
                            fontSize: 10.0),
                        textAlign: TextAlign.left)
                  ],
                ),
              )
            ],
          ),
          InkWell(
            onTap: (){
              var eventName = "event_track_report";
              var eventProperties = {
                "Order Id":
                '${historyListData![index].id}',
                "type": "Real_money"
              };
              Freshchat.trackEvent(eventName,
                  properties: eventProperties);
              Freshchat.showConversations(
                  filteredViewTitle: "Order Queries",
                  tags: ["Order Queries"]);
            },
            child: Container(
                height: 30,
                width: 60,
                margin: const EdgeInsets.only(right: 5),
                // padding: EdgeInsets.only(right: 10,left: 10),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xffAA310B),
                          offset: Offset(0, 4),
                          blurRadius: 2,
                          spreadRadius: 0)
                    ],
                    color: Color(0xfff14812)),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      'Report',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12.0,
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
    );
  }

  String getStartTimeHHMMSS(String date_c) {
    return DateFormat("yyyy-MM-dd' 'HH:mm:ss").format(
        DateFormat("yyyy-MM-ddTHH:mm:ssZ").parse(date_c, true).toLocal());
  }
}
