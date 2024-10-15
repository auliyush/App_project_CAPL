import 'package:flutter/material.dart';
import '../home_screens/home.dart';
import '../more_screens/more_screen.dart';
import '../stats/stats_screen.dart';
import '../team_screens/player_team_screen.dart';
import '../tournament_screens/tournament_list_sceen.dart';
import '../tournament_screens/tournament_screen.dart';


class UserBottomNav extends StatefulWidget {
  @override
  _UserBottomNavState createState() => _UserBottomNavState();
}

class _UserBottomNavState extends State<UserBottomNav> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late AnimationController _animationController;
  late List<Animation<double>> _animations;

  final List<Widget> _tabs = [
    MyHomePage(),
    PlayerTeamScreen(),
    TournamentListScreen(),
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
    MoreScreen(),
  ];

  final List<IconData> _icons = [
    Icons.home,
    Icons.people,
    Icons.touch_app,
    Icons.stacked_bar_chart_sharp,
    Icons.more_horiz_outlined,
  ];

  final List<String> _labels = [
    'Home',
    'Teams',
    'Tournament',
    'Stats',
    'More',
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );

    _animations = _icons.map((icon) {
      return Tween<double>(begin: 1.0, end: 1.2).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Curves.easeInOut,
        ),
      );
    }).toList();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void onTabTapped(int index) {
    if (_currentIndex != index) {
      setState(() {
        _currentIndex = index;
      });
      _animationController.forward().then((_) {
        _animationController.reset();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final bool isDesktop = screenSize.width >= 1024;
    final double iconSize = isDesktop ? 40.0 : screenSize.width * 0.075;
    final double fontSize = isDesktop ? 16.0 : screenSize.width * 0.03;
    final double navBarHeight = isDesktop ? 70.0 : screenSize.height * 0.08;

    return Scaffold(
      body: _tabs[_currentIndex],
      bottomNavigationBar: Container(
        height: navBarHeight,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
            ),
          ],
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(_icons.length, (index) {
                return _buildNavItem(
                  icon: _icons[index],
                  label: _labels[index],
                  index: index,
                  iconSize: iconSize,
                  fontSize: fontSize,
                );
              }),
            );
          },
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
    required double iconSize,
    required double fontSize,
  }) {
    bool isActive = _currentIndex == index;

    return GestureDetector(
      onTap: () => onTabTapped(index),
      behavior: HitTestBehavior.translucent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: isActive ? _animations[index] : AlwaysStoppedAnimation(1.0),
            child: Icon(
              icon,
              size: iconSize,
              color: isActive ? Colors.blue : Colors.grey,
            ),
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: fontSize,
              color: isActive ? Colors.blue : Colors.grey,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
