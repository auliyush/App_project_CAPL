import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:merge_capl/integration/api/tournament_list_api.dart';
import 'package:merge_capl/tournament_screens/team_detail_screen.dart';

class TournamentDetailScreen extends StatelessWidget {
  final TournamentListApi tournament;

  TournamentDetailScreen({required this.tournament});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    List<dynamic> teamList = tournament.teamList;

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
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Text(
                        "Tournament ~ ${tournament.tournamentName}",
                        style: TextStyle(
                          fontSize: screenWidth <= 750 ? screenWidth * 0.06 : 44,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailRow('Tournament Name:', tournament.tournamentName),
                  _buildDetailRow('Season Year:', tournament.seasonYear),
                  _buildDetailRow('Highest Score Of Batter:', tournament.highestScoreBatterId ?? 'N/A'),
                  _buildDetailRow('Highest Score Of Bowler:', tournament.highestScoreBowlerId ?? 'N/A'),
                  _buildDetailRow('Winner Team:', tournament.winnerTeam ?? 'N/A'),
                  _buildDetailRow('Start Date:', DateFormat('yyyy-MM-dd').format(tournament.tournamentStartDate)),
                  _buildDetailRow('End Date:', DateFormat('yyyy-MM-dd').format(tournament.tournamentEndDate)),
                  _buildDetailRow('Stadium Name:', tournament.stadiumName),
                  _buildDetailRow('Stadium Address:', tournament.stadiumAddress),
                  SizedBox(height: 18), // Additional spacing
                  Expanded(
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
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: ListView.builder(
                          itemCount: teamList.length,
                          itemBuilder: (context, index) {
                            var team = teamList[index];
                            return Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: ListTile(
                                leading: CircleAvatar(
                                  radius: 40,
                                  backgroundImage: team['teamProfilePhotoUrl'] != null && team['teamProfilePhotoUrl'].isNotEmpty
                                      ? NetworkImage(team['teamProfilePhotoUrl'])
                                      : AssetImage('assets/images/default_avatar.png') as ImageProvider,
                                ),
                                title: Text(
                                  '${team['teamName']} (${team['teamNickName']})',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text('Captain: ${team['teamCaptainId']}'),
                                trailing: IconButton(
                                  icon: Icon(Icons.arrow_forward_ios),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => TeamDetailScreen(team: team, tournament: tournament),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
