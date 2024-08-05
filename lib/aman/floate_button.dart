import 'package:flutter/material.dart';
import 'package:merge_capl/aman/stats.dart';


class SeasonSelector extends StatefulWidget {
  @override
  _SeasonSelectorState createState() => _SeasonSelectorState();
}

class _SeasonSelectorState extends State<SeasonSelector> {
  int selectedYear = 2024;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Season Selector'),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {},
                child: Text(
                  'SEASON',
                  style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 9, // Number of seasons to display
              itemBuilder: (context, index) {
                int year = 2024 - index;
                return ListTile(
                  title: Text(year.toString()),
                  trailing: selectedYear == year
                      ? Icon(Icons.check, color: Colors.blue)
                      : null,
                  onTap: () {
                    setState(() {
                      selectedYear = year;
                    });
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.blue[900], // White text color
              ),
              onPressed: () {
                Navigator.push(
                  context,
                   MaterialPageRoute(builder: (context) => Stats(
                     playersTeamLogoUrl: 'assets/images/milogo.jpeg',
                     playersProfileUrl: 'assets/images/rohit.jpeg',
                     position: '01',
                     playersName: 'ROHIT SHARMA',
                     matches: '15',
                     average: '50',
                     run: '390',
                     strikeRate: '155',
                     playersCentury: '2',
                     playersHalfCentury: '8',
                     playerHighScore: '105',
                   )),
                );
              },
              child: Text('APPLY'),
            ),
          ),

        ],
      ),
    );
  }
}