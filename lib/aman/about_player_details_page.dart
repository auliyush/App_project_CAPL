import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart'; // Import the share_plus package

class PlayerProfilePage extends StatelessWidget {
  final String playerUrl;
  final String playerName;
  final String playerType;
  final String playerDebut;
  final String playerDob;
  final String playerMatches;
  final String playerAboutDetails;
  final String playerRuns;
  final String playerHighestScore;
  final String playerAverage;
  final String playerStrikeRate;
  final String playerHalfCentury;
  final String playerCentury;
  final String playerFour;
  final String playerSix;
  final String playerCatches;
  final String playerStumping;
  final String playerWickets;
  final String playerBestWicket;
  final String playerLessRun;
  final String playerEconomy;
  final String playerFourWicket;
  final String playerFiveWicket;

  PlayerProfilePage({
    required this.playerUrl,
    required this.playerName,
    required this.playerType,
    required this.playerDebut,
    required this.playerDob,
    required this.playerMatches,
    required this.playerAboutDetails,
    required this.playerRuns,
    required this.playerHighestScore,
    required this.playerAverage,
    required this.playerStrikeRate,
    required this.playerHalfCentury,
    required this.playerCentury,
    required this.playerFour,
    required this.playerSix,
    required this.playerCatches,
    required this.playerStumping,
    required this.playerWickets,
    required this.playerBestWicket,
    required this.playerLessRun,
    required this.playerEconomy,
    required this.playerFourWicket,
    required this.playerFiveWicket,
  });

  void _sharePlayerDetails() {
    final String content = '''
    Player Name: $playerName
    Player Type: $playerType
    Debut: $playerDebut
    DOB: $playerDob
    Matches: $playerMatches
    About: $playerAboutDetails
    Runs: $playerRuns
    Highest Score: $playerHighestScore
    Average: $playerAverage
    Strike Rate: $playerStrikeRate
    50s/100s: $playerHalfCentury / $playerCentury
    4s/6s: $playerFour / $playerSix
    Catches: $playerCatches
    Stumpings: $playerStumping
    Wickets: $playerWickets
    Best Bowling: $playerBestWicket
    Economy: $playerEconomy
    4w/5w: $playerFourWicket / $playerFiveWicket
    ''';

    Share.share(content);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg.jpg'),
              fit: BoxFit.cover,
              opacity: 0.7,
            ),
            color: Colors.blue,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              ),
              Image.asset(
                playerUrl,
                height: 300,
                width: double.infinity,
                fit: BoxFit.fitHeight,
              ),
              SizedBox(height: 20),
              Container(
                color: Colors.transparent,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      playerName,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      playerType,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        PlayerDetailColumn(
                          title: 'IPL Debut',
                          value: playerDebut,
                        ),
                        PlayerDetailColumn(
                          title: 'DOB',
                          value: playerDob,
                        ),
                        PlayerDetailColumn(
                          title: 'Matches',
                          value: playerMatches,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  color: Colors.white.withOpacity(0.5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('About', style: TextStyle(fontSize: 20)),
                          IconButton(
                            icon: Icon(Icons.share),
                            onPressed: _sharePlayerDetails,
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Divider(),
                      SizedBox(height: 20),
                      Text(
                        playerAboutDetails,
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 20),
                      Divider(),
                      SizedBox(height: 30),
                      Text(
                        'Batting & Fielding Stats',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      buildStatsGrid([
                        {'title': 'Matches', 'value': playerMatches},
                        {'title': 'Runs', 'value': playerRuns},
                        {'title': 'Highest Score', 'value': playerHighestScore},
                        {'title': 'Average', 'value': playerAverage},
                        {'title': 'Strike Rate', 'value': playerStrikeRate},
                        {'title': '50s/100s', 'value': playerHalfCentury + '/' + playerCentury},
                        {'title': '4s/6s', 'value': playerFour + '/' + playerSix},
                        {'title': 'Catches', 'value': playerCatches},
                        {'title': 'Stumpings', 'value': playerStumping},
                      ]),
                      SizedBox(height: 20),
                      Text(
                        'Bowling Stats',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      buildStatsGrid([
                        {'title': 'Matches', 'value': '66'},
                        {'title': 'Wickets', 'value': '0'},
                        {'title': 'Best Bowling', 'value': '3/17'},
                        {'title': 'Economy', 'value': '9.10'},
                        {'title': 'Strike Rate', 'value': '22.16'},
                        {'title': '4w/5w', 'value': '0/0'},
                      ]),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildStatsGrid(List<Map<String, String>> stats) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double gridWidth = constraints.maxWidth - 32; // Subtract padding
        double itemWidth = gridWidth / 3; // Width for each item
        double itemHeight = 120; // Adjust height for better visibility

        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: itemWidth / itemHeight,
          ),
          itemCount: stats.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final stat = stats[index];
            return Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        stat['value']!,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        stat['title']!,
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class PlayerDetailColumn extends StatelessWidget {
  final String title;
  final String value;

  PlayerDetailColumn({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          value,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }
}
