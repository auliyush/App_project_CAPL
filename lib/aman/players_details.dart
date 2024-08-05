import 'dart:async';

import 'about_player_details_page.dart';

class PlayerLists{
  int? playerRank;
  String? playerPhotoUrl;
  String? playerName;
  String? playerTeamName;
  int? playerRuns;

  PlayerLists({
    required this.playerRank,
    required this.playerPhotoUrl,
    required this.playerName,
    required this.playerTeamName,
    required this.playerRuns,
  });

  static List<PlayerLists> players(){
    return[
      PlayerLists(
          playerRank: 02,
          playerPhotoUrl: 'assets/images/rohit.jpeg',
          playerName: 'Rohit Sharma',
          playerTeamName: "MI",
          playerRuns: 500
      ),
      PlayerLists(
          playerRank: 03,
          playerPhotoUrl: 'assets/images/rohit.jpeg',
          playerName: 'Rohit Sharma',
          playerTeamName: "MI",
          playerRuns: 500
      ),
    ];
  }
}