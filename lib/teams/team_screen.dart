import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../hold_models/items/decorate_team.dart';
import '../hold_models/items/team_data.dart';
import '../hold_models/player_list_model.dart';
import 'create_team_screen.dart';

class TeamScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Teams",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        backgroundColor: Color(0xFF3b3b6d),
      ),

      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 20,bottom: 15),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CreateTeamScreen()))
                .then((value) {
              if (value != null) {
                Provider.of<ListModel>(context, listen: false).addNewTeam(value);
              }
            });
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Color(0xFF3b3b6d),
        ),
      ),
      body: SingleChildScrollView(
        child: Consumer<ListModel>(
          builder: (context, model, child) {
            return Column(
              children: [
                for (TeamData teams in model.teams) DecorateTeam(teamData: teams)
              ],
            );
          },
        ),
      ),
    );
  }
}
