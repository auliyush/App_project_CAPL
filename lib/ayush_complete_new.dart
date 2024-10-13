// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: CompletedPage(),
//     );
//   }
//
// }
//
// class CompletedPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView(
//         padding: EdgeInsets.all(16.0),
//         children: [
//           // Title section
//           Container(
//             padding: EdgeInsets.symmetric(vertical: 16.0),
//             child: Center(
//               child: Text(
//                 'List of Completed Matches',
//                 style: TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//           // Match cards section
//           MatchCard(
//             team1: 'Team1',
//             team2: 'Team2',
//             team1Runs: '250',
//             team2Runs: '238',
//             team1Overs: '50',
//             team2Overs: '50',
//             team1Wickets: '8',
//             team2Wickets: '10',
//             result: 'Team1 Won By 12 runs',
//             manOfTheMatch: 'Player1',
//           ),
//           MatchCard(
//             team1: 'Team1',
//             team2: 'Team2',
//             team1Runs: '250',
//             team2Runs: '238',
//             team1Overs: '50',
//             team2Overs: '50',
//             team1Wickets: '8',
//             team2Wickets: '10',
//             result: 'Team1 Won By 12 runs',
//             manOfTheMatch: 'Player1',
//           ),
//           // Add more MatchCard widgets here
//         ],
//       ),
//     );
//   }
// }
//
// class MatchCard extends StatelessWidget {
//   final String team1;
//   final String team2;
//   final String team1Runs;
//   final String team2Runs;
//   final String team1Overs;
//   final String team2Overs;
//   final String team1Wickets;
//   final String team2Wickets;
//   final String result;
//   final String manOfTheMatch;
//
//   MatchCard({
//     required this.team1,
//     required this.team2,
//     required this.team1Runs,
//     required this.team2Runs,
//     required this.team1Overs,
//     required this.team2Overs,
//     required this.team1Wickets,
//     required this.team2Wickets,
//     required this.result,
//     required this.manOfTheMatch,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//
//     final isNarrowScreen = screenWidth >= 340 && screenWidth <= 355;
//
//     return Card(
//       margin: EdgeInsets.symmetric(vertical: 10.0),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Divider(),
//             Row(
//               mainAxisAlignment: isNarrowScreen ? MainAxisAlignment.start : MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: TeamScore(
//                     teamName: team1,
//                     runs: team1Runs,
//                     overs: team1Overs,
//                     wickets: team1Wickets,
//                     isNarrowScreen: isNarrowScreen,
//                   ),
//                 ),
//                 SizedBox(width: isNarrowScreen ? 0 : 16),
//                 Expanded(
//                   child: TeamScore(
//                     teamName: team2,
//                     runs: team2Runs,
//                     overs: team2Overs,
//                     wickets: team2Wickets,
//                     isNarrowScreen: isNarrowScreen,
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 10),
//
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Text(result),
//               ],
//             ),
//
//             SizedBox(height: 10),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 const CircleAvatar(
//                   child: Icon(Icons.person),
//                 ),
//                 // const SizedBox(width: 10),
//                 Text('Man Of The Match: $manOfTheMatch'),
//                 // const Spacer(),
//                 const Icon(Icons.emoji_events),
//               ],
//             ),
//
//             Divider(),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class TeamScore extends StatelessWidget {
//   final String teamName;
//   final String runs;
//   final String overs;
//   final String wickets;
//   final bool isNarrowScreen;
//
//   TeamScore({
//     required this.teamName,
//     required this.runs,
//     required this.overs,
//     required this.wickets,
//     required this.isNarrowScreen,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(teamName, style: TextStyle(fontWeight: FontWeight.bold)),
//         if (isNarrowScreen) ...[
//           Text('Runs: $runs'),
//           Text('Overs: $overs'),
//           Text('Wickets: $wickets'),
//         ] else ...[
//           Text('Runs (Overs): $runs ($overs)'),
//           Text('Wickets: $wickets'),
//         ],
//       ],
//     );
//   }
// }