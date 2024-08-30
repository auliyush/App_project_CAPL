import 'package:flutter/material.dart';
import 'package:merge_capl/aman/player/players_details.dart';
import 'player/about_player_details_page.dart';

class PlayersItem extends StatelessWidget {
  final PlayerLists playerLists;

  const PlayersItem({
    Key? key,
    required this.playerLists,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    // Adjust dimensions based on screen size and orientation
    final double imageWidth = screenSize.width * 0.25;
    final double textWidth = screenSize.width * 0.35;
    final double padding = 8.0; // Fixed padding for better consistency
    final double fontSize = isPortrait ? 16.0 : 18.0;

    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
      elevation: 5.0,
      color: Colors.white.withOpacity(0.7),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PlayerProfilePage(
                playerUrl: 'assets/images/rohitsharma.webp',
                playerName: 'Rohit Sharma',
                playerType: '(Batsman)',
                playerDebut: '2009',
                playerDob: '20-02-1990',
                playerMatches: '40',
                playerAboutDetails: "Captain Marvellous. Rohit Sharma has etched his name as the most successful captain in the IPL with five trophies, the most by anyone in the tournament. He has cracked the code and made MI the most consistent team.+"
                    "A prolific run-getter, the Hitman is one of the most naturally gifted batsmen in the world and has been enjoying a tremendous run with the bat. When it comes to the shorter format, there are few who can match his striking abilities.+"
                    "Rohit proved why he is regarded as a special talent when he became the first batsman to strike two double centuries in the ODIs and he now has three. He was one of the most consistent Deccan Chargers batsmen in the first three seasons of the IPL and was instrumental in his former franchise winning the crown in 2009+"
                    "However, since 2011, Rohit has been an integral part of the Mumbai Indians guiding their batting line-up. He took over the team's captaincy a couple of games into the 2013 season and led MI to their maiden IPL title. In the same year, MI also completed a grand double when they clinched the Champions League T20 title. His captaincy was put to test in the 2015 season after the team won just one of their first six games and were struggling to stay afloat. Mumbai Indians then staged a remarkable turnaround and lifted the Trophy for the second time with a convincing win in the final. Rohit, who made a half-century, was named the Player of the Match.+"
                    "The legacy of Hitman expanded further on, after powering Mumbai Indians to title victories in the 2017 and 2019 seasons, both being last ball thrillers. Rohit led the Mumbai Indians to a successful campaign in the 2020 season, which was their second consecutive title. MI did not qualify for playoffs in the 14th season and will be raring to go this time.+"
                    "He now returns as Team India's full-time captain in all three formats of the game.",
                playerRuns: '3500',
                playerHighestScore: '109',
                playerAverage: '42.25',
                playerStrikeRate: '140.32',
                playerHalfCentury: '45',
                playerCentury: '6',
                playerFour: '400',
                playerSix: '205',
                playerCatches: '60',
                playerStumping: '0',
                playerWickets: '0',
                playerBestWicket: '0',
                playerLessRun: '0',
                playerEconomy: '0',
                playerFourWicket: '0',
                playerFiveWicket: '0',
              ),
            ),
          );
        },
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  '${playerLists.playerRank}',
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                height: 140,
                decoration: BoxDecoration(
                  border: Border(right: BorderSide(color: Colors.grey.shade300, width: 1)),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(12), bottomLeft: Radius.circular(12)),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                padding: EdgeInsets.all(padding),
                child: Row(
                  children: [
                    Container(
                      height: 110,
                      width: imageWidth,
                      child: Image.asset(
                        '${playerLists.playerPhotoUrl}',
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    SizedBox(width: padding),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${playerLists.playerName}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: fontSize,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            '${playerLists.playerTeamName}',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: fontSize * 0.9,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                height: 140,
                decoration: BoxDecoration(
                  border: Border(right: BorderSide(color: Colors.grey.shade300, width: 1)),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                height: 140,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${playerLists.playerRuns}',
                          style: TextStyle(
                            fontSize: fontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Runs',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: fontSize * 0.9,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: padding),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.blue,
                      size: fontSize,
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(12), bottomRight: Radius.circular(12)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
