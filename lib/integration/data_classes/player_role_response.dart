class PlayerRoleResponse {

  String playerName;
  int jerseyNumber;

  PlayerRoleResponse({required this.playerName , required this.jerseyNumber});

  factory PlayerRoleResponse.fromJson(Map<String , dynamic> json) {
    return PlayerRoleResponse(
      playerName: json["playerName"],
      jerseyNumber: json["jerseyNumber"],
    );
  }
}
// void main() {
//   List<String> playerList = [
//     'Player1',
//     'Player2',
//     'Player3',
//     'Player4',
//     'Player5',
//     'Player6',
//     'Player7',
//     'Player8',
//     'Player9',
//     'Player10'
//   ];
//
//   List<String> players = ['Player3', 'Player6', 'Player9', 'Player1'];
//
//   // Step 1: Print players from the players list
//   for (String player in players) {
//     print(player);
//   }
//
//   // Step 2: Print remaining players from playerList that are not in players
//   for (String player in playerList) {
//     if (!players.contains(player)) {
//       print(player);
//     }
//   }
// }
