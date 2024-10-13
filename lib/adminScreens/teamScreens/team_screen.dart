import 'package:flutter/material.dart';
import 'package:merge_capl/adminScreens/admin_bottom_nav.dart';
import 'package:merge_capl/integration/api/team_list.dart';

import '../../start/Login.dart';
import '../../integration/response_classes/team_data.dart';
import 'team_card_page.dart';
import 'create_team_screen.dart';
class TeamScreen extends StatefulWidget {
  @override
  State<TeamScreen> createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  late Future<List<TeamData>?> _future;
  TeamList list = TeamList();

  @override
  void initState() {
    super.initState();
    _future = list.getTeamList(context);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 20, bottom: 15),
        child: FloatingActionButton(
          heroTag: null,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CreateTeamScreen()));
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 30,
          ),
          backgroundColor: Color(0xFF3b3b6d),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 130,
            child: Stack(
              children: [
                // background image
                Container(
                  height: 130,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/bg.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // back button
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.02,
                      vertical: screenHeight * 0.02),
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AdminBottomNav()));
                    },
                  ),
                ),
                // screen name
                Padding(
                  padding: const EdgeInsets.only(left: 18, top: 70),
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
          ),
          Expanded(
            child: Padding(
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
                              return DecorateTeam(teamData: snapshot.data![index]);
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
          ),
        ],
      ),
    );
  }
}