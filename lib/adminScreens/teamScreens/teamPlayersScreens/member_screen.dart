import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../integration/providers/login_provider.dart';
import '../../../integration/response_classes/team_data.dart';
import 'all_rounders_screens.dart';
import 'batters_screen.dart';
import 'bowlers_screen.dart';

class MemberScreen extends StatefulWidget {
  final TeamData teamData;

  const MemberScreen({super.key, required this.teamData});

  @override
  State<MemberScreen> createState() => _MemberScreenState();
}

class _MemberScreenState extends State<MemberScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final List<Widget> _tabs = [
      Batters(teamData: widget.teamData),
      Bowlers(
        teamData: widget.teamData,
      ),
      AllRounders(
        teamData: widget.teamData,
      )
    ];
    return DefaultTabController(
      length: _tabs.length,
      initialIndex: 0,
      child: Scaffold(
        body: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 130,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/bg.jpg"),
                    ),
                  ),
                ),
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
                      Navigator.pop(context);
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 18, top: 70),
                      child: Text(
                        "Team Members",
                        style: TextStyle(
                          fontSize:
                              screenWidth <= 750 ? screenWidth * 0.06 : 44,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18, top: 70),
                      child: _buildDeleteButton(widget.teamData.teamCreatorId),
                      // todo this is not complete
                    ),
                  ],
                )
              ],
            ),
            TabBar(
              tabs: [
                Tab(
                  icon: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.transparent,
                    child: Image.asset("assets/images/bat.png"),
                  ),
                  text: "Batter's",
                ),
                Tab(
                  icon: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.transparent,
                    child: Image.asset("assets/images/ball.png"),
                  ),
                  text: "Bowler's",
                ),
                Tab(
                  icon: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.transparent,
                    child: Image.asset("assets/images/p1.jpg"),
                  ),
                  text: "All-Rounder's",
                ),
              ],
              labelStyle: TextStyle(color: Colors.orange.shade900),
              unselectedLabelColor: Color(0xFF3b3b6d),
            ),
            Expanded(
              child: TabBarView(children: _tabs),
            ),
          ],
        ),
      ),
    );
  }

  void showDeleteConfirmationDialog(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete team ?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                //onConfirm(); // Execute the confirm callback
                Navigator.of(context).pop(); // Close the dialog
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.red, // Set text color to red
              ),
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  Widget? _buildDeleteButton(String teamCreatorId){
    String? loggedId = Provider.of<LoginProvider>
      (context, listen: false).loginResponse?.signInId;
    if(loggedId == teamCreatorId){
      return IconButton(
        onPressed: () {
          showDeleteConfirmationDialog(context);
        },
        icon: Icon(Icons.delete_rounded),
        iconSize: 30.0, // Size of the icon
        color: Colors.white, // Color of the icon
        padding: EdgeInsets.all(8.0), // Padding around the icon
        splashColor: Colors.blue.shade900,
      );
    } else {
      return null;
    }
  }
}
