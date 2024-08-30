import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Player {
  final String name;
  final String role;
  final String playerSpec;
  final int jerseyNumber;

  Player({required this.name, required this.role, required this.jerseyNumber, required this.playerSpec});
}

class PlayerList extends StatefulWidget {
  @override
  _PlayerListState createState() => _PlayerListState();
}

class _PlayerListState extends State<PlayerList> {
  List<Player> players = [
    Player(name: 'Player 1', role: 'Batter', jerseyNumber: 10, playerSpec: "left-arm"),
    Player(name: 'Player 1', role: 'Batter', jerseyNumber: 10, playerSpec: "left-arm"),
    Player(name: 'Player 1', role: 'Batter', jerseyNumber: 10, playerSpec: "left-arm"),
    Player(name: 'Player 1', role: 'Batter', jerseyNumber: 10, playerSpec: "left-arm"),
    Player(name: 'Player 1', role: 'Batter', jerseyNumber: 10, playerSpec: "left-arm"),
    Player(name: 'Player 1', role: 'Batter', jerseyNumber: 10, playerSpec: "left-arm"),
    Player(name: 'Player 1', role: 'Batter', jerseyNumber: 10, playerSpec: "left-arm"),
    Player(name: 'Player 1', role: 'Batter', jerseyNumber: 10, playerSpec: "left-arm"),
    Player(name: 'Player 1', role: 'Batter', jerseyNumber: 10, playerSpec: "left-arm"),
    Player(name: 'Player 1', role: 'Batter', jerseyNumber: 10, playerSpec: "left-arm"),
    Player(name: 'Player 1', role: 'Batter', jerseyNumber: 10, playerSpec: "left-arm"),
    Player(name: 'Player 1', role: 'Batter', jerseyNumber: 10, playerSpec: "left-arm"),
    Player(name: 'Player 1', role: 'Batter', jerseyNumber: 10, playerSpec: "left-arm"),
    Player(name: 'Player 1', role: 'Batter', jerseyNumber: 10, playerSpec: "left-arm"),
    Player(name: 'Player 1', role: 'Batter', jerseyNumber: 10, playerSpec: "left-arm"),
    // Add more players as needed
  ];

  Map<int, bool> selectedPlayers = {};

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        children: [
          _buildHeader(screenWidth, screenHeight),
          _buildPlayerList(),
          Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: _buildApplyButton(),
          ),
        ],
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
        itemCount: players.length,
        itemBuilder: (context, index) {
          return _buildPlayerTile(index);
        },
      ),
    );
  }

  Widget _buildPlayerTile(int index) {
    return ListTile(
      title: Text(players[index].name),
      subtitle: Row(
        children: [
          // Text('Jersey Number: ${players[index].jerseyNumber}'),
          Text('${players[index].playerSpec}'),
        ],
      ),
      trailing: _buildSelectButton(index),
    );
  }

  Widget _buildSelectButton(int index) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: selectedPlayers[index] ?? false ? Colors.indigo.shade900 : Colors.grey,
        elevation: 0,
        padding: EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: () {
        setState(() {
          selectedPlayers[index] = !(selectedPlayers[index] ?? false);
        });
      },
      child: Text(selectedPlayers[index] ?? false ? 'Selected' : 'Select'),
    );
  }

  Widget _buildApplyButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: Center(
        child: Transform(
          transform: Matrix4.skewX(-0.2), // skew the button to the left
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
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
}