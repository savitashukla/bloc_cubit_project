class WalletCoin {
  List<DataWallet>? data;

  WalletCoin({this.data});

  WalletCoin.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <DataWallet>[];
      json['data'].forEach((v) {
        data!.add(new DataWallet.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataWallet {
  String? id;
  String? userId;
  String? type;
  var balance;
  String? currency;
  bool? isSystemWallet;
  String? status;
  String? createdAt;
  String? updatedAt;

  DataWallet(
      {this.id,
        this.userId,
        this.type,
        this.balance,
        this.currency,
        this.isSystemWallet,
        this.status,
        this.createdAt,
        this.updatedAt});

  DataWallet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    type = json['type'];
    balance = json['balance'];
    currency = json['currency'];
    isSystemWallet = json['isSystemWallet'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['type'] = this.type;
    data['balance'] = this.balance;
    data['currency'] = this.currency;
    data['isSystemWallet'] = this.isSystemWallet;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}