import 'package:merge_capl/hold_models/items/player_data.dart';

class TeamData {
  String teamId;
  String teamName;
  String teamNickName;
  String teamProfileUrl;
  List<PlayerData> batters;
  List<PlayerData> bowlers;// Add this
  List<PlayerData> allRounders;// Add this

  TeamData({
    required this.teamId,
    required this.teamName,
    required this.teamNickName,
    required this.teamProfileUrl,
    this.batters = const [], // Initialize with an empty list
    this.bowlers = const [], // Initialize with an empty list
    this.allRounders = const [], // Initialize with an empty list
  });
}