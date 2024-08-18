import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../hold_models/items/team_data.dart';
import '../hold_models/player_list_model.dart';
import '../hold_models/items/decorate_player.dart';
import '../hold_models/items/player_data.dart';
import '../members/allrounder_screen.dart';

// 96 at 11:25

class AllRounders extends StatefulWidget {
final TeamData teamData;
  const AllRounders({super.key, required this.teamData});

  @override
  _AllRoundersState createState() => _AllRoundersState();

}

class _AllRoundersState extends State<AllRounders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 20,bottom: 15),
        child: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Color(0xFF3b3b6d),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AllRounderScreen(
                      teamData: widget.teamData,
                    ))).then((value) {
              if (value != null) {
                Provider.of<ListModel>(context, listen: false)
                    .addAllRounderToTeam(widget.teamData.teamId, value);
              }
            });
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Consumer<ListModel>(
          builder: (context, model, child) {
            return Column(
              children: [
                for (PlayerData player
                in model.getTeamAllRounders(widget.teamData.teamId))
                  DecoratePlayer(playerData: player)
              ],
            );
          },
        ),
      ),
    );
  }
}
