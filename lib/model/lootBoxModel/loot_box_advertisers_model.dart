class LootBoxAdvertisersModel {
  List<Data>? data;
  Pagination? pagination;

  LootBoxAdvertisersModel({this.data, this.pagination});

  LootBoxAdvertisersModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  String? advertiserId;
  String? name;
  String? description;
  String? details;
  String? terms;
  String? buttonText;
  String? logoUrl;
  String? activeFromDate;
  String? activeToDate;
  int? startTime;
  int? endTime;
  int? dealTimeoutMinutes;
  GmngEarning? gmngEarning;
  UserEarning? userEarning;
  Limits? limits;
  Stats? stats;
  String? url;
  AppPackage? appPackage;
  int? order;
  String? status;
  String? createdBy;
  String? updatedBy;
  String? createdAt;
  String? updatedAt;
  Banner? banner;
  UserDeal? userDeal;

  Data(
      {this.id,
        this.advertiserId,
        this.name,
        this.description,
        this.details,
        this.terms,
        this.buttonText,
        this.logoUrl,
        this.activeFromDate,
        this.activeToDate,
        this.startTime,
        this.endTime,
        this.dealTimeoutMinutes,
        this.gmngEarning,
        this.userEarning,
        this.limits,
        this.stats,
        this.url,
        this.appPackage,
        this.order,
        this.status,
        this.createdBy,
        this.updatedBy,
        this.createdAt,
        this.updatedAt,
        this.banner,
        this.userDeal});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    advertiserId = json['advertiserId'];
    name = json['name'];
    description = json['description'];
    details = json['details'];
    terms = json['terms'];
    buttonText = json['buttonText'];
    logoUrl = json['logoUrl'];
    activeFromDate = json['activeFromDate'];
    activeToDate = json['activeToDate'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    dealTimeoutMinutes = json['dealTimeoutMinutes'];
    gmngEarning = json['gmngEarning'] != null
        ? new GmngEarning.fromJson(json['gmngEarning'])
        : null;
    userEarning = json['userEarning'] != null
        ? new UserEarning.fromJson(json['userEarning'])
        : null;
    limits =
    json['limits'] != null ? new Limits.fromJson(json['limits']) : null;
    stats = json['stats'] != null ? new Stats.fromJson(json['stats']) : null;
    url = json['url'];
    appPackage = json['appPackage'] != null
        ? new AppPackage.fromJson(json['appPackage'])
        : null;
    order = json['order'];
    status = json['status'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];

    banner = json['banner'] != null
        ? Banner.fromJson(json['banner'])
        : null;
    userDeal = json['userDeal'] != null
        ? new UserDeal.fromJson(json['userDeal'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['advertiserId'] = this.advertiserId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['details'] = this.details;
    data['terms'] = this.terms;
    data['buttonText'] = this.buttonText;
    data['logoUrl'] = this.logoUrl;
    data['activeFromDate'] = this.activeFromDate;
    data['activeToDate'] = this.activeToDate;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['dealTimeoutMinutes'] = this.dealTimeoutMinutes;
    if (this.gmngEarning != null) {
      data['gmngEarning'] = this.gmngEarning!.toJson();
    }
    if (this.userEarning != null) {
      data['userEarning'] = this.userEarning!.toJson();
    }
    if (this.limits != null) {
      data['limits'] = this.limits!.toJson();
    }
    if (this.stats != null) {
      data['stats'] = this.stats!.toJson();
    }
    data['url'] = this.url;
    if (this.appPackage != null) {
      data['appPackage'] = this.appPackage!.toJson();
    }
    data['order'] = this.order;
    data['status'] = this.status;
    data['createdBy'] = this.createdBy;
    data['updatedBy'] = this.updatedBy;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['banner'] = this.banner;
    if (this.userDeal != null) {
      data['userDeal'] = this.userDeal!.toJson();
    }
    return data;
  }
}

class GmngEarning {
  String? type;
  int? value;
  String? currency;

  GmngEarning({this.type, this.value, this.currency});

  GmngEarning.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    value = json['value'];
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['value'] = this.value;
    data['currency'] = this.currency;
    return data;
  }
}

class UserEarning {
  String? type;
  int? value;
  String? currency;

  UserEarning({this.type, this.value, this.currency});

  UserEarning.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    value = json['value'];
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['value'] = this.value;
    data['currency'] = this.currency;
    return data;
  }
}

class Limits {
  int? daily;
  int? total;

  Limits({this.daily, this.total});

  Limits.fromJson(Map<String, dynamic> json) {
    daily = json['daily'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['daily'] = this.daily;
    data['total'] = this.total;
    return data;
  }
}

class Stats {
  int? entryCount;
  int? uniqueEntryCount;
  int? usesCount;
  GmngEarning? totalGmngEarning;
  GmngEarning? totalUserEarning;

  Stats(
      {this.entryCount,
        this.uniqueEntryCount,
        this.usesCount,
        this.totalGmngEarning,
        this.totalUserEarning});

  Stats.fromJson(Map<String, dynamic> json) {
    entryCount = json['entryCount'];
    uniqueEntryCount = json['uniqueEntryCount'];
    usesCount = json['usesCount'];
    totalGmngEarning = json['totalGmngEarning'] != null
        ? new GmngEarning.fromJson(json['totalGmngEarning'])
        : null;
    totalUserEarning = json['totalUserEarning'] != null
        ? new GmngEarning.fromJson(json['totalUserEarning'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['entryCount'] = this.entryCount;
    data['uniqueEntryCount'] = this.uniqueEntryCount;
    data['usesCount'] = this.usesCount;
    if (this.totalGmngEarning != null) {
      data['totalGmngEarning'] = this.totalGmngEarning!.toJson();
    }
    if (this.totalUserEarning != null) {
      data['totalUserEarning'] = this.totalUserEarning!.toJson();
    }
    return data;
  }
}

class AppPackage {
  String? android;

  AppPackage({this.android});

  AppPackage.fromJson(Map<String, dynamic> json) {
    android = json['android'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['android'] = this.android;
    return data;
  }
}
class Banner {
  String? id;
  String? url;

  Banner({this.id, this.url});

  Banner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    return data;
  }
}
class UserDeal {
  String? id;
  String? advertiserDealId;
  String? userId;
  GmngEarning? gmngEarning;
  UserEarning? userEarning;
  Null? userTransactionId;
  Null? gmngTransactionId;
  Null? callbackData;
  String? dealDate;
  bool? appInstalled;
  String? dealName;
  List<String>? dealPackageIds;
  String? userDeviceId;
  String? expireDate;
  String? status;
  Null? statusReason;
  bool? isViewed;
  String? createdBy;
  String? updatedBy;
  String? createdAt;
  String? updatedAt;

  UserDeal(
      {this.id,
        this.advertiserDealId,
        this.userId,
        this.gmngEarning,
        this.userEarning,
        this.userTransactionId,
        this.gmngTransactionId,
        this.callbackData,
        this.dealDate,
        this.appInstalled,
        this.dealName,
        this.dealPackageIds,
        this.userDeviceId,
        this.expireDate,
        this.status,
        this.statusReason,
        this.isViewed,
        this.createdBy,
        this.updatedBy,
        this.createdAt,
        this.updatedAt});

  UserDeal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    advertiserDealId = json['advertiserDealId'];
    userId = json['userId'];
    gmngEarning = json['gmngEarning'] != null
        ? GmngEarning.fromJson(json['gmngEarning'])
        : null;
    userEarning = json['userEarning'] != null
        ? UserEarning.fromJson(json['userEarning'])
        : null;
    userTransactionId = json['userTransactionId'];
    gmngTransactionId = json['gmngTransactionId'];
    callbackData = json['callbackData'];
    dealDate = json['dealDate'];
    appInstalled = json['appInstalled'];
    dealName = json['dealName'];
    dealPackageIds = json['dealPackageIds'].cast<String>();
    userDeviceId = json['userDeviceId'];
    expireDate = json['expireDate'];
    status = json['status'];
    statusReason = json['statusReason'];
    isViewed = json['isViewed'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    if (json['webhookLogs'] != null) {

    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['advertiserDealId'] = this.advertiserDealId;
    data['userId'] = this.userId;
    if (this.gmngEarning != null) {
      data['gmngEarning'] = this.gmngEarning!.toJson();
    }
    if (this.userEarning != null) {
      data['userEarning'] = this.userEarning!.toJson();
    }
    data['userTransactionId'] = this.userTransactionId;
    data['gmngTransactionId'] = this.gmngTransactionId;
    data['callbackData'] = this.callbackData;
    data['dealDate'] = this.dealDate;
    data['appInstalled'] = this.appInstalled;
    data['dealName'] = this.dealName;
    data['dealPackageIds'] = this.dealPackageIds;
    data['userDeviceId'] = this.userDeviceId;
    data['expireDate'] = this.expireDate;
    data['status'] = this.status;
    data['statusReason'] = this.statusReason;
    data['isViewed'] = this.isViewed;
    data['createdBy'] = this.createdBy;
    data['updatedBy'] = this.updatedBy;

    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Pagination {
  int? offset;
  int? total;
  int? count;
  int? limit;

  Pagination({this.offset, this.total, this.count, this.limit});

  Pagination.fromJson(Map<String, dynamic> json) {
    offset = json['offset'];
    total = json['total'];
    count = json['count'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['offset'] = this.offset;
    data['total'] = this.total;
    data['count'] = this.count;
    data['limit'] = this.limit;
    return data;
  }
}
