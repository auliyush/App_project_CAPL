import 'package:flutter/material.dart';
import 'package:merge_capl/adminScreens/teamScreens/teamPlayersScreens/player_card_page.dart';
import 'package:merge_capl/adminScreens/teamScreens/teamPlayersScreens/playerListScreens/player_list.dart';

import '../../../integration/api/player_list.dart';
import '../../../integration/response_classes/player_data.dart';
import '../../../integration/response_classes/team_data.dart';

class Batters extends StatefulWidget {
  final TeamData teamData;

  const Batters({super.key, required this.teamData});

  @override
  _BattersState createState() => _BattersState();
}

class _BattersState extends State<Batters> {
  late Future<List<FetchedPlayerData>?> _future;
  PlayerApi playerApi = PlayerApi();

  @override
  void initState() {
    super.initState();
    _future = playerApi.getPlayerByRoleForTeam(widget.teamData.teamId,"Batsman", context);
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
                context, MaterialPageRoute(builder: (context) => PlayerList(
              playerType: "Batsman", teamId: widget.teamData.teamId,)));
          },
        ),
      ),
      body:  Padding(
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

  /// todo work is that i have to complete add player in team first then do it

}
