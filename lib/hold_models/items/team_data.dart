import 'package:merge_capl/hold_models/items/player_data.dart';

class TeamData {
  String teamId;
  String teamName;
  String teamNickName;
  String teamProfileUrl;
  List<PlayerData> batters;
  List<PlayerData> bowlers;
  List<PlayerData> allRounders;

  TeamData({
    required this.teamId,
    required this.teamName,
    required this.teamNickName,
    required this.teamProfileUrl,
    this.batters = const [],
    this.bowlers = const [],
    this.allRounders = const [],
  });
}