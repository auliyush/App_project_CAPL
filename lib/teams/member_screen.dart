import 'package:flutter/material.dart';

import '../hold_models/items/team_data.dart';
import '../lists/all_rounders.dart';
import '../lists/batters.dart';
import '../lists/bowlers.dart';

class MemberScreen extends StatefulWidget {
  final TeamData teamData;

  const MemberScreen({super.key, required this.teamData});
  @override
  State<MemberScreen> createState() => _MemberScreenState();
}

class _MemberScreenState extends State<MemberScreen> {
  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    final List<Widget> _tabs = [
      Batters(teamData: widget.teamData,),
      Bowlers(teamData: widget.teamData,),
      AllRounders(teamData: widget.teamData,)
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
                  padding: const EdgeInsets.only(left: 18, top: 80),
                  child: Text(
                    "Add-Member-In-Team",
                    style: TextStyle(
                      fontSize: screenWidth <= 750 ? screenWidth * 0.06 : 44,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
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
}