import 'package:flutter/material.dart';
import 'ScoreBoard.dart';

class LivePage extends StatelessWidget {
  const LivePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
              'Live Match',
            style: TextStyle(
              color: Colors.white60,
              fontWeight: FontWeight.w500,
              fontSize: 27,
            ),
          ),
          backgroundColor: Colors.transparent,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          bottom: const TabBar(
            indicatorColor: Colors.orange,
            labelColor: Colors.orange,
            unselectedLabelColor: Colors.white,
            tabs: [
              Tab(
                child: Text(
                  'Details',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'ScoreBoard',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            DetailsPage(
              team1Name: 'WI',
              team2Name: 'MI',
              strikerName: "Virat Kohli",
              nonStrikerName: "Rohit Sharma",
              bowlerName: 'shubham Gill',
              bowlerSubTitle: 'spin',
              matchPlace: 'Kankarbagh patna Bihar',
              stadiumName: 'patliputra Stadium',
              recentOutPlayer: 'kapil dev',
              recentOutRun: 23,
              recentOutBall: 12,
              overs: 12,
              runs: 159,
              4,
            ),
            ScoreBoard(
              score: 250,
              overs: 50,
              balls: 0,
              playerName: 'Rohit Sharma',
              runs: 55,
              ballsFaced: 30,
              fours: 03,
              sixes: 05,
              strikeRate: 0.05,
            ),
          ],
        ),
      ),
    );
  }
}

class DetailsPage extends StatefulWidget {
  final String team1Name;
  final String team2Name;
  final String strikerName;
  final String nonStrikerName;
  final String bowlerName;
  final String bowlerSubTitle;
  final String matchPlace;
  final String stadiumName;
  final String recentOutPlayer;
  final int recentOutRun;
  final int recentOutBall;
  final int runs;
  final int overs;
  final int balls;

  const DetailsPage(
      this.balls,{
    required this.team1Name,
    required this.team2Name,
    required this.strikerName,
    required this.nonStrikerName,
    required this.bowlerName,
    required this.bowlerSubTitle,
    required this.matchPlace,
    required this.stadiumName,
    required this.recentOutPlayer,
    required this.recentOutRun,
    required this.recentOutBall,
    required this.overs,
    required this.runs,
    super.key,
  });
  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(height: 10),
            _matchInfoCard(
              widget.team1Name,
              widget.team2Name,
              widget.runs,
              widget.overs,
            ),
            const SizedBox(height: 20),
            _buildMatchPlayersCard(
              widget.strikerName,
              widget.nonStrikerName,
              widget.bowlerName,
              widget.balls,
              widget.overs,
            ),
            const SizedBox(height: 20),
            _buildMatchPlaceDetail(
              widget.matchPlace,
              widget.stadiumName,
              widget.recentOutPlayer,
              widget.recentOutBall,
              widget.recentOutRun,
            )
          ],
        ),
      ),
    );
  }

  Widget _matchInfoCard(String team1, String team2, int runs, int overs) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFEEEFF5),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage('assets/images/bg.jpg'),
                    radius: 25,
                  ),
                  SizedBox(width: 20),
                  Text(
                    team1,
                    style: const TextStyle(
                      fontSize: 26,
                      color: Color(0xFF3b3b6d),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Padding(
                padding:
                    EdgeInsets.only(left: 100),
                child: Text(
                  'vs',
                  style: TextStyle(fontSize: 26, color: Colors.black54),
                ),
              ),
              Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage('assets/images/bg.jpg'),
                    radius: 25,
                  ),
                  const SizedBox(width: 20),
                  Text(
                    team2,
                    style: const TextStyle(
                      fontSize: 26,
                      color: Color(0xFF3b3b6d),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 25),
            child: Column(
              children: [
                Text(
                  '${runs} / ${overs}',
                  style: const TextStyle(
                      color: Color(0xFF3b3b6d),
                      fontSize: 19,
                      fontWeight: FontWeight.w500),
                ),
                Text('Runs/Overs'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMatchPlayersCard(String strikerName,
      String nonStrikerName, String ballerName,int balls, int overs) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFEEEFF5),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    strikerName,
                    style: const TextStyle(
                        color: Color(0xFF3b3b6d),
                        fontSize: 21,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Text(
                      'Striker',
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Text(
                    nonStrikerName,
                    style: const TextStyle(
                        color: Color(0xFF3b3b6d),
                        fontSize: 21,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Text(
                      'Non-Striker',
                      style: TextStyle(
                      color: Colors.black54,
                  ),
                  )
                ],
              )
            ],
          ),
          const SizedBox(height: 20),
          Text(
            ballerName,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
                color: Color(0xFF3b3b6d),
                fontSize: 21
            ),
          ),
          const Text(
              'Baller',
            style: TextStyle(
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '${balls}/${overs}',
            style: const TextStyle(
              fontSize: 31
            ),
          ),
          const Text(
            'Balls - Over',
            style: TextStyle(
              fontSize: 15,
              color: Colors.black54,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMatchPlaceDetail(String place, String stadiumName,
      String recentOutPlayer, int recentPlayerRuns, int recentPlayerBalls) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFEEEFF5),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Flexible(
                  child: Text(
                      'Match Place',
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  ),
              ),
              Flexible(
                child: Container(
                  width: 200,
                  child: Text(
                    place,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF3b3b6d),
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Flexible(
                child: Text(
                  'Stadium',
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
              ),
              Flexible(
                child: Container(
                  width: 200,
                  child: Text(
                    stadiumName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF3b3b6d),
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          const Text(
            'Recent Out Player',
            style: TextStyle(
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    recentOutPlayer,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF3b3b6d),
                      fontSize: 18,
                    ),
                  ),
                  const Text(
                    'player Name',
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Text(
                      '${recentPlayerRuns}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF3b3b6d),
                      fontSize: 18,
                    ),
                  ),
                  const Text(
                      'Runs',
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Text(
                      '${recentPlayerBalls}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF3b3b6d),
                      fontSize: 18,
                    ),
                  ),
                  const Text(
                      'Balls',style: TextStyle(
                    color: Colors.black54,
                  ),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}