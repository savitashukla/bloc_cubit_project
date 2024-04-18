class GameModel {
  List<Banners>? banners;
  List<GameCategories>? gameCategories;

  GameModel({this.banners,  this.gameCategories});

  GameModel.fromJson(Map<String, dynamic> json) {
    if (json['banners'] != null) {
      banners = <Banners>[];
      json['banners'].forEach((v) {
        banners!.add(new Banners.fromJson(v));
      });
    }

    if (json['gameCategories'] != null) {
      gameCategories = <GameCategories>[];
      json['gameCategories'].forEach((v) {
        gameCategories!.add(GameCategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.banners != null) {
      data['banners'] = this.banners!.map((v) => v.toJson()).toList();
    }

    if (this.gameCategories != null) {
      data['gameCategories'] =
          this.gameCategories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Banners {
  String? id;
  Image? image;
  String? category;
  String? type;
  String? name;
  String? externalUrl;
  String? gameId;
  String? eventId;
  bool? isPlayStore;

  String? screen;
  List<String>? appTypes;
  bool? isPopUp;

  Banners(
      {this.id,
        this.image,
        this.category,
        this.type,
        this.name,
        this.externalUrl,
        this.gameId,
        this.eventId,
        this.isPlayStore,
        this.screen,
        this.appTypes,
        this.isPopUp});

  Banners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'] != null ? new Image.fromJson(json['image']) : null;
    category = json['category'];
    type = json['type'];
    name = json['name'];
    externalUrl = json['externalUrl'];
    gameId = json['gameId'];
    eventId = json['eventId'];
    isPlayStore = json['isPlayStore'];
    if (json['campaignIds'] != null) {


    }
    screen = json['screen'];
    appTypes = json['appTypes'].cast<String>();
    isPopUp = json['isPopUp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
    data['category'] = this.category;
    data['type'] = this.type;
    data['name'] = this.name;
    data['externalUrl'] = this.externalUrl;
    data['gameId'] = this.gameId;
    data['eventId'] = this.eventId;
    data['isPlayStore'] = this.isPlayStore;

    data['screen'] = this.screen;
    data['appTypes'] = this.appTypes;
    data['isPopUp'] = this.isPopUp;
    return data;
  }
}

class Image {
  String? id;
  String? url;

  Image({this.id, this.url});

  Image.fromJson(Map<String, dynamic> json) {
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

class GameCategories {
  String? id;
  bool? isPlayStore;
  String? name;
  int? order;
  bool? isRMG;
  List<Games>? games;

  GameCategories(
      {this.id,
        this.isPlayStore,
        this.name,
        this.order,
        this.isRMG,
        this.games});

  GameCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isPlayStore = json['isPlayStore'];
    name = json['name'];
    order = json['order'];
    isRMG = json['isRMG'];
    if (json['games'] != null) {
      games = <Games>[];
      json['games'].forEach((v) {
        games!.add(new Games.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['isPlayStore'] = this.isPlayStore;
    data['name'] = this.name;
    data['order'] = this.order;
    data['isRMG'] = this.isRMG;
    if (this.games != null) {
      data['games'] = this.games!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Games {
  String? id;
  Image? banner;
  ThirdParty? thirdParty;
  String? name;
  int? order;
  bool? isClickable;
  String? howToPlayUrl;
  bool? isUnity;
  String? systemRankPreference;
  bool? isPlayStore;

  Games(
      {this.id,
        this.banner,
        this.thirdParty,
        this.name,
        this.order,
        this.isClickable,
        this.howToPlayUrl,
        this.isUnity,
        this.systemRankPreference,
        this.isPlayStore});

  Games.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    banner = json['banner'] != null ? new Image.fromJson(json['banner']) : null;
    thirdParty = json['thirdParty'] != null
        ? new ThirdParty.fromJson(json['thirdParty'])
        : null;
    name = json['name'];
    order = json['order'];
    isClickable = json['isClickable'];
    howToPlayUrl = json['howToPlayUrl'];
    isUnity = json['isUnity'];
    systemRankPreference = json['systemRankPreference'];
    isPlayStore = json['isPlayStore'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.banner != null) {
      data['banner'] = this.banner!.toJson();
    }
    if (this.thirdParty != null) {
      data['thirdParty'] = this.thirdParty!.toJson();
    }
    data['name'] = this.name;
    data['order'] = this.order;
    data['isClickable'] = this.isClickable;
    data['howToPlayUrl'] = this.howToPlayUrl;
    data['isUnity'] = this.isUnity;
    data['systemRankPreference'] = this.systemRankPreference;
    data['isPlayStore'] = this.isPlayStore;
    return data;
  }
}

class ThirdParty {
  String? name;
  String? url;

  ThirdParty({this.name, this.url});

  ThirdParty.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}
