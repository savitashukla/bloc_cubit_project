class UserdealModel {
  List<Data>? data;
  Pagination? pagination;

  UserdealModel({this.data, this.pagination});

  UserdealModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
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
  AdvertiserDealId? advertiserDealId;
  String? userId;
  GmngEarning? gmngEarning;
  GmngEarning? userEarning;
  String? userTransactionId;
  Null? gmngTransactionId;
  CallbackData? callbackData;
  String? dealDate;
  bool? appInstalled;
  String? dealName;
  String? userDeviceId;
  String? expireDate;
  String? status;
  String? statusReason;
  bool? isViewed;
  String? createdBy;
  String? updatedBy;
  List<WebhookLogs>? webhookLogs;
  String? createdAt;
  String? updatedAt;
  bool? canChangeStatus;

  Data(
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

      this.userDeviceId,
      this.expireDate,
      this.status,
      this.statusReason,
      this.isViewed,
      this.createdBy,
      this.updatedBy,
      this.webhookLogs,
      this.createdAt,
      this.updatedAt,
      this.canChangeStatus});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    advertiserDealId = json['advertiserDealId'] != null
        ? AdvertiserDealId.fromJson(json['advertiserDealId'])
        : null;
    userId = json['userId'];
    gmngEarning = json['gmngEarning'] != null
        ? GmngEarning.fromJson(json['gmngEarning'])
        : null;
    userEarning = json['userEarning'] != null
        ? GmngEarning.fromJson(json['userEarning'])
        : null;
    userTransactionId = json['userTransactionId'];
    gmngTransactionId = json['gmngTransactionId'];
    callbackData = json['callbackData'] != null
        ? CallbackData.fromJson(json['callbackData'])
        : null;
    dealDate = json['dealDate'];
    appInstalled = json['appInstalled'];
    dealName = json['dealName'];
    userDeviceId = json['userDeviceId'];
    expireDate = json['expireDate'];
    status = json['status'];
    statusReason = json['statusReason'];
    isViewed = json['isViewed'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    if (json['webhookLogs'] != null) {
      webhookLogs = <WebhookLogs>[];
      json['webhookLogs'].forEach((v) {
        webhookLogs!.add(WebhookLogs.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    canChangeStatus = json['canChangeStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    if (this.advertiserDealId != null) {
      data['advertiserDealId'] = this.advertiserDealId!.toJson();
    }
    data['userId'] = this.userId;
    if (this.gmngEarning != null) {
      data['gmngEarning'] = this.gmngEarning!.toJson();
    }
    if (this.userEarning != null) {
      data['userEarning'] = this.userEarning!.toJson();
    }
    data['userTransactionId'] = this.userTransactionId;
    data['gmngTransactionId'] = this.gmngTransactionId;
    if (this.callbackData != null) {
      data['callbackData'] = this.callbackData!.toJson();
    }
    data['dealDate'] = this.dealDate;
    data['appInstalled'] = this.appInstalled;
    data['dealName'] = this.dealName;

    data['userDeviceId'] = this.userDeviceId;
    data['expireDate'] = this.expireDate;
    data['status'] = this.status;
    data['statusReason'] = this.statusReason;
    data['isViewed'] = this.isViewed;
    data['createdBy'] = this.createdBy;
    data['updatedBy'] = this.updatedBy;
    if (this.webhookLogs != null) {
      data['webhookLogs'] = this.webhookLogs!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['canChangeStatus'] = this.canChangeStatus;
    return data;
  }
}

class AdvertiserDealId {
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
  GmngEarning? userEarning;
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

  AdvertiserDealId(
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
      this.banner});

  AdvertiserDealId.fromJson(Map<String, dynamic> json) {
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
        ? GmngEarning.fromJson(json['gmngEarning'])
        : null;
    userEarning = json['userEarning'] != null
        ? GmngEarning.fromJson(json['userEarning'])
        : null;
    limits =
        json['limits'] != null ? Limits.fromJson(json['limits']) : null;
    stats = json['stats'] != null ? Stats.fromJson(json['stats']) : null;
    url = json['url'];
    appPackage = json['appPackage'] != null
        ? AppPackage.fromJson(json['appPackage'])
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
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
   // data['banner'] = this.banner;
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
    final Map<String, dynamic> data = Map<String, dynamic>();
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
    final Map<String, dynamic> data = Map<String, dynamic>();
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
        ? GmngEarning.fromJson(json['totalGmngEarning'])
        : null;
    totalUserEarning = json['totalUserEarning'] != null
        ? GmngEarning.fromJson(json['totalUserEarning'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['android'] = this.android;
    return data;
  }
}

class CallbackData {
  Params? params;
  String? date;
  bool? isAdminAction;

  CallbackData({this.params, this.date, this.isAdminAction});

  CallbackData.fromJson(Map<String, dynamic> json) {
    params =
        json['params'] != null ? Params.fromJson(json['params']) : null;
    date = json['date'];
    isAdminAction = json['isAdminAction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.params != null) {
      data['params'] = this.params!.toJson();
    }
    data['date'] = this.date;
    data['isAdminAction'] = this.isAdminAction;
    return data;
  }
}

class Params {
  String? udId;
  String? s;
  String? m;

  Params({this.udId, this.s, this.m});

  Params.fromJson(Map<String, dynamic> json) {
    udId = json['udId'];
    s = json['s'];
    m = json['m'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['udId'] = this.udId;
    data['s'] = this.s;
    data['m'] = this.m;
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    return data;
  }
}

class WebhookLogs {
  QueryParams? queryParams;
  String? date;

  WebhookLogs({this.queryParams, this.date});

  WebhookLogs.fromJson(Map<String, dynamic> json) {
    queryParams = json['queryParams'] != null
        ? QueryParams.fromJson(json['queryParams'])
        : null;
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.queryParams != null) {
      data['queryParams'] = this.queryParams!.toJson();
    }
    data['date'] = this.date;
    return data;
  }
}

class QueryParams {
  String? s1;

  QueryParams({this.s1});

  QueryParams.fromJson(Map<String, dynamic> json) {
    s1 = json['s1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['s1'] = this.s1;
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['offset'] = this.offset;
    data['total'] = this.total;
    data['count'] = this.count;
    data['limit'] = this.limit;
    return data;
  }
}
