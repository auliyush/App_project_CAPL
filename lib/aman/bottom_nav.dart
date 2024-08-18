import 'package:flutter/material.dart';
import 'package:merge_capl/aman/stats.dart';
import 'package:merge_capl/amit/create_match.dart';
import 'package:merge_capl/ayush/more_screen.dart';
import 'package:merge_capl/teams/team_screen.dart';

import '../home.dart';

class Pages extends StatefulWidget {
  @override
  _PagesState createState() => _PagesState();
}

class _PagesState extends State<Pages> {
  int _currentIndex = 0;
  final List<Widget> _tabs = [
    MyHomePage(),
    TeamScreen(),
    CreateMatch(),
    Stats(
      playersTeamLogoUrl: "assets/images/teamlogo.png",
      playersProfileUrl: "assets/images/rohitsharma.webp",
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
    MorePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_currentIndex],
      bottomNavigationBar: SafeArea(
        child: BottomAppBar(
          child: LayoutBuilder(
            builder: (context, constraints) {
              double fabSize = 50;
              double bottomAppBarHeight = kBottomNavigationBarHeight;
              double spaceForFab = fabSize * 1.2;

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildNavItem(Icons.home, "Home", 0),
                  _buildNavItem(Icons.people, "Teams", 1),
                  SizedBox(width: spaceForFab),
                  _buildNavItem(Icons.stacked_bar_chart_sharp, "Stats", 3),
                  _buildNavItem(Icons.more_horiz_outlined, "More", 4),
                ],
              );
            },
          ),
          shape: CircularNotchedRectangle(),
          notchMargin: 15,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _currentIndex = 2;
          });
        },
        backgroundColor: Colors.blue.shade900,
        child: Icon(
          Icons.add_box,
          color: Colors.white,
          size: 30,
        ),
        elevation: 2,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    bool isActive = _currentIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _currentIndex = index;
          });
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          padding: EdgeInsets.symmetric(vertical: 6), // Reduced padding
          decoration: BoxDecoration(
            border: isActive
                ? Border(bottom: BorderSide(color: Colors.blue.shade900, width: 2))
                : null,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedScale(
                scale: isActive ? 1.2 : 1.0,
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: Icon(
                  icon,
                  color: isActive ? Colors.blue.shade900 : Colors.black54,
                  size: 22, // Adjusted icon size
                ),
              ),
              SizedBox(height: 2), // Reduced spacing
              AnimatedOpacity(
                opacity: isActive ? 1.0 : 0.6,
                duration: Duration(milliseconds: 300),
                child: Text(
                  label,
                  style: TextStyle(
                    color: isActive ? Colors.blue.shade900 : Colors.black54,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
