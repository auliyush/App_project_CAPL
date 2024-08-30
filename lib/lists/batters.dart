import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../hold_models/items/player_data.dart';
import '../hold_models/items/team_data.dart';
import '../hold_models/player_list_model.dart';
import 'package:merge_capl/teams/player_list.dart';

class Batters extends StatefulWidget {
  final TeamData teamData;

  const Batters({super.key, required this.teamData});

  @override
  _BattersState createState() => _BattersState();
}

class _BattersState extends State<Batters> {
  PlayerData? _selectedPlayer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 20, bottom: 15),
        child: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Color(0xFF3b3b6d),
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PlayerList()));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Consumer<ListModel>(
          builder: (context, model, child) {
            final batters = model.getTeamBatters(widget.teamData.teamId);
            return Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  for (PlayerData player in batters)
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: _selectedPlayer == player ? Colors.blueAccent : Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text("player.name"), // Use the actual player name
                            subtitle: Text('Additional details'), // Replace with actual details if available
                          ),
                          if (_selectedPlayer == player)
                            ElevatedButton(
                              onPressed: () {
                                // Handle selection confirmation
                                // For example, you might update a model or navigate
                                print('Selected player: ');
                              },
                              child: Text('Confirm Selection'),
                            ),
                          if (_selectedPlayer != player)
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _selectedPlayer = player;
                                });
                              },
                              child: Text('Select'),
                            ),
                        ],
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
