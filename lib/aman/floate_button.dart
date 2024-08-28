import 'package:flutter/material.dart';
import 'package:merge_capl/aman/stats.dart';

class SeasonSelector extends StatefulWidget {
  @override
  _SeasonSelectorState createState() => _SeasonSelectorState();
}

class _SeasonSelectorState extends State<SeasonSelector> {
  int _selectedYear = 2024;
  String _selectedRole = 'Batters'; // New state variable for role selection

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF03055B), // Navy blue
                Color(0xFF87CEFF), // Bright blue
              ],
            )),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05,
            vertical: screenHeight * 0.03,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBackButton(),
              _buildSeasonTitle(screenWidth),
              _buildSeasonList(),
              _buildRoleSelector(), // Inserted role selector here
              _buildApplyButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  Widget _buildSeasonTitle(double screenWidth) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Text(
        "SEASON",
        style: TextStyle(
          fontSize: screenWidth <= 750 ? screenWidth * 0.07 : 48,
          color: Colors.white,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildSeasonList() {
    return Expanded(
      child: ListView.builder(
        itemCount: 9, // Number of seasons to display
        itemBuilder: (context, index) {
          int year = 2024 - index;
          return ListTile(
            title: Text(
              year.toString(),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            trailing: _selectedYear == year
                ? Icon(
              Icons.check,
              color: Colors.white,
            )
                : null,
            onTap: () {
              setState(() {
                _selectedYear = year;
              });
            },
            tileColor: _selectedYear == year ? Colors.blue.shade600 : null,
            contentPadding: EdgeInsets.symmetric(vertical: 12),
          );
        },
      ),
    );
  }

  // New widget for role selection
  Widget _buildRoleSelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              "SELECT ROLE",
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
              ),
            ),
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 120, // specify the width here
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedRole = 'Batters';
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.orange.shade800),
                      borderRadius: BorderRadius.circular(8),
                      color: _selectedRole == 'Batters' ? Colors.orange[800] : Colors.transparent,
                    ),
                    child: Center(
                      child: Text(
                        'BATTERS',
                        style: TextStyle(
                          color: _selectedRole == 'Batters' ? Colors.white : Colors.orange[800],
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12),
              SizedBox(
                width: 120, // specify the width here
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedRole = 'Bowlers';
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.purple.shade900),
                      borderRadius: BorderRadius.circular(8),
                      color: _selectedRole == 'Bowlers' ? Colors.purple[900] : Colors.transparent,
                    ),
                    child: Center(
                      child: Text(
                        'BOWLERS',
                        style: TextStyle(
                          color: _selectedRole == 'Bowlers' ? Colors.white : Colors.purple.shade900,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildApplyButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: Center(
        child: Transform(
          transform: Matrix4.skewX(-0.2), // skew the button to the left
          child: ElevatedButton(
            child: Text(
              'Apply',
              style: TextStyle(
                fontFamily: "Netflix",
                fontWeight: FontWeight.w600,
                fontSize: 20,
                letterSpacing: 0.2,
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade900,
              elevation: 15,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(vertical: 18, horizontal: 40),
              shadowColor: Colors.blue.shade900,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Stats(
                    playersTeamLogoUrl: 'assets/images/teamlogo.png',
                    playersProfileUrl: 'assets/images/rohitsharma.webp',
                    position: '01',
                    playersName: 'ROHIT SHARMA',
                    matches: '15',
                    average: '50',
                    run: '390',
                    strikeRate: '155',
                    playersCentury: '2',
                    playersHalfCentury: '8',
                    playerHighScore: '105',
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
