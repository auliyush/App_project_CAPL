import 'package:flutter/material.dart';

import 'openStartpage.dart';

class SelectOpeningPlayersPage extends StatefulWidget {
  final String battingTeam;

  const SelectOpeningPlayersPage({super.key, required this.battingTeam});

  @override
  _SelectOpeningPlayersPageState createState() =>
      _SelectOpeningPlayersPageState();
}

class _SelectOpeningPlayersPageState extends State<SelectOpeningPlayersPage> {
  final TextEditingController strikerController = TextEditingController();
  final TextEditingController nonStrikerController = TextEditingController();
  final TextEditingController openingBowlerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF3b3b6d),
        title: Text('Select Opening players'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: strikerController,
              decoration: InputDecoration(
                labelText: 'Striker',
                labelStyle: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                // Increase the size of the input box
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: nonStrikerController,
              decoration: InputDecoration(
                labelText: 'Non-striker',
                labelStyle: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: openingBowlerController,
              decoration: InputDecoration(
                labelText: 'Opening bowler',
                labelStyle: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
              ),
            ),
            Spacer(),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ScoreCardPage(
                              batsman1: strikerController.text,
                              batsman2: nonStrikerController.text,
                              bowler: openingBowlerController.text,
                              battingTeam: widget.battingTeam,
                            )),
                  );
                  // Save settings logic here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // Button background color
                ),
                child: Center(
                  child: Text('Start Match',
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
