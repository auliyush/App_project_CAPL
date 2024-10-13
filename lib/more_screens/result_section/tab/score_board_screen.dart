
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScorecardScreen extends StatefulWidget {
  @override
  _ScorecardScreenState createState() => _ScorecardScreenState();
}

class _ScorecardScreenState extends State<ScorecardScreen> {
  final teamFirstPlayers = Team.teamFirstPlayers();
  final teamSecondPlayers = Team.teamSecondPlayers();

  bool _teamFirstExpanded = false;
  bool _teamSecondExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('SL v IND'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ExpansionTile(
              backgroundColor: const Color(0xFF3b3b6d),
              iconColor: Colors.white,
              title: Text(
                'India',
                style: TextStyle(
                  color: _teamSecondExpanded ? Colors.white : const Color(0xFF3b3b6d),
                ),
              ),
              onExpansionChanged: (bool isExpanded) {
                setState(() {
                  _teamSecondExpanded = isExpanded;
                });
              },
              children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: _titleBuilder(),
                      ),
                      for(Team team in teamFirstPlayers)
                        Container(child: _rowBuilder(team),)
                    ],
                  ),
              ],
            ),
            ExpansionTile(
              backgroundColor: const Color(0xFF3b3b6d),
              iconColor: Colors.white,
              title: Text(
                  'Sri lanka',
                style: TextStyle(
                  color: _teamFirstExpanded ? Colors.white : const Color(0xFF3b3b6d),
                ),
              ),
              onExpansionChanged: (bool isExpanded) {
                setState(() {
                  _teamFirstExpanded = isExpanded;
                });
              },
              children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: _titleBuilder(),
                      ),
                      for(Team team in teamSecondPlayers)
                        Container(child: _rowBuilder(team),)
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Widget _titleBuilder(){
    return SizedBox(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white70,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          surfaceTintColor: Colors.white,
          foregroundColor: Colors.grey,
        ),
        child: const Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 110,
                  child: Text(
                    'playerName',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54
                    ),
                  ),
                ),
                Text(
                    'R',
                  style: TextStyle(
                    color: Colors.black54
                  ),
                ),
                Text(
                    'B',
                  style: TextStyle(
                      color: Colors.black54
                  ),
                ),
                Text(
                    '4s',
                  style: TextStyle(
                      color: Colors.black54
                  ),
                ),
                Text(
                    '6s',
                  style: TextStyle(
                      color: Colors.black54
                  ),
                ),
                Text(
                    'SR',
                  style: TextStyle(
                      color: Colors.black54
                  ),
                ),
              ],
            ),
          ],
        ),
        onPressed: (){

        },
      ),
    );
  }

  Widget _rowBuilder(Team team){
    return SizedBox(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white70,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          surfaceTintColor: Colors.white,
          foregroundColor: Colors.grey,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: SizedBox(
                    width: 100,
                    child: Text(
                      team.playerName,
                      style: TextStyle(
                        color: Colors.orange.shade900,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 20,
                  child: Text(
                    '${team.runs}',
                      style: TextStyle(
                      color: Colors.black87
                  ),
                  ),
                ),
                Text(
                  '${team.balls}',
                  style: TextStyle(
                      color: Colors.black87
                  ),
                ),
                Text(
                  '${team.fours}',
                  style: TextStyle(
                      color: Colors.black87
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    '${team.sixes}',
                    style: TextStyle(
                        color: Colors.black87
                    ),
                  ),
                ),
                Text(
                  '${team.strikeRate}',
                  style: TextStyle(
                      color: Colors.black87
                  ),
                ),
              ],
            ),
          ],
        ),
        onPressed: (){

        },
      ),
    );
  }
}

class Team {
  final String playerName;
  final int runs;
  final int balls;
  final int fours;
  final int sixes;
  final double strikeRate;
  final String wicketDescription;

  Team({
    required this.playerName,
    required this.runs,
    required this.balls,
    required this.fours,
    required this.sixes,
    required this.strikeRate,
    required this.wicketDescription,
  });

  static List<Team> teamFirstPlayers() {
    return [
      Team(
        playerName: 'Rohit (c)',
        runs: 58,
        balls: 47,
        fours: 7,
        sixes: 3,
        strikeRate: 123.4,
        wicketDescription: 'lbw b Dunith Wellalage',
      ),
      Team(
        playerName: 'Shubman Gill',
        runs: 16,
        balls: 35,
        fours: 2,
        sixes: 0,
        strikeRate: 45.71,
        wicketDescription: 'c Kusal Mendis b Dunith Wellalage',
      ),
      Team(
        playerName: 'Rohit (c)',
        runs: 58,
        balls: 47,
        fours: 7,
        sixes: 3,
        strikeRate: 123.4,
        wicketDescription: 'lbw b Dunith Wellalage',
      ),
      Team(
        playerName: 'Shubman Gill',
        runs: 16,
        balls: 35,
        fours: 2,
        sixes: 0,
        strikeRate: 45.71,
        wicketDescription: 'c Kusal Mendis b Dunith Wellalage',
      ),
      Team(
        playerName: 'Rohit (c)',
        runs: 58,
        balls: 47,
        fours: 7,
        sixes: 3,
        strikeRate: 123.4,
        wicketDescription: 'lbw b Dunith Wellalage',
      ),
      Team(
        playerName: 'Shubman Gill',
        runs: 16,
        balls: 35,
        fours: 2,
        sixes: 0,
        strikeRate: 45.71,
        wicketDescription: 'c Kusal Mendis b Dunith Wellalage',
      ),
      Team(
        playerName: 'Rohit (c)',
        runs: 58,
        balls: 47,
        fours: 7,
        sixes: 3,
        strikeRate: 123.4,
        wicketDescription: 'lbw b Dunith Wellalage',
      ),
      Team(
        playerName: 'Shubman Gill',
        runs: 16,
        balls: 35,
        fours: 2,
        sixes: 0,
        strikeRate: 45.71,
        wicketDescription: 'c Kusal Mendis b Dunith Wellalage',
      ),
      Team(
        playerName: 'Rohit (c)',
        runs: 58,
        balls: 47,
        fours: 7,
        sixes: 3,
        strikeRate: 123.4,
        wicketDescription: 'lbw b Dunith Wellalage',
      ),
      Team(
        playerName: 'Shubman Gill',
        runs: 16,
        balls: 35,
        fours: 2,
        sixes: 0,
        strikeRate: 45.71,
        wicketDescription: 'c Kusal Mendis b Dunith Wellalage',
      ),
      Team(
        playerName: 'Rohit (c)',
        runs: 58,
        balls: 47,
        fours: 7,
        sixes: 3,
        strikeRate: 123.4,
        wicketDescription: 'lbw b Dunith Wellalage',
      ),
      Team(
        playerName: 'Shubman Gill',
        runs: 16,
        balls: 35,
        fours: 2,
        sixes: 0,
        strikeRate: 45.71,
        wicketDescription: 'c Kusal Mendis b Dunith Wellalage',
      ),
      Team(
        playerName: 'Rohit (c)',
        runs: 58,
        balls: 47,
        fours: 7,
        sixes: 3,
        strikeRate: 123.4,
        wicketDescription: 'lbw b Dunith Wellalage',
      ),
      Team(
        playerName: 'Shubman Gill',
        runs: 16,
        balls: 35,
        fours: 2,
        sixes: 0,
        strikeRate: 45.71,
        wicketDescription: 'c Kusal Mendis b Dunith Wellalage',
      ),
    ];
  }
  static List<Team> teamSecondPlayers() {
    return [
      Team(
        playerName: 'guljit (c)',
        runs: 58,
        balls: 47,
        fours: 7,
        sixes: 3,
        strikeRate: 123.4,
        wicketDescription: 'lbw b Dunith Wellalage',
      ),
      Team(
        playerName: 'raghubeer Gill',
        runs: 16,
        balls: 35,
        fours: 2,
        sixes: 0,
        strikeRate: 45.71,
        wicketDescription: 'c Kusal Mendis b Dunith Wellalage',
      ),
      Team(
        playerName: 'guljit (c)',
        runs: 58,
        balls: 47,
        fours: 7,
        sixes: 3,
        strikeRate: 123.4,
        wicketDescription: 'lbw b Dunith Wellalage',
      ),
      Team(
        playerName: 'raghubeer Gill',
        runs: 16,
        balls: 35,
        fours: 2,
        sixes: 0,
        strikeRate: 45.71,
        wicketDescription: 'c Kusal Mendis b Dunith Wellalage',
      ),Team(
        playerName: 'guljit (c)',
        runs: 58,
        balls: 47,
        fours: 7,
        sixes: 3,
        strikeRate: 123.4,
        wicketDescription: 'lbw b Dunith Wellalage',
      ),
      Team(
        playerName: 'raghubeer Gill',
        runs: 16,
        balls: 35,
        fours: 2,
        sixes: 0,
        strikeRate: 45.71,
        wicketDescription: 'c Kusal Mendis b Dunith Wellalage',
      ),
      Team(
        playerName: 'guljit (c)',
        runs: 58,
        balls: 47,
        fours: 7,
        sixes: 3,
        strikeRate: 123.4,
        wicketDescription: 'lbw b Dunith Wellalage',
      ),
      Team(
        playerName: 'raghubeer Gill',
        runs: 16,
        balls: 35,
        fours: 2,
        sixes: 0,
        strikeRate: 45.71,
        wicketDescription: 'c Kusal Mendis b Dunith Wellalage',
      ),
      Team(
        playerName: 'guljit (c)',
        runs: 58,
        balls: 47,
        fours: 7,
        sixes: 3,
        strikeRate: 123.4,
        wicketDescription: 'lbw b Dunith Wellalage',
      ),
      Team(
        playerName: 'raghubeer Gill',
        runs: 16,
        balls: 35,
        fours: 2,
        sixes: 0,
        strikeRate: 45.71,
        wicketDescription: 'c Kusal Mendis b Dunith Wellalage',
      ),
      Team(
        playerName: 'guljit (c)',
        runs: 58,
        balls: 47,
        fours: 7,
        sixes: 3,
        strikeRate: 123.4,
        wicketDescription: 'lbw b Dunith Wellalage',
      ),
      Team(
        playerName: 'raghubeer Gill',
        runs: 16,
        balls: 35,
        fours: 2,
        sixes: 0,
        strikeRate: 45.71,
        wicketDescription: 'c Kusal Mendis b Dunith Wellalage',
      ),
    ];
  }
}