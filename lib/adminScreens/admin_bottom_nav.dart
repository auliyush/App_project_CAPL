import 'package:flutter/material.dart';
import 'package:merge_capl/integration/api/team_list.dart';
import 'package:merge_capl/adminScreens/teamScreens/team_screen.dart';

import '../home_screens/home.dart';
import '../stats/stats_screen.dart';
import 'createMatchScreens/create_match_screen.dart';
import 'moreScreen/admin_more_screen.dart';

class AdminBottomNav extends StatefulWidget {
  @override
  _AdminBottomNavState createState() => _AdminBottomNavState();
}

class _AdminBottomNavState extends State<AdminBottomNav> {
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
    const AdminMorePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_currentIndex],
      bottomNavigationBar: SafeArea(
        child: BottomAppBar(
          color: Colors.blue.shade100,
          shape: const CircularNotchedRectangle(),
          notchMargin: 15,
          child: LayoutBuilder(
            builder: (context, constraints) {
              double fabSize = 50;
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
            if(index == 1) {
              TeamList list = TeamList();
              list.getTeamList(context);
            }
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
