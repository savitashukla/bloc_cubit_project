import 'package:equatable/equatable.dart';

import '../../../model/game/game_model.dart';

class GameEquatable extends Equatable {
  final bool isProcessing;

  GameModel? gameModelRes;
  List<Games>?  gameList;

  GameEquatable({
    required this.isProcessing,
    this.gameModelRes,
    this.gameList,
  });

  GameEquatable.init(
      {required this.isProcessing, this.gameModelRes, this.gameList});

  GameEquatable copyWith({
    bool? isProcessing,
    GameModel? gameModelRes,
    List<Games>? gameList,
  }) {
    return GameEquatable(
        isProcessing: isProcessing ?? this.isProcessing,
        gameModelRes: gameModelRes ?? this.gameModelRes,
        gameList: gameList ?? this.gameList);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [isProcessing, gameModelRes, gameList];
}
