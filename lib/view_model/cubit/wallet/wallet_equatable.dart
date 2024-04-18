import 'package:equatable/equatable.dart';

import '../../../model/wallet/WalletCoin.dart';
import '../../../model/wallet/transaction_history.dart';
import '../../../model/wallet/withdraw_data.dart';

class WalletEquatable extends Equatable {
  final bool isProcessing;
  final upiLink;
  String? walletId;
  DataWallet? walletCoin;
  List<TransactionList>? allDataWallet;
  List<TransactionList>? creditList;
  List<TransactionList>? debitList;
  WithdrawalModelR? upiData;
  String? enterUPIValues;
  var currentPage;
  var totalLimit;
  bool? allWallListCheck;
  bool? creditListCheck;
  bool? debitListCheck;


  WalletEquatable(
      {required this.isProcessing,
        this.upiLink,
        this.walletId,
        this.walletCoin,
        this.upiData,
        this.enterUPIValues,
        this.allDataWallet,
        this.debitList,
        this.creditList,
        required this.allWallListCheck,
        required this.creditListCheck,
        required this.debitListCheck,

        required this.currentPage, required this.totalLimit});

  WalletEquatable.init(
      {required this.isProcessing,
        this.upiLink,
        this.walletId,
        this.walletCoin,
        this.upiData,
        this.enterUPIValues,
        this.allDataWallet,
          this.debitList,
           this.creditList,
        required this.allWallListCheck,
        required this.creditListCheck,
        required this.debitListCheck,
        required this.currentPage, required this.totalLimit});

  WalletEquatable copyWith({
    bool? isProcessing,
    final upiLink,
    String? walletId,
    DataWallet? walletCoin,
   List <TransactionList>? allDataWallet,
    WithdrawalModelR? upiData,
    String? enterUPIValues,
    var currentPage,
  var totalLimit,
    List<TransactionList>? creditList,
    List<TransactionList>? debitList,
    bool? allWallListCheck,
    bool? creditListCheck,
    bool? debitListCheck,


  }) {
    return WalletEquatable(
      isProcessing: isProcessing ?? this.isProcessing,
      upiLink: upiLink ?? this.upiLink,
      walletId: walletId ?? this.walletId,
      walletCoin: walletCoin ?? this.walletCoin,
      enterUPIValues: enterUPIValues ?? this.enterUPIValues,
      currentPage: currentPage ?? this.currentPage,
      totalLimit: totalLimit ?? this.totalLimit,
      allDataWallet: allDataWallet ?? this.allDataWallet,
      creditList:  creditList
          ?? this.creditList,
      debitList: debitList ?? this.debitList,
      debitListCheck: debitListCheck ?? this.debitListCheck,
      creditListCheck: creditListCheck ?? this.creditListCheck,
      allWallListCheck: allWallListCheck ?? this.allWallListCheck,
      upiData: upiData ?? this.upiData,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    isProcessing,
    upiLink,
    walletId,
    walletCoin,
    enterUPIValues,
    allDataWallet,
    creditList,
    debitList,
    totalLimit,
    currentPage,
    allWallListCheck,
    creditListCheck,
    debitListCheck,
    upiData


  ];
}
