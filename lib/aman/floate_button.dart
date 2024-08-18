import 'package:flutter/material.dart';
import 'package:merge_capl/aman/stats.dart';

class SeasonSelector extends StatefulWidget {
  @override
  _SeasonSelectorState createState() => _SeasonSelectorState();
}

class _SeasonSelectorState extends State<SeasonSelector> {
  int _selectedYear = 2024;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient:LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF03055B), // Navy blue
                Color(0xFF87CEFF), // Bright blue
              ],
            )


        ),
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
                ? Icon(Icons.check, color: Colors.white,)
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

  Widget _buildApplyButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: Center(
        child: ElevatedButton(
          child: Text(
            'Apply',
            style: TextStyle(
              fontFamily: "Netflix",
              fontWeight: FontWeight.w600,
              fontSize: 18,
              letterSpacing: 0.2,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue.shade900,
            foregroundColor: Colors.white,
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
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
    );
  }
}
