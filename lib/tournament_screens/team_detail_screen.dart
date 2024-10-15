import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:merge_capl/player_screens/player_update_account_screen.dart';
import '../integration/api/tournament_list_api.dart';

class TeamDetailScreen extends StatefulWidget {
  final Map<String, dynamic> team;
  final TournamentListApi tournament;

  TeamDetailScreen({required this.team, required this.tournament});

  @override
  _TeamDetailScreenState createState() => _TeamDetailScreenState();
}

class _TeamDetailScreenState extends State<TeamDetailScreen> {
  String? teamCaptainName;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAdminName();
  }

  Future<void> fetchAdminName() async {
    try {
      AdminNameByID obj = AdminNameByID(widget.team['teamCreatorId']);
      String? name = await obj.fetchAdminName();
      setState(() {
        teamCaptainName = name;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        teamCaptainName = 'Error fetching name';
        isLoading = false;
      });
      print('Error fetching admin name: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    List<dynamic> playerList = widget.team['playerList'] ?? [];

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 200, // Increased height for more impact
            child: Stack(
              children: [
                Container(
                  height: 160,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/bg.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12, top: 30),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios, color: Colors.white),

                        onPressed: () {
                          Navigator.pop(context);

                        },
                      ),
                      Text(
                        "Team ~ ${widget.team['teamName']}",
                        style: TextStyle(
                          fontSize: screenWidth <= 750 ? screenWidth * 0.06 : 34,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 100,
                  left: 45,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundImage: widget.team['teamProfilePhotoUrl'] != null &&
                        widget.team['teamProfilePhotoUrl'].isNotEmpty
                        ? NetworkImage(widget.team['teamProfilePhotoUrl'])
                        : AssetImage('assets/images/default_avatar.png')
                    as ImageProvider,
                  ),
                ),
                Positioned(
                  top: 100,
                  left: 16 + 90,
                  child: Text(
                    "(${widget.team['teamNickName']})",
                    style: TextStyle(
                      fontSize: screenWidth <= 750 ? screenWidth * 0.05 : 24,
                      color: Colors.white70,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 30 , right: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailRow('Team Name:', widget.team['teamName']),
                  _buildDetailRow('Captain:', isLoading ? 'Loading...' : (teamCaptainName ?? 'N/A')),
                  SizedBox(height: 18),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(35),
                          topRight: Radius.circular(35),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10.0,
                            spreadRadius: 0.5,
                            offset: Offset(0.0, 0.5),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: ListView.builder(
                          itemCount: playerList.length,
                          itemBuilder: (context, index) {
                            var player = playerList[index];
                            return Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: ListTile(
                                title: Text(
                                  '${player['playerName']}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                subtitle: Text(
                                  'Role: ${player['playerRole']}',
                                  style: TextStyle(fontSize: 16),
                                ),
                                trailing: IconButton(
                                  icon: Icon(Icons.arrow_forward_ios),
                                  onPressed: () {
                                    /// for view player profile
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) => PlayerUpdateAccountScreen(playerPhotoUrl: playerPhotoUrl, playerName: playerName, playerNickName: playerNickName, playerMobNumber: playerMobNumber, playerEmail: playerEmail, playerAddress: playerAddress, playerType: playerType, playerSubType: playerSubType),
                                    //   ),
                                    // );
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
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
