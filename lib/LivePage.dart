import 'package:flutter/material.dart';
import 'ScoreBoard.dart';

class LivePage extends StatelessWidget {
  const LivePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Live Match',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Details'),
              Tab(text: 'ScoreBoard'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            DetailsPage(
              "Team1",
              "Team2",
              "Rohit Sharma",
              "Virat Kohli",
              "Cahal",
              "Spinner",
              "Patna , Bihar",
              "Patliputra Stadium",
              "",
              "",
              "",
              score: '250/50',
            ),
            ScoreBoard(
              score: '250',
              overs: '50',
              balls: '0',
              playerName: 'Rohit Sharma',
              runs: '55',
              ballsFaced: '30',
              fours: '03',
              sixes: '05',
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
  final String batter1Name;
  final String batter2Name;
  final String bowlerName;
  final String bowlerSubTitle;
  final String matchPlace;
  final String stadiumName;
  final String recentOutPlayer;
  final String recentOutRun;
  final String recentOutBall;
  final String score;

  const DetailsPage(
      this.team1Name,
      this.team2Name,
      this.batter1Name,
      this.batter2Name,
      this.bowlerName,
      this.bowlerSubTitle,
      this.matchPlace,
      this.stadiumName,
      this.recentOutPlayer,
      this.recentOutRun,
      this.recentOutBall, {
        required this.score,
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
            SizedBox(height: 10),
            _buildContainer(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildInfoBox(widget.team1Name, "VS", widget.team2Name),
                  _buildInfoBox(widget.score, "Over Balls"),
                ],
              ),
            ),
            SizedBox(height: 20),
            _buildContainer(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildBatterBox(widget.batter1Name),
                      _buildBatterBox(widget.batter2Name),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildBowlerBox("${widget.bowlerName} (${widget.bowlerSubTitle})"),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            _buildContainer(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildBatterBox("Place"),
                      _buildBatterBox(widget.matchPlace),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildBatterBox("Stadium"),
                      _buildBatterBox(widget.stadiumName),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildBatterBoxUnderline("Recent Out Players"),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildBatterBox("Players Name"),
                      _buildBatterBox("Runs"),
                      _buildBatterBox("Balls"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildBatterBox(widget.recentOutPlayer),
                      _buildBatterBox(widget.recentOutRun),
                      _buildBatterBox(widget.recentOutBall),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContainer({required Widget child}) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.deepPurple[50],
        border: Border.all(width: 2, color: Colors.black),
        borderRadius: BorderRadius.circular(15),
      ),
      child: child,
    );
  }

  Widget _buildInfoBox(String text1, String text2, [String text3 = ""]) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(text1, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(text2, style: TextStyle(fontSize: 16)),
          if (text3.isNotEmpty)
            Text(text3, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildBatterBox(String batter) {
    return Column(
      children: [
        Text(
          batter,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildBatterBoxUnderline(String batter) {
    return Column(
      children: [
        Text(
          batter,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
        ),
      ],
    );
  }

  Widget _buildBowlerBox(String bowler) {
    return Column(
      children: [
        Text(
          bowler,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.black),
            borderRadius: BorderRadius.circular(5),
          ),
          child: const Center(
            child: Text(
              "Balls & Overs",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
