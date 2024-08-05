import 'package:flutter/cupertino.dart';
import 'items/player_data.dart';
import 'items/team_data.dart';

class ListModel with ChangeNotifier {
  final List<PlayerData> _batters = [];
  final List<PlayerData> _bowlers = [];
  final List<PlayerData> _allRounders = [];

  final List<TeamData> teams = [];

  List<PlayerData> get batters => _batters;
  List<PlayerData> get bowlers => _bowlers;
  List<PlayerData> get allRounders => _allRounders;


  void addNewTeam(TeamData teamItem) {
    teams.add(teamItem);
    notifyListeners();
  }

  void addBatterToTeam(String teamId, PlayerData batter) {
    final team = teams.firstWhere((team) => team.teamId == teamId);
    team.batters.add(batter);
    notifyListeners();
  }

  void addBowlerToTeam(String teamId, PlayerData bowler) {
    final team = teams.firstWhere((team) => team.teamId == teamId);
    team.bowlers.add(bowler);
    notifyListeners();
  }

  void addAllRounderToTeam(String teamId, PlayerData allRounder) {
    final team = teams.firstWhere((team) => team.teamId == teamId);
    team.allRounders.add(allRounder);
    notifyListeners();
  }

  List<PlayerData> getTeamBatters(String teamId) {
    return teams.firstWhere((team) => team.teamId == teamId).batters;
  }

  List<PlayerData> getTeamBowlers(String teamId) {
    return teams.firstWhere((team) => team.teamId == teamId).bowlers;
  }

  List<PlayerData> getTeamAllRounders(String teamId) {
    return teams.firstWhere((team) => team.teamId == teamId).allRounders;
  }

}