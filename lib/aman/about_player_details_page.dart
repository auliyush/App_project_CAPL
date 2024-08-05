import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow.shade700,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Player Image
            Image.asset(
              playerUrl,
              height: 400,
              width: double.infinity,
              fit: BoxFit.fitHeight,
            ),
            SizedBox(height: 20),
            Container(
              color: Colors.transparent, // Transparent background
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
                    playerType, // Player Type
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
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.circular(10),
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
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(38.0),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    bool isWideScreen = constraints.maxWidth > 450;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('About', style: TextStyle(fontSize: 20)),
                            Icon(Icons.share),
                          ],
                        ),
                        SizedBox(height: 10),
                        Divider(),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Center(
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
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
                                    isWideScreen
                                        ? buildWideStatsRow([
                                      {'title': 'Matches', 'value': playerMatches},
                                      {'title': 'Runs', 'value': playerRuns},
                                      {'title': 'Highest Score', 'value': playerHighestScore},
                                    ])
                                        : buildNarrowStatsRow([
                                      {'title': 'Matches', 'value': playerMatches},
                                      {'title': 'Runs', 'value': playerRuns},
                                      {'title': 'Highest Score', 'value': playerHighestScore},
                                    ]),
                                    isWideScreen
                                        ? buildWideStatsRow([
                                      {'title': 'Average', 'value': playerAverage},
                                      {'title': 'Strike Rate', 'value': playerStrikeRate},
                                      {'title': '50s/100s', 'value': playerHalfCentury + '/' + playerCentury},
                                    ])
                                        : buildNarrowStatsRow([
                                      {'title': 'Average', 'value': playerAverage},
                                      {'title': 'Strike Rate', 'value': playerStrikeRate},
                                      {'title': '50s/100s', 'value': playerHalfCentury + '/' + playerCentury},
                                    ]),
                                    isWideScreen
                                        ? buildWideStatsRow([
                                      {'title': '4s/6s', 'value': playerFour + '/' + playerSix},
                                      {'title': 'Catches', 'value': playerCatches},
                                      {'title': 'Stumpings', 'value': playerStumping},
                                    ])
                                        : buildNarrowStatsRow([
                                      {'title': '4s/6s', 'value': playerFour + '/' + playerSix},
                                      {'title': 'Catches', 'value': playerCatches},
                                      {'title': 'Stumpings', 'value': playerStumping},
                                    ]),
                                    SizedBox(height: 20),
                                    Text(
                                      'Bowling Stats',
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 30),
                                    isWideScreen
                                        ? buildWideStatsRow([
                                      {'title': 'Matches', 'value': '66'},
                                      {'title': 'Wickets', 'value': '0'},
                                      {'title': 'Best Bowling', 'value': '3/17'},
                                    ])
                                        : buildNarrowStatsRow([
                                      {'title': 'Matches', 'value': '66'},
                                      {'title': 'Wickets', 'value': '0'},
                                      {'title': 'Best Bowling', 'value': '3/17'},
                                    ]),
                                    isWideScreen
                                        ? buildWideStatsRow([
                                      {'title': 'Economy', 'value': '9.10'},
                                      {'title': 'Strike Rate', 'value': '22.16'},
                                      {'title': '4w/5w', 'value': '0/0'},
                                    ])
                                        : buildNarrowStatsRow([
                                      {'title': 'Economy', 'value': '9.10'},
                                      {'title': 'Strike Rate', 'value': '22.16'},
                                      {'title': '4w/5w', 'value': '0/0'},
                                    ]),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildWideStatsRow(List<Map<String, String>> stats) {
    return Row(
      children: stats.map((stat) {
        return Expanded(
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(stat['value']!, style: TextStyle(fontSize: 15)),
                    Text(stat['title']!, style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget buildNarrowStatsRow(List<Map<String, String>> stats) {
    return Column(
      children: stats.map((stat) {
        return Container(
          height: 80,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(stat['value']!, style: TextStyle(fontSize: 15)),
                  Text(stat['title']!, style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
          ),
        );
      }).toList(),
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
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}
