import 'package:flutter/material.dart';

class SquadsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth > 600;

    return ListView(
      padding: EdgeInsets.all(10.0),
      children: <Widget>[
        buildHeader(
          'assets/images/morebg.jpeg',
          'Sri Lanka',
          'assets/images/morebg.jpeg',
          'India'
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: buildTeamList('SL', slPlayers, slBench, isLargeScreen),
            ),
            Expanded(
              child: buildTeamList('IND', indPlayers, indBench, isLargeScreen),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildHeader(String teamFirstPhotoUrl, String teamFirstName,
      String teamSecondPhotoUrl, String teamSecondName) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Row(
              children: [
               const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/morebg.jpeg'),
                ),
                Text(
                    teamFirstName
                ),
              ],
            ),
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/morebg.jpeg'),
            )
          ],
        )
      ],
    );
  }

  Widget buildTeamList(String team, List<Player> players, List<Player> bench, bool isLargeScreen) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$team Players',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: isLargeScreen ? 400 : 300, // Adjust based on content and screen size
          ),
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: players.length,
            itemBuilder: (context, index) {
              return buildPlayerInfo(players[index]);
            },
          ),
        ),
        Text(
          '$team Bench',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: isLargeScreen ? 200 : 150, // Adjust based on content and screen size
          ),
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: bench.length,
            itemBuilder: (context, index) {
              return buildPlayerInfo(bench[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget buildPlayerInfo(Player player) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white, // White background
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Black shadow
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(player.imageUrl), // Image URL for players
          ),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  player.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // Black text for player name
                  ),
                ),
                Text(
                  player.role,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey, // Grey text for player role
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Player {
  final String name;
  final String role;
  final String imageUrl;

  Player(this.name, this.role, this.imageUrl);
}

final List<Player> slPlayers = [
  Player('Pathum Nissanka', 'Batter', 'URL_TO_IMAGE'),
  Player('Avishka Fernando', 'Batter', 'URL_TO_IMAGE'),
  Player('Kusal Mendis (wk)', 'WK-Batter', 'URL_TO_IMAGE'),
  Player('Samarawickrama', 'WK-Batter', 'URL_TO_IMAGE'),
];

final List<Player> indPlayers = [
  Player('Rohit (c)', 'Batter', 'URL_TO_IMAGE'),
  Player('Shubman Gill', 'Batter', 'URL_TO_IMAGE'),
  Player('Kohli', 'Batter', 'URL_TO_IMAGE'),
  Player('Shreyas Iyer', 'Batter', 'URL_TO_IMAGE'),
];

final List<Player> slBench = [
  Player('M Theekshana', 'Bowler', 'URL_TO_IMAGE'),
  Player('C Karunaratne', 'Bowling Allrounder', 'URL_TO_IMAGE'),
  Player('Kamindu Mendis', 'Batting Allrounder', 'URL_TO_IMAGE'),
];

final List<Player> indBench = [
  Player('Pant', 'WK-Batter', 'URL_TO_IMAGE'),
  Player('Khaleel Ahmed', 'Bowler', 'URL_TO_IMAGE'),
  Player('Riyan Parag', 'Batting Allrounder', 'URL_TO_IMAGE'),
];