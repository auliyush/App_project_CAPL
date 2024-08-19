import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: UpcomingPage(),
  ));
}

class UpcomingPage extends StatelessWidget {
  const UpcomingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg.jpg'),
                fit: BoxFit.cover,
                opacity: 0.6,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Center(
                    child: Text(
                      "List Of Upcoming Matches",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white60),
                    ),
                  ),
                  MatchCard(
                    team1: "Team1",
                    team2: "Team2",
                    place: "Patliputra, Patna",
                    stadium: "Patliputra Stadium",
                    date: "15th August",
                    time: "13:15",
                    anchors: "Coding Age",
                  ),
                  MatchCard(
                    team1: "Team1",
                    team2: "Team2",
                    place: "Patliputra, Patna",
                    stadium: "Patliputra Stadium",
                    date: "15th August",
                    time: "13:15",
                    anchors: "Coding Age",
                  ),
                  MatchCard(
                    team1: "Team1",
                    team2: "Team2",
                    place: "Patliputra, Patna",
                    stadium: "Patliputra Stadium",
                    date: "15th August",
                    time: "13:15",
                    anchors: "Coding Age",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MatchCard extends StatelessWidget {
  final String team1;
  final String team2;
  final String place;
  final String stadium;
  final String date;
  final String time;
  final String anchors;

  MatchCard({
    required this.team1,
    required this.team2,
    required this.place,
    required this.stadium,
    required this.date,
    required this.time,
    required this.anchors,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Team:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 10),
                Text(
                  "$team1 VS $team2",
                  style: TextStyle(fontSize: 17),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Place:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 10),
                Text(
                  place,
                  style: TextStyle(fontSize: 17),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Stadium:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 10),
                Text(
                  stadium,
                  style: TextStyle(fontSize: 17),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Date:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 10),
                Text(
                  date,
                  style: TextStyle(fontSize: 17),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Time:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 10),
                Text(
                  time,
                  style: TextStyle(fontSize: 17),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Anchors:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), // Changed here
                ),
                SizedBox(width: 10),
                Text(
                  anchors,
                  style: TextStyle(fontSize: 17),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
