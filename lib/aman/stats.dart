import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:merge_capl/aman/players_details.dart';
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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade900,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SeasonSelector()),
          );
        },
        child: Icon(Icons.list , color: Colors.white,weight: 900,),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 130,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/bg.jpg"),
                    ),
                  ),
                ),


                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.02, vertical: screenHeight * 0.02),
                      child:
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(Icons.emoji_events,color: Colors.white,size: 22,),
                          Text('Awards',style: TextStyle(color: Colors.white),),
                        ],
                      ),
                    ),

                  ],
                ),

                // Padding(
                //   padding: const EdgeInsets.only(left: 18, top: 80),
                //   child: Text(
                //     "Stats",
                //     style: TextStyle(
                //       fontSize: screenWidth * 0.06,
                //       color: Colors.white,
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                // ),

              ],
            ),
            SingleChildScrollView(
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
                            backgroundColor: Colors.blue,
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
                                    'assets/images/teamlogo.png',
                                    playersProfileUrl: 'assets/images/rohitsharma.webp',
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

                   SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PlayerProfilePage(
                                playerUrl: 'assets/images/rohitsharma.webp',
                                playerName: 'ROHIT SHARMA',
                                playerType: 'Batsman',
                                playerDebut: '2009',
                                playerDob: '05-09-1992',
                                playerMatches: '86',
                                playerAboutDetails:
                                "Captain Marvellous. Rohit Sharma has etched his name as the most successful captain in the IPL with five trophies, the most by anyone in the tournament. He has cracked the code and made MI the most consistent team.+"
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
                          height: 420,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              opacity: 0.8,
                              image: AssetImage('assets/images/img.png'), // replace with your background image asset
                              fit: BoxFit.cover,
                            ),
                            color: Colors.blue.withOpacity(0.5),
                          ),
                          child: Image.asset(widget.playersProfileUrl,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 75,
                            color: Colors.blue.withOpacity(0.5),// transparent color
                            child: Row(
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                  child: Image.asset('assets/images/bb.png'),
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
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/bg.jpg'), // Add your image path here
                            fit: BoxFit.cover,
                            opacity: 0.7,
                          ),
                          color: Colors.blue, // This color will show as a fallback if the image is not loaded
                        ),
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
                                    color: Colors.white, // Adjust text color if necessary
                                  ),
                                ),
                                Text(
                                  widget.playersName,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white, // Adjust text color if necessary
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
                                      height: 100,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        color: Colors.white.withOpacity(0.7), // Adjust opacity if necessary
                                        borderRadius: BorderRadius.circular(12.0), // Add borderRadius for rounded corners
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
                                      height: 100,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        color: Colors.white.withOpacity(0.7), // Adjust opacity if necessary
                                        borderRadius: BorderRadius.circular(12.0), // Add borderRadius for rounded corners
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
                                      height: 100,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        color: Colors.white.withOpacity(0.7), // Adjust opacity if necessary
                                        borderRadius: BorderRadius.circular(12.0), // Add borderRadius for rounded corners
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
                                      height: 100,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        color: Colors.white.withOpacity(0.7), // Adjust opacity if necessary
                                        borderRadius: BorderRadius.circular(12.0), // Add borderRadius for rounded corners
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
                                      height: 100,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        color: Colors.white.withOpacity(0.7), // Adjust opacity if necessary
                                        borderRadius: BorderRadius.circular(12.0), // Add borderRadius for rounded corners
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
                                      height: 100,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        color: Colors.white.withOpacity(0.7), // Adjust opacity if necessary
                                        borderRadius: BorderRadius.circular(12.0), // Add borderRadius for rounded corners
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
                  )

                ],
              ),
            ),
          ],
        ),
      )


    );
  }
}
