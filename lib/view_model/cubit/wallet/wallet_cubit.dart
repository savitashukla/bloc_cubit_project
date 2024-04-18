import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cubit_project/model/wallet/WalletCoin.dart';
import 'package:cubit_project/view_model/cubit/wallet/wallet_equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/service/web_services_helper.dart';
import '../../../model/wallet/transaction_history.dart';
import '../../../model/wallet/withdraw_data.dart';
import '../../../utils/help_method.dart';
import '../../../utils/helper_progressbar.dart';
import '../../../utils/logger_utils.dart';

class WalletCubit extends Cubit<WalletEquatable> {
  WalletCubit()
      : super(WalletEquatable.init(
            isProcessing: false,
            totalLimit: 0,
            currentPage: 0,
            allWallListCheck: true,
            debitListCheck: false,
            creditListCheck: false));

  SharedPreferences? prefs;

  String? token;

  String? userId;

  void init() async {
    prefs = await SharedPreferences.getInstance();
    token = prefs!.getString("token");
    userId = prefs!.getString("userId");
    getWalletData();
    getWithdrawalData();
  }

  void updatteUPI(String linkUIP) {
    emit(state.copyWith(upiLink: linkUIP));
  }

  void enterUPIValues(String linkUIP) {
    emit(state.copyWith(enterUPIValues: linkUIP));
  }

  void paginationCurrentPage(var currentPageCount) {
    emit(state.copyWith(currentPage: currentPageCount));
  }

  void clickWalletTypePass(
      bool allWalletCheck, bool debitWalletCheck, bool creditWalletCheck) {
    emit(state.copyWith(
        allWallListCheck: allWalletCheck,
        debitListCheck: debitWalletCheck,
        creditListCheck: creditWalletCheck));
  }

  Future<void> getWithdrawalUPIUpdate(BuildContext context) async {
    if (token == null) {
      prefs = await SharedPreferences.getInstance();
      token = prefs!.getString("token");
      userId = prefs!.getString("userId");
    }
    var map = {
      "type": "upi",
      "data": {
        "upi": {"link": state.enterUPIValues}
      }
    };
    showProgress();

    var response = await WebServicesHelper().getWithdrawalUpdate(
        map, "$token", "$userId", "${state.upiData!.upi_array![0].sId}");

    hideProgress();
    if (response != null) {
      getWithdrawalData();
    } else {
      // Fluttertoast.showToast(msg: "Some Error");
    }
  }

  Future<void> getWithdrawalUPI(BuildContext context) async {
    if (token == null) {
      prefs = await SharedPreferences.getInstance();
      token = prefs!.getString("token");
      userId = prefs!.getString("userId");
    }
    var map = {
      "type": "upi",
      "data": {
        "upi": {"link": state.enterUPIValues}
      }
    };
    showProgress();

    var response =
        await WebServicesHelper().getWithdrawal(map, "$token", "$userId");
    hideProgress();

    if (response != null) {
      getWithdrawalData();
    } else {
      // Fluttertoast.showToast(msg: "Some Error");
    }
  }

  Future<void> getWalletData() async {
    if (token == null) {
      prefs = await SharedPreferences.getInstance();
      token = prefs!.getString("token");
      userId = prefs!.getString("userId");
    }
    Map<String, dynamic>? responsestr =
        await WebServicesHelper().getWalletData("$token", "$userId");

    if (responsestr != null) {
      WalletCoin walletCoinV = WalletCoin.fromJson(responsestr);

      for (int index = 0; index < walletCoinV.data!.length; index++) {
        //emit(state.copyWith(walletCoin: walletCoinV.data![index]));
/* if (walletCoinV.data![index].type == "winning") {
          emit(state.copyWith(walletCoin: walletCoinV.data![index]));
          //  getTransaction();
        }*/

        if (walletCoinV.data![index].type == "lootCoin") {
          print("wikth coin ${walletCoinV.data![index].id}");
          emit(state.copyWith(walletCoin: walletCoinV.data![index]));
          //  getTransaction();
        }
      }
    }
  }

  Future<void> getWithdrawalData() async {
    if (token == null) {
      prefs = await SharedPreferences.getInstance();
      token = prefs!.getString("token");
      userId = prefs!.getString("userId");
    }

    Map<String, dynamic>? response =
        await WebServicesHelper().getWithdrawalData("$token", "$userId");
    if (response != null) {
      WithdrawalModelR? withdrawalModelR = WithdrawalModelR.fromJson(response);
      //final upi_array=withdrawalModelR.upi_array;

      emit(state.copyWith(upiData: withdrawalModelR));

      if (withdrawalModelR!.upi_array != null &&
          withdrawalModelR!.upi_array!.length > 0) {
        updatteUPI("${withdrawalModelR!.upi_array![0].data?.upi!.link}");
      }
    } else {
      // Fluttertoast.showToast(msg: "Some Error");
    }
  }

  Future<void> getWithdrawalClick(String? enterAmount) async {
    if (token == null) {
      prefs = await SharedPreferences.getInstance();
      token = prefs!.getString("token");
      userId = prefs!.getString("userId");
    }

    double doubleNum = double.parse("$enterAmount");

    int enterAmountCall = doubleNum.toInt(); // i = 20//STRING to DOUBLE

    showProgress();


    var map = {
      "walletId": state.walletCoin!.id,
      "withdrawMethodId": "${state.upiData!.upi_array![0].sId}",
      "amount": {"value": enterAmountCall}
    };

    var response_final =
        await WebServicesHelper().getWithdrawalClick(map, "$token", "$userId");

    Map<String, dynamic>? response_finalMap =
        json.decode(response_final!.body.toString());
    hideProgress();
    if (response_final!.statusCode == 200) {
      Fluttertoast.showToast(msg: "Amount Redeem Successfully");
      Navigator.pop(navigatorKey.currentState!.context);
      getWalletData();
    } else if (response_finalMap != null) {
      Fluttertoast.showToast(msg: "${response_finalMap!["error"]}");
    }
  }

  Future<void> getTransaction() async {
    HelpMethod().customPrint('getWithdrawRequest DATA:: 0');
    if (state.walletCoin != null && state.walletCoin!.id != null) {
      Map<String, dynamic>? response = await WebServicesHelper().getTransaction(
          "$token",
          "$userId",
          "${state.walletCoin!.id}",
          state.currentPage,
          10);
      /* "$token",
          "$userId",
          "631af3cd74c06451f5dc3e53",
          state.currentPage,
          10);*/
      HelpMethod().customPrint('getWithdrawRequest DATA:: 1');
      if (response != null) {
        TransactionWallet? transactionWallet =
            TransactionWallet.fromJson(response);
        List<TransactionList>? listData = <TransactionList>[];
        List<TransactionList>? listCredit = <TransactionList>[];
        List<TransactionList>? listDebit = <TransactionList>[];

        listData = transactionWallet!.data;
        listCredit = transactionWallet!.credit;
        listDebit = transactionWallet!.debit;

        if (state!.allDataWallet != null && state!.allDataWallet!.length > 0) {
          print("call allWalletAmount${state!.allDataWallet!.length}");

          for (int index = 0; state.allDataWallet!.length > index; index++) {
            listData!.add(state!.allDataWallet![index]);
          }
        }

        if (state!.creditList != null && state!.creditList!.length > 0) {
          for (int index = 0; state.creditList!.length > index; index++) {
            listCredit!.add(state!.creditList![index]);
          }
        }

        if (state!.debitList != null && state!.debitList!.length > 0) {
          for (int index = 0; state.debitList!.length > index; index++) {
            listDebit!.add(state!.debitList![index]);
          }
        }

        emit(state.copyWith(
            allDataWallet: listData,
            totalLimit: transactionWallet.pagination!.total,
            creditList: listCredit,
            debitList: listDebit));
      } else {
        HelpMethod().customPrint('getWithdrawRequest DATA:: 4');
        // Fluttertoast.showToast(msg: "Some Error");
      }
    }
  }
}
