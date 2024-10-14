import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:merge_capl/integration/api/tournament_api_service.dart';

import '../../../integration/api/player_list.dart';
import '../../../integration/api/team_list.dart';
import '../../../integration/response_classes/team_data.dart';

class Team {
  final String teamId;
  final String teamName;
  final String teamNickname;
  final String teamPhoto;
  final bool inTournament;

  Team({
    required this.teamId,
    required this.teamName,
    required this.teamPhoto,
    required this.teamNickname,
    required this.inTournament,
});

  static List<Team> teams = [];

  static void addTeamFromResponse(List<TeamData> teamList) {
    teams.clear();
    for (var team in teamList) {
      teams.add(Team(
          teamId: team.teamId,
          teamName: team.teamName,
          teamPhoto: team.teamProfileUrl,
          teamNickname: team.teamNickName,
          inTournament: team.inTournament,
      ));
    }
  }
}


class AddTeamsTournament extends StatefulWidget {

  const AddTeamsTournament({super.key});

  @override
  State<AddTeamsTournament> createState() => _AddTeamsTournamentState();
}

class _AddTeamsTournamentState extends State<AddTeamsTournament> {

  Future<Team?>? teamResponse;
  Map<int, bool> selectedTeams = {};
  List<String> selectedTeamIdList = [];

  TournamentApiService api = TournamentApiService();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: FutureBuilder<Team?>(
        future: teamResponse,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }  return Column(
            children: [
              _buildHeader(screenWidth, screenHeight),
              _buildTeamList(),
              Padding(
                padding: const EdgeInsets.only(bottom: 25),
                child: _buildApplyButton(),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHeader(double screenWidth, double screenHeight) {
    return SizedBox(
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
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.02, vertical: screenHeight * 0.02),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18, top: 60),
            child: Text(
              "Add-In-Team",
              style: TextStyle(
                fontSize: screenWidth <= 750 ? screenWidth * 0.06 : 44,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamList() {
    return Expanded(
      child: ListView.builder(
        itemCount: Team.teams.length,
        itemBuilder: (context, index) {
          return _buildTeamTile(index, Team.teams[index].inTournament);
        },
      ),
    );
  }

  Widget _buildTeamTile(int index, bool inTeamStatus) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage('${Team.teams[index].teamPhoto}'),
        ),
        title: Text(
          Team.teams[index].teamName,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Row(
          children: [
            Text(
              '${Team.teams[index].teamNickname}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        trailing: _buildSelectButton(index, inTeamStatus),
        contentPadding: EdgeInsets.all(10),
      ),
    );
  }

  Widget _buildSelectButton(int index, bool inTeamStatus) {
    bool isSelected = selectedTeams[index] ?? false;
    if(!inTeamStatus){
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: inTeamStatus
              ? Colors.indigo.shade900
              : (isSelected ? Colors.indigo.shade900 : Colors.grey),
          elevation: 0,
          padding: EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: inTeamStatus
            ? null // If the player is already in the team, the button is disabled
            : () {
          // Toggle selection when the player is not in the team
          setState(() {
            selectedTeams[index] = !isSelected;
          });
        },
        child: Text(inTeamStatus || isSelected ? 'Selected' : 'Select'),
      );
    }else{
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.indigo.shade900,
          elevation: 0,
          padding: EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed:(){},
        child: Text('Selected'),
      );
    }
  }

  Widget _buildApplyButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: Center(
        child: Transform(
          transform: Matrix4.skewX(-0.2),
          child: ElevatedButton(
            child: Text(
              'Apply',
              style: TextStyle(
                fontFamily: "Netflix",
                fontWeight: FontWeight.w600,
                fontSize: 20,
                letterSpacing: 0.2,
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo.shade900,
              elevation: 15,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(vertical: 18, horizontal: 40),
              shadowColor: Colors.blue.shade900,
            ),
            onPressed: () {
              // Store selected player IDs in selectedPlayerId list
              selectedTeamIdList.clear();
              for (int i = 0; i < Team.teams.length; i++) {
                if (selectedTeams[i] ?? false) {
                  selectedTeamIdList.add(Team.teams[i].teamId);
                }
              }
             Navigator.pop(context, selectedTeamIdList);
            },
          ),
        ),
      ),
    );
  }

}

