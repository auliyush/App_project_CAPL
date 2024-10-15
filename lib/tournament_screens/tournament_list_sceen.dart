import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:merge_capl/integration/api/tournament_list_api.dart';
import 'package:merge_capl/tournament_screens/tournament_detail_screen.dart';

class TournamentListScreen extends StatefulWidget {
  @override
  State<TournamentListScreen> createState() => _TournamentListScreenState();
}

class _TournamentListScreenState extends State<TournamentListScreen> {
  late Future<List<TournamentListApi>> _futureTournaments;

  @override
  void initState() {
    super.initState();
    _futureTournaments = TournamentService().fetchTournaments();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 130,
            child: Stack(
              children: [
                Container(
                  height: 130,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/bg.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18, top: 60),
                  child: Text(
                    "Tournament",
                    style: TextStyle(
                      fontSize: screenWidth <= 750 ? screenWidth * 0.06 : 44,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: FutureBuilder<List<TournamentListApi>>(
                    future: _futureTournaments,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<TournamentListApi>? tournaments = snapshot.data;
                        return ListView.builder(
                          itemCount: tournaments?.length,
                          itemBuilder: (context, index) {
                            TournamentListApi tournament = tournaments![index];
                            return Card(
                              color: Colors.white70,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                              child: ListTile(
                                contentPadding: EdgeInsets.all(15),
                                leading: CircleAvatar(
                                  radius: 40,
                                  backgroundImage: AssetImage("assets/images/bg.jpg"),
                                  backgroundColor: Colors.blueGrey[100],
                                ),
                                title: Text(
                                  tournament.tournamentName,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueGrey[800],
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Divider(color: Colors.grey[300]),
                                    SizedBox(height: 8),
                                    Text(
                                      "Season Year: ${tournament.seasonYear}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    Text(
                                      "Start Date: ${DateFormat('yyyy-MM-dd').format(tournament.tournamentStartDate)}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                                trailing: IconButton(
                                  icon: Icon(Icons.arrow_forward_ios),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => TournamentDetailScreen(tournament: tournament),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        );

                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
