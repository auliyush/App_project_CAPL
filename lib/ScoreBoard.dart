import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScoreBoard extends StatelessWidget {
  final int score;
  final int overs;
  final int balls;
  final String playerName;
  final int runs;
  final int ballsFaced;
  final int fours;
  final int sixes;
  final double strikeRate;

  const ScoreBoard({
    required this.score,
    required this.overs,
    required this.balls,
    required this.playerName,
    required this.runs,
    required this.ballsFaced,
    required this.fours,
    required this.sixes,
    required this.strikeRate,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Opacity(
            opacity: 0.3,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/bg.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: Container(
              height: 500,
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildScoreInfo('${score}', 'Total Score'),
                        _buildDivider(),
                        _buildScoreInfo('${overs}', 'Overs'),
                        _buildDivider(),
                        _buildScoreInfo('$balls', 'Balls'),
                      ],
                    ),
                  ),
                  Container(
                    height: 300,
                    width: 400,
                    child: Column(
                      children: [
                        _buildTableHeader(),
                        const SizedBox(height: 10),
                        _buildPlayerStats(
                          playerName,
                          '${runs}',
                          '${ballsFaced}',
                          '$fours',
                          '$sixes',
                        ),
                        _buildPlayerStats(
                          playerName,
                          '${runs}',
                          '${ballsFaced}',
                          '$fours',
                          '$sixes',
                        ),
                      ],
                    ),
                  ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreInfo(String value, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      width: 1,
      height: 50,
      color: Colors.black,
    );
  }

  Widget _buildTableHeader() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          height: 25,
          width: 150,
          child: Text(
            "Player Name",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Text(
          "Runs",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          "Balls",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          "4's",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          "6's",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _buildPlayerStats(
      String playerName,
      String runs,
      String ballsFaced,
      String fours,
      String sixes,
      ) {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Color(0xFFEEEFF5),
        borderRadius: BorderRadius.circular(15),
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: 25,
            width: 150,
            child: Text(
              playerName,
              style: const TextStyle(fontSize: 18),
            ),
          ),
          Text(
            runs,
            style: const TextStyle(fontSize: 18),
          ),
          Text(
            ballsFaced,
            style: const TextStyle(fontSize: 18),
          ),
          Text(
            fours,
            style: const TextStyle(fontSize: 18),
          ),
          Text(
            sixes,
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}