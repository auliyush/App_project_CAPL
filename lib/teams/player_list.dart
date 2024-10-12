import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:merge_capl/integration/api/player_list.dart';
import 'package:http/http.dart' as http;

import '../integration/data_classes/player_role_response.dart';

class Player {
  final String playerId;
  final String name;
  final String playerPhoto;
  final String role;
  final String playerSpec;
  final bool inTeam;

  Player({
    required this.playerId,
    required this.name,
    required this.role,
    required this.playerPhoto,
    required this.playerSpec,
    required this.inTeam,
  });

  static List<Player> players = [];

  static void addPlayersFromResponse(List<PlayerDataByRole> playerRoles) {
    players.clear(); // Clear the players list before adding new data
    for (var playerRole in playerRoles) {
      players.add(Player(
        playerId: playerRole.playerId,
        name: playerRole.playerName,
        role: "Batter",
        playerSpec: playerRole.playerSubType,
        playerPhoto: playerRole.playerProfilePhotoUrl,
        inTeam: playerRole.inTeam,
      ));
    }
  }
}

class PlayerList extends StatefulWidget {
  String? playerType;
  String? teamId;
  PlayerList({required this.playerType, required this.teamId});
  @override
  _PlayerListState createState() => _PlayerListState();
}

class _PlayerListState extends State<PlayerList> {
  Future<PlayerRoleResponse?>? playerRoleResponseFuture;

  PlayerApi api = PlayerApi();
  Map<int, bool> selectedPlayers = {};
  List<String> selectedPlayerId = []; // for sent data to server which is selected.

  @override
  void initState() {
    super.initState();
    _fetchPlayerData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchPlayerData();
  }

  void _fetchPlayerData() {
    if (selectedPlayers.containsValue(true)) {
      Player.players.clear();
      // selectedPlayers.clear();
    }

    // Fetch new data from the server
    setState(() {
      playerRoleResponseFuture = api.getPlayerListByRole(widget.playerType!, context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: FutureBuilder<PlayerRoleResponse?>(
        future: playerRoleResponseFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }  return Column(
            children: [
              _buildHeader(screenWidth, screenHeight),
              _buildPlayerList(),
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
              "Add-Your-Team",
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

  Widget _buildPlayerList() {
    return Expanded(
      child: ListView.builder(
        itemCount: Player.players.length,
        itemBuilder: (context, index) {
          return _buildPlayerTile(index, Player.players[index].inTeam);
        },
      ),
    );
  }

  Widget _buildPlayerTile(int index, bool inTeamStatus) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage('${Player.players[index].playerPhoto}'),
        ),
        title: Text(
          Player.players[index].name,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Row(
          children: [
            Text(
              '${Player.players[index].playerSpec}',
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

  Widget _buildSelectButton(int index , bool inTeamStatus) {
    // bool isSelected = selectedPlayers[index] ?? false;
    // bool isInTeam = selectedPlayerId.contains(Player.players[index].playerId);
    if (inTeamStatus) {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: inTeamStatus ? Colors.grey : Colors.indigo.shade900,
          elevation: 0,
          padding: EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: inTeamStatus
            ? null
            : () {
          setState(() {
            selectedPlayers[index] = !inTeamStatus;
          });
        },
        child: Text(inTeamStatus ? 'Selected' : 'Select'),
      );
    }
    else {
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
              selectedPlayerId.clear();
              for (int i = 0; i < Player.players.length; i++) {
                if (selectedPlayers[i] ?? false) {
                  selectedPlayerId.add(Player.players[i].playerId);
                }
              }
              // this helps to call my api add player in team correctly...
              api.addPlayerInTeam(selectedPlayerId,widget.teamId!, context);
              // print('Selected player IDs: $selectedPlayerId');
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }

}
