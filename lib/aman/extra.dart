import 'package:flutter/material.dart';
import 'package:merge_capl/aman/players_details.dart';

import 'about_player_details_page.dart';

class PlayersItem extends StatelessWidget{
  final PlayerLists playerLists;

  const PlayersItem({
    Key? key, required this.playerLists,
  }) : super(key : key);
  @override
  Widget build(BuildContext context) {

    return InkWell(
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              child: Center(child: Text('${playerLists.playerRank}',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),)),
              height: 140, // Specify a height for the container
              //color: Colors.red,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30, right: 5),
                    child: Container(
                      // color: Colors.red,
                      height: 110,
                      width: 90,
                      //color: Colors.black,
                      child: Image.asset(
                          '${playerLists.playerPhotoUrl}', fit: BoxFit.cover),

                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30, right: 5),
                    child: Container(
                      // color: Colors.blue,
                      height: 110,
                      width: 75,
                      //color: Colors.blue,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${playerLists.playerName}',
                            style: TextStyle(fontWeight: FontWeight.bold,
                                fontSize: 15),

                          ),
                          SizedBox(height: 10), // Add space between the two texts
                          Row(
                            children: [
                              Text('${playerLists.playerTeamName}'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )


                ],
              ),
              height: 140, // Specify a height for the container
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1),
              ),
              //color: Colors.black,
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              height: 140, // Specify a height for the container
              child: Row(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50, left: 10),
                      child: Column(
                        children: [
                          Text('${playerLists.playerRuns}',
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight
                                .bold),),
                          Text('Runs'),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Icon(Icons.arrow_forward_ios),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1),
              ),
              //color: Colors.red,
            ),
          ),
        ],
      ),
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => PlayerProfilePage(
          playerUrl: 'assets/images/rohit.jpeg',
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



        )
        ));
      },
    );
  }

}