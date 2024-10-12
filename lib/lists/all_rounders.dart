import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../hold_models/items/team_data.dart';
import '../hold_models/player_list_model.dart';
import '../hold_models/items/decorate_player.dart';
import '../hold_models/items/player_data.dart';
import '../integration/api/player_list.dart';
import '../teams/player_list.dart';

// 96 at 11:25

class AllRounders extends StatefulWidget {
  final TeamData teamData;

  const AllRounders({super.key, required this.teamData});

  @override
  _AllRoundersState createState() => _AllRoundersState();
}

class _AllRoundersState extends State<AllRounders> {
  late Future<List<FetchedPlayerData>?> _future;
  PlayerApi playerApi = PlayerApi();

  @override
  void initState() {
    super.initState();
    _future = playerApi.getPlayerByRoleForTeam(
        widget.teamData.teamId, "Allrounder", context);
  }

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
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => PlayerList(playerType: "Allrounder", teamId: widget.teamData.teamId,)));
          },
        ),
      ),
      body:Padding(
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
            child: FutureBuilder(
              future: _future,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data != null) {
                    return ListView.builder(
                      shrinkWrap: false,
                      physics: ClampingScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return DecoratePlayer(playerData: snapshot.data![index],);
                      },
                    );
                  } else {
                    return Text('No data available');
                  }
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
