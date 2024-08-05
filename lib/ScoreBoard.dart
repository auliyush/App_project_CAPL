import 'package:flutter/material.dart';

class ScoreBoard extends StatelessWidget {
  final String score;
  final String overs;
  final String balls;
  final String playerName;
  final String runs;
  final String ballsFaced;
  final String fours;
  final String sixes;

  const ScoreBoard({
    required this.score,
    required this.overs,
    required this.balls,
    required this.playerName,
    required this.runs,
    required this.ballsFaced,
    required this.fours,
    required this.sixes,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ScoreBoard'),
      ),
      body: Center(
        child: Container(
          height: 500,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildScoreInfo(score, 'Total Score'),
                    _buildDivider(),
                    _buildScoreInfo(overs, 'Overs'),
                    _buildDivider(),
                    _buildScoreInfo(balls, 'Balls'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 300,
                    width: 350,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        _buildTableHeader(),
                        const SizedBox(height: 10),
                        _buildPlayerStats(
                          playerName,
                          runs,
                          ballsFaced,
                          fours,
                          sixes,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
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
    return Row(
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
    );
  }
}
