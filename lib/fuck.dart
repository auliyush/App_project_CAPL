import 'package:flutter/material.dart';
import 'package:merge_capl/aman/stats.dart';
import 'package:merge_capl/amit/create_match.dart';
import 'package:merge_capl/ayush/more_screen.dart';
import 'package:merge_capl/teams/team_screen.dart';

import 'home.dart';
import 'main.dart';

class Pages extends StatefulWidget {
  @override
  _PagesState createState() => _PagesState();
}

class _PagesState extends State<Pages> {
  int _currentIndex = 0;
  List<Widget> tabs = [
    MyHomePage(),
    TeamScreen(),
    Stats(
      playersTeamLogoUrl: "assets/images/milogo.jpeg",
      playersProfileUrl: "assets/images/rohit.jpeg",
      position: "01",
      playersName: "ROHIT SHARMA",
      matches: "20",
      average: "80.75",
      run: "510",
      strikeRate: "171.55",
      playersCentury: "5",
      playersHalfCentury: "15",
      playerHighScore: "110",
    ),
    CreateMatch(),
    MorePage()
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back_ios_new),
      //     onPressed: () {
      //       Navigator.pop(context);
      //     },
      //   ),
      // ),
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blue.shade800,
        unselectedItemColor: Colors.black54,

        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: "feed"),
          BottomNavigationBarItem(icon: Icon(Icons.search),label: "discover"),
          BottomNavigationBarItem(icon: Icon(Icons.chat),label: "chat"),
          BottomNavigationBarItem(icon: Icon(Icons.people),label: "friends"),
          BottomNavigationBarItem(icon: Icon(Icons.person),label: "profile"),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });

        },

      ),

    );
  }
}