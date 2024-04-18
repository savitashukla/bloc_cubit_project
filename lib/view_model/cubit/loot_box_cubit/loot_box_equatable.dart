part of 'loot_box_cubit.dart';

class LootBoxEquatable extends Equatable {
  final bool isProcessing;
  final int selectedCategoryIndex;
  final int currentIndex;
  bool checkTurnOffLootBox;
  var colorPrimaryOfferWall;
  var colorwhiteOfferWall;
  LoginModel? loginResponse;
  LootBoxAdvertisersModel? lootBoxAdvertisers;
  UserdealModel? userDealHistory;
  int secondV;
  String? onlyNumber ;

  PublicSetting? publicSetting;

  LootBoxEquatable({
    required this.isProcessing,
    required this.selectedCategoryIndex,
    required this.currentIndex,
    required this.checkTurnOffLootBox,
    required this.colorPrimaryOfferWall,
    required this.colorwhiteOfferWall,
    this.loginResponse,
    this.lootBoxAdvertisers,
    this.userDealHistory,
    required this.secondV,
    required this.onlyNumber,
    this.publicSetting,
  });

  LootBoxEquatable.init({
    required this.isProcessing,
    required this.selectedCategoryIndex,
    required this.currentIndex,

    this.loginResponse,
    this.lootBoxAdvertisers,
    required this.checkTurnOffLootBox,
    required this.colorPrimaryOfferWall,
    required this.colorwhiteOfferWall,
    this.userDealHistory,
    required this.secondV,
    required this.onlyNumber,
    this.publicSetting,
  });

  LootBoxEquatable copyWith({
    bool? isProcessing,
    int? selectedCategoryIndex,
    int? currentIndex,
    LoginModel? loginResponse,
    LootBoxAdvertisersModel? lootBoxAdvertisers,
    UserdealModel? userDealHistory,
    bool? checkTurnOffLootBox,
    final colorPrimaryOfferWall,
    final colorwhiteOfferWall,
    int? secondV,
    String? onlyNumber,

    PublicSetting? publicSetting,
  }) {
    return LootBoxEquatable(
        isProcessing: isProcessing ?? this.isProcessing,
        selectedCategoryIndex:
        selectedCategoryIndex ?? this.selectedCategoryIndex,
        currentIndex: currentIndex ?? this.currentIndex,
        loginResponse: loginResponse ?? this.loginResponse,
        lootBoxAdvertisers: lootBoxAdvertisers ?? this.lootBoxAdvertisers,
        userDealHistory: userDealHistory ?? this.userDealHistory,
        checkTurnOffLootBox: checkTurnOffLootBox ?? this.checkTurnOffLootBox,
        colorPrimaryOfferWall: colorPrimaryOfferWall ??
            this.colorPrimaryOfferWall,
        colorwhiteOfferWall: colorwhiteOfferWall ?? this.colorwhiteOfferWall,
        secondV:secondV ?? this.secondV,
        publicSetting:publicSetting ?? this.publicSetting,
        onlyNumber:onlyNumber ?? this.onlyNumber
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props =>
      [
        isProcessing,
        selectedCategoryIndex,
        currentIndex,
        loginResponse,
        lootBoxAdvertisers,
        checkTurnOffLootBox,
        colorPrimaryOfferWall,
        colorwhiteOfferWall,
        userDealHistory,
        secondV,
        publicSetting,
        onlyNumber
      ];
}
