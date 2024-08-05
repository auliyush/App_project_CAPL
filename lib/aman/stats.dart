import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:merge_capl/aman/players_details.dart';
import 'package:merge_capl/fuck.dart';
import 'package:merge_capl/home.dart';

import 'about_player_details_page.dart';
import 'extra.dart';
import 'floate_button.dart';

class Stats extends StatefulWidget {
  final String playersTeamLogoUrl;
  final String playersProfileUrl;
  final String position;
  final String playersName;
  final String matches;
  final String average;
  final String run;
  final String strikeRate;
  final String playersCentury;
  final String playersHalfCentury;
  final String playerHighScore;

  Stats({
    required this.playersTeamLogoUrl,
    required this.playersProfileUrl,
    required this.position,
    required this.playersName,
    required this.matches,
    required this.average,
    required this.run,
    required this.strikeRate,
    required this.playersCentury,
    required this.playersHalfCentury,
    required this.playerHighScore,
  });

  @override
  State<Stats> createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  final playerList = PlayerLists.players();

  List<PlayerLists> _foundPlayers = [];

  @override
  void initState() {
    _foundPlayers = playerList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          color: Colors.white,
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Pages()));
          },
        ),
        backgroundColor: Color(0xFF3b3b6d),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [

            Column(
              children: [
                Icon(Icons.emoji_events),
                Text('Awards'),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SeasonSelector()),
          );
        },
        child: Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Handle button press for 'Season'
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange.shade900,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: Size(180, 50),
                    ),
                    child: Text(
                      'Season',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Stats(
                                  playersTeamLogoUrl:
                                      'assets/images/milogo.jpeg',
                                  playersProfileUrl: 'assets/images/rohit.jpeg',
                                  position: '01',
                                  playersName: 'ROHIT SHARMA',
                                  matches: '98',
                                  average: '122',
                                  run: '3456',
                                  strikeRate: '145',
                                  playersCentury: '5',
                                  playersHalfCentury: '35',
                                  playerHighScore: '108',
                                )),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: Size(180, 50),
                    ),
                    child: Text(
                      'Records',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PlayerProfilePage(
                              playerUrl: 'assets/images/rohit.jpeg',
                              playerName: 'ROHIT SHARMA',
                              playerType: 'Batsman',
                              playerDebut: '2009',
                              playerDob: '05-09-1992',
                              playerMatches: '86',
                              playerAboutDetails:
                                  "Captain Marvellous. Rohit Sharma has etched his name as the most successful captain in the IPL with five trophies, the most by anyone in the tournament. He has cracked the code and made MI the most consistent team.+"
                                  "A prolific run-getter, the Hitman is one of the most naturally gifted batsmen in the world and has been enjoying a tremendous run with the bat. When it comes to the shorter format, there are few who can match his striking abilities.+"
                                  "Rohit proved why he is regarded as a special talent when he became the first batsman to strike two double centuries in the ODIs and he now has three. He was one of the most consistent Deccan Chargers batsmen in the first three seasons of the IPL and was instrumental in his former franchise winning the crown in 2009+"
                                  "However, since 2011, Rohit has been an integral part of the Mumbai Indians guiding their batting line-up. He took over the team's captaincy a couple of games into the 2013 season and led MI to their maiden IPL title. In the same year, MI also completed a grand double when they clinched the Champions League T20 title. His captaincy was put to test in the 2015 season after the team won just one of their first six games and were struggling to stay afloat. Mumbai Indians then staged a remarkable turnaround and lifted the Trophy for the second time with a convincing win in the final. Rohit, who made a half-century, was named the Player of the Match.+"
                                  "The legacy of Hitman expanded further on, after powering Mumbai Indians to title victories in the 2017 and 2019 seasons, both being last ball thrillers. Rohit led the Mumbai Indians to a successful campaign in the 2020 season, which was their second consecutive title. MI did not qualify for playoffs in the 14th season and will be raring to go this time.+"
                                  "He now returns as Team India's full-time captain in all three formats of the game.",
                              playerRuns: '5055',
                              playerHighestScore: '117',
                              playerAverage: '55',
                              playerStrikeRate: '173',
                              playerHalfCentury: '32',
                              playerCentury: '8',
                              playerFour: '155',
                              playerSix: '102',
                              playerCatches: '52',
                              playerStumping: '5',
                              playerWickets: '2',
                              playerBestWicket: '2',
                              playerLessRun: '6',
                              playerEconomy: '0',
                              playerFourWicket: '0',
                              playerFiveWicket: '0',
                            )));
              },
              child: Stack(
                children: [
                  Container(
                    height: 450,
                    width: double.infinity,
                    child: Image.asset(widget.playersProfileUrl,
                        fit: BoxFit.fitHeight),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 75,
                      color: Colors.blue.withOpacity(0.7),
                      child: Row(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            child: Image.asset('assets/images/bats.jpeg'),
                          ),
                          Container(
                            width: 2.0,
                            height: 50.0,
                            color: Colors.white,
                            margin: EdgeInsets.symmetric(horizontal: 10.0),
                          ),
                          Text(
                            'Orange Cap',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              child: Container(
                width: double.infinity,
                color: Colors.grey,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.position,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.playersName,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Image.asset(
                          widget.playersTeamLogoUrl,
                          height: 70,
                          width: 70,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: 150,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    widget.run,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Runs',
                                    style: TextStyle(fontSize: 17),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: 150,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    widget.matches,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Matches',
                                    style: TextStyle(fontSize: 17),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: 150,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    widget.average,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Average',
                                    style: TextStyle(fontSize: 17),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: 150,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    widget.strikeRate,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Strike Rate',
                                    style: TextStyle(fontSize: 17),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: 150,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    widget.playerHighScore,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Hs. Score',
                                    style: TextStyle(fontSize: 17),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: 150,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${widget.playersHalfCentury}s/${widget.playersHalfCentury}s',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '50s/100s',
                                    style: TextStyle(fontSize: 17),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        for (PlayerLists players in _foundPlayers)
                          PlayersItem(playerLists: players)
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
