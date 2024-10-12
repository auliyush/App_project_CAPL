
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SquadsScreen extends StatefulWidget {
  @override
  _SquadsScreenState createState() => _SquadsScreenState();
}

class _SquadsScreenState extends State<SquadsScreen> {
  final teamFirstPlayers = Team.teamFirstPlayers();
  final teamSecondPlayers = Team.teamSecondPlayers();

  bool _teamFirstExpandedPlayer = false;
  bool _teamSecondExpandedPlayer = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              Text(
                'India',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3b3b6d),
                ),
              ),
              ExpansionTile(
                backgroundColor: const Color(0xFF3b3b6d),
                iconColor: Colors.white,
                title: Text(
                  'IND Players',
                  style: TextStyle(
                    color: _teamFirstExpandedPlayer ? Colors.white : const Color(0xFF3b3b6d),
                  ),
                ),
                onExpansionChanged: (bool isExpanded) {
                  setState(() {
                    _teamFirstExpandedPlayer = isExpanded;
                  });
                },
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for(Team team in teamFirstPlayers)
                        Container(child: _rowBuilder(team),)
                    ],
                  ),
                ],
              ),
              Text(
                  'Sri Lanka',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3b3b6d),
                ),
              ),
              ExpansionTile(
                backgroundColor: const Color(0xFF3b3b6d),
                iconColor: Colors.white,
                title: Text(
                  'SL Players',
                  style: TextStyle(
                    color: _teamSecondExpandedPlayer ? Colors.white : const Color(0xFF3b3b6d),
                  ),
                ),
                onExpansionChanged: (bool isExpanded) {
                  setState(() {
                    _teamSecondExpandedPlayer = isExpanded;
                  });
                },
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for(Team team in teamFirstPlayers)
                        Container(child: _rowBuilder(team),)
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _rowBuilder(Team team){
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          surfaceTintColor: Colors.white,
          foregroundColor: Colors.grey,
        ),
        child:
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                    child: Text(
                      team.playerName,
                      style: TextStyle(
                        color: Colors.orange.shade900,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                ),
                Text(
                  '(Batter)',
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
        onPressed: (){

        },
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