import 'package:cubit_project/utils/help_method.dart';

class GameEventList {
  List<Data>? data;
  Pagination? pagination;
  Meta? meta;

  GameEventList({this.data, this.pagination, this.meta});

  GameEventList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;

    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }

    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  String? name;
  String? description;
  String? type;
  bool? isRMG;
  int? totalTeams;
  int? maxPlayers;
  Entry? entry;
  Fee? platformFee;
  Winner? winner;
  EventDate? eventDate;
  String? password;
  String? streamUrl;
  String? clanUrl;
  String? rules;
  Banner? banner;
  List<RankAmount>? rankAmount;
  List<Rounds>? rounds;
  bool? isTrendingEvent;
  String? status;

  int? perUserJoinCount;

  JoinSummary? joinSummary;
  String? groupId;
  bool? isHousePlayerAllowed;
  String? createdBy;
  String? updatedBy;
  String? createdAt;
  String? updatedAt;
  GameId? gameId;

  TeamTypeId? teamTypeId;

  Data(
      {this.id,
      this.name,
      this.description,
      this.type,
      this.isRMG,
      this.totalTeams,
      this.maxPlayers,
      this.entry,
      this.platformFee,
      this.winner,
      this.eventDate,
      this.password,
      this.streamUrl,
      this.clanUrl,
      this.rules,
      this.banner,
      this.rankAmount,
      this.rounds,
      this.isTrendingEvent,
      this.status,
      this.perUserJoinCount,
      this.joinSummary,
      this.groupId,
      this.isHousePlayerAllowed,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt,
      this.gameId,
      this.teamTypeId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    type = json['type'];
    isRMG = json['isRMG'];
    totalTeams = json['totalTeams'];
    maxPlayers = json['maxPlayers'];
    entry = json['entry'] != null ? new Entry.fromJson(json['entry']) : null;
    platformFee = json['platformFee'] != null
        ? new Fee.fromJson(json['platformFee'])
        : null;
    winner =
        json['winner'] != null ? new Winner.fromJson(json['winner']) : null;
    eventDate = json['eventDate'] != null
        ? new EventDate.fromJson(json['eventDate'])
        : null;
    password = json['password'];
    streamUrl = json['streamUrl'];
    clanUrl = json['clanUrl'];
    rules = json['rules'];

    banner =
        json['banner'] != null ? new Banner.fromJson(json['banner']) : null;
    if (json['rankAmount'] != null) {
      rankAmount = <RankAmount>[];
      json['rankAmount'].forEach((v) {
        rankAmount!.add(new RankAmount.fromJson(v));
      });
    }
    if (json['rounds'] != null) {
      rounds = <Rounds>[];
      json['rounds'].forEach((v) {
        rounds!.add(new Rounds.fromJson(v));
      });
    }
    isTrendingEvent = json['isTrendingEvent'];
    status = json['status'];

    perUserJoinCount = json['perUserJoinCount'];

    joinSummary = json['joinSummary'] != null
        ? new JoinSummary.fromJson(json['joinSummary'])
        : null;
    groupId = json['groupId'];
    isHousePlayerAllowed = json['isHousePlayerAllowed'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];

    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];

    gameId =
        json['gameId'] != null ? new GameId.fromJson(json['gameId']) : null;

    teamTypeId = json['teamTypeId'] != null
        ? new TeamTypeId.fromJson(json['teamTypeId'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['type'] = this.type;
    data['isRMG'] = this.isRMG;
    data['totalTeams'] = this.totalTeams;
    data['maxPlayers'] = this.maxPlayers;
    if (this.entry != null) {
      data['entry'] = this.entry!.toJson();
    }
    if (this.platformFee != null) {
      data['platformFee'] = this.platformFee!.toJson();
    }
    if (this.winner != null) {
      data['winner'] = this.winner!.toJson();
    }
    if (this.eventDate != null) {
      data['eventDate'] = this.eventDate!.toJson();
    }
    data['password'] = this.password;
    data['streamUrl'] = this.streamUrl;
    data['clanUrl'] = this.clanUrl;
    data['rules'] = this.rules;

    if (banner != null) {
      data['banner'] = banner!.toJson();
    }
    if (this.rankAmount != null) {
      data['rankAmount'] = this.rankAmount!.map((v) => v.toJson()).toList();
    }
    if (this.rounds != null) {
      data['rounds'] = this.rounds!.map((v) => v.toJson()).toList();
    }
    data['isTrendingEvent'] = this.isTrendingEvent;
    data['status'] = this.status;

    data['perUserJoinCount'] = this.perUserJoinCount;

    if (this.joinSummary != null) {
      data['joinSummary'] = this.joinSummary!.toJson();
    }
    data['groupId'] = this.groupId;
    data['isHousePlayerAllowed'] = this.isHousePlayerAllowed;
    data['createdBy'] = this.createdBy;
    data['updatedBy'] = this.updatedBy;

    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.gameId != null) {
      data['gameId'] = this.gameId!.toJson();
    }

    if (this.teamTypeId != null) {
      data['teamTypeId'] = this.teamTypeId!.toJson();
    }
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

class Entry {
  Fee? fee;
  String? type;
  int? feeBonusPercentage;



  Entry({this.fee, this.type, this.feeBonusPercentage});

  num getBonuse() {
    num value = 0;
    value = ((fee!.value! / 100 * feeBonusPercentage!) / 100);
    return value;
  }

  Entry.fromJson(Map<String, dynamic> json) {
    fee = json['fee'] != null ? new Fee.fromJson(json['fee']) : null;
    type = json['type'];
    feeBonusPercentage = json['feeBonusPercentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.fee != null) {
      data['fee'] = this.fee!.toJson();
    }
    data['type'] = this.type;
    data['feeBonusPercentage'] = this.feeBonusPercentage;
    return data;
  }
}

class Fee {
  String? type;
  int? value;

  Fee({this.type, this.value});

  Fee.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    value = json['value'];
  }

  bool? isBonuseType() {
    bool? isBonuseType = false;
    HelpMethod().customPrint(this.type);
    if (type == "bonus") {
      isBonuseType = true;
    }
    HelpMethod().customPrint("is_bonuse_type==>${isBonuseType}");
    return isBonuseType;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['value'] = this.value;
    return data;
  }
}

class Winner {
  String? type;
  Fee? prizeAmount;
  String? customPrize;
  Null? perKillWallet;
  Null? customPerKillPrize;

  Winner(
      {this.type,
      this.prizeAmount,
      this.customPrize,
      this.perKillWallet,
      this.customPerKillPrize});

  Winner.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    prizeAmount = json['prizeAmount'] != null
        ? new Fee.fromJson(json['prizeAmount'])
        : null;
    customPrize = json['customPrize'];
    perKillWallet = json['perKillWallet'];
    customPerKillPrize = json['customPerKillPrize'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.prizeAmount != null) {
      data['prizeAmount'] = this.prizeAmount!.toJson();
    }
    data['customPrize'] = this.customPrize;
    data['perKillWallet'] = this.perKillWallet;
    data['customPerKillPrize'] = this.customPerKillPrize;
    return data;
  }
}

class EventDate {
  String? start;
  int? startTime;
  String? end;
  int? endTime;

  EventDate({this.start, this.startTime, this.end, this.endTime});

  EventDate.fromJson(Map<String, dynamic> json) {
    start = json['start'];
    startTime = json['startTime'];
    end = json['end'];
    endTime = json['endTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start'] = this.start;
    data['startTime'] = this.startTime;
    data['end'] = this.end;
    data['endTime'] = this.endTime;
    return data;
  }
}

class RankAmount {
  String? id;
  int? serialNumber;
  Fee? amount;
  String? wallet;
  String? custom;
  int? rankFrom;
  int? rankTo;

  RankAmount(
      {this.id,
      this.serialNumber,
      this.amount,
      this.wallet,
      this.custom,
      this.rankFrom,
      this.rankTo});

  RankAmount.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serialNumber = json['serialNumber'];
    amount = json['amount'] != null ? new Fee.fromJson(json['amount']) : null;
    wallet = json['wallet'];
    custom = json['custom'];
    rankFrom = json['rankFrom'];
    rankTo = json['rankTo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['serialNumber'] = this.serialNumber;
    if (this.amount != null) {
      data['amount'] = this.amount!.toJson();
    }
    data['wallet'] = this.wallet;
    data['custom'] = this.custom;
    data['rankFrom'] = this.rankFrom;
    data['rankTo'] = this.rankTo;
    return data;
  }
}

class Rounds {
  String? id;
  int? serialNumber;
  String? name;
  String? status;
  Null? roomId;
  Null? roomPassword;
  bool? isResultDeclared;
  bool? isFinalRound;

  Rounds(
      {this.id,
      this.serialNumber,
      this.name,
      this.status,
      this.roomId,
      this.roomPassword,
      this.isResultDeclared,
      this.isFinalRound});

  Rounds.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serialNumber = json['serialNumber'];
    name = json['name'];
    status = json['status'];
    roomId = json['roomId'];
    roomPassword = json['roomPassword'];
    isResultDeclared = json['isResultDeclared'];
    isFinalRound = json['isFinalRound'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['serialNumber'] = this.serialNumber;
    data['name'] = this.name;
    data['status'] = this.status;
    data['roomId'] = this.roomId;
    data['roomPassword'] = this.roomPassword;
    data['isResultDeclared'] = this.isResultDeclared;
    data['isFinalRound'] = this.isFinalRound;
    return data;
  }
}

class JoinSummary {
  int? users;
  int? teams;

  JoinSummary({this.users, this.teams});

  JoinSummary.fromJson(Map<String, dynamic> json) {
    users = json['users'];
    teams = json['teams'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['users'] = this.users;
    data['teams'] = this.teams;
    return data;
  }
}

class GameId {
  String? id;
  String? name;

  GameId({this.id, this.name});

  GameId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class TeamTypeId {
  String? id;
  String? name;
  int? size;

  TeamTypeId({this.id, this.name, this.size});

  TeamTypeId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['size'] = this.size;
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

class Meta {
  String? serverTime;

  Meta({this.serverTime});

  Meta.fromJson(Map<String, dynamic> json) {
    serverTime = json['serverTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['serverTime'] = this.serverTime;
    return data;
  }
}
