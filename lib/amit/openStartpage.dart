import 'package:flutter/material.dart';

class ScoreCardPage extends StatefulWidget {
  final String batsman1;
  final String batsman2;
  final String bowler;
  final String battingTeam;
  const ScoreCardPage({super.key, required this.batsman1, required this.batsman2, required this.bowler, required this.battingTeam});

  @override
  State<ScoreCardPage> createState() => _ScoreCardPageState();
}

class _ScoreCardPageState extends State<ScoreCardPage> {
  int score = 0;
  int balls = 0;
  int overs = 0;
  int wickets = 0;
  double crr = 0.0;

  List<int> scoreHistory = [];
  List<int> ballsHistory = [];
  List<int> wicketsHistory = [];

  List<Map<String, dynamic>> currentOverRuns = []; // Track runs in the current over with additional data

  @override
  void initState() {
    batsman1 = widget.batsman1;
    batsman2 = widget.batsman2;
    currentBowler = widget.bowler;
    currentStriker = widget.batsman1;
    super.initState();
  }

  String batsman1 = '';
  String batsman2 = '';
  String currentStriker = '';
  String newBatsmanName = ''; // For new batsman input
  String currentBowler = '';// for new bowler input

  int batsman1Runs = 0;
  int batsman2Runs = 0;
  int batsman1Balls = 0;
  int batsman2Balls = 0;
  int batsman1Fours = 0;
  int batsman2Fours = 0;
  int batsman1Sixes = 0;
  int batsman2Sixes = 0;


  bool isWide = false;
  bool isNoBall = false;
  bool isByes = false;
  bool isLegByes = false;
  bool isWicket = false;
  void updateScore(int run) {
    setState(() {
      scoreHistory.add(score);
      ballsHistory.add(balls);
      wicketsHistory.add(wickets);

      // Handle extras
      if (isWide || isNoBall) {
        score++;
        currentOverRuns.add({
          'run': 1,
          'isBoundary': false,
          'type': isWide ? 'W' : 'NB',
        });
        isWide = false;
        isNoBall = false;
      }

      if (!(isWide || isNoBall)) {
        score += run;
        balls++;
        currentOverRuns.add({
          'run': run,
          'isBoundary': (run == 4 || run == 6),
        });

        // Update runs for the current striker and check for boundaries
        if (currentStriker == batsman1) {
          batsman1Runs += run;
          batsman1Balls++;
          if (run == 4) batsman1Fours++;
          if (run == 6) batsman1Sixes++;
        } else {
          batsman2Runs += run;
          batsman2Balls++;
          if (run == 4) batsman2Fours++;
          if (run == 6) batsman2Sixes++;
        }
      }

      // Reset extras flags
      isByes = false;
      isLegByes = false;
      isWicket = false;

      crr = balls > 0 ? (score / balls) * 6 : 0.0;

      // End of over logic
      if (balls >= 6) {
        overs++;
        balls = 0; // Reset the ball count for a new over

        _showNewBowlerDialog(); // Prompt for a new bowler
        currentOverRuns.clear(); // Clear runs for the new over
      }
    });
  }
  void addExtras() {
    setState(() {
      scoreHistory.add(score);
      ballsHistory.add(balls);
      wicketsHistory.add(wickets);

      score++;
      currentOverRuns.add({'run': 1, 'isBoundary': false, 'type': 'Extra'}); // Consider 1 run for extra
    });
  }

  void addWicket() {
    setState(() {
      scoreHistory.add(score);
      ballsHistory.add(balls);
      wicketsHistory.add(wickets);

      wickets++;
      balls++; // Increment balls count when a wicket occurs

      currentOverRuns.add({
        'run': 0,
        'isBoundary': false,
        'type': 'W', // Indicate it's a wicket
      });

      _showNewBatsmanDialog(); // Prompt for new batsman's name
    });
  }


  // void addWicket() {
  //   setState(() {
  //     scoreHistory.add(score);
  //     ballsHistory.add(balls);
  //     wicketsHistory.add(wickets);
  //
  //     wickets++;
  //     _showNewBatsmanDialog(); // Prompt for new batsman's name
  //   });
  // }

  void undoLastAction() {
    if (scoreHistory.isNotEmpty && ballsHistory.isNotEmpty && wicketsHistory.isNotEmpty) {
      setState(() {
        score = scoreHistory.removeLast();
        balls = ballsHistory.removeLast();
        wickets = wicketsHistory.removeLast();
        if (currentOverRuns.isNotEmpty) {
          currentOverRuns.removeLast(); // Remove last run from this over
        }
        crr = balls > 0 ? (score / balls) * 6 : 0.0;
      });
    }
  }

  void retireBatsman() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Retire Batsman'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Retiring Batsman:'),
                trailing: DropdownButton<String>(
                  value: currentStriker,
                  onChanged: (String? newValue) {
                    setState(() {
                      newBatsmanName = newValue ?? '';
                    });
                  },
                  items: <String>[batsman1, batsman2].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              TextField(
                onChanged: (value) {
                  newBatsmanName = value;
                },
                decoration: InputDecoration(hintText: 'Enter new batsman\'s name'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Retire'),
              onPressed: () {
                if (newBatsmanName.isNotEmpty && newBatsmanName != '') {
                  setState(() {
                    if (currentStriker == batsman1) {
                      batsman1 = newBatsmanName;
                      batsman1Runs = 0;
                      batsman1Balls = 0;
                      batsman1Fours = 0;
                      batsman1Sixes = 0;
                    } else {
                      batsman2 = newBatsmanName;
                      batsman2Runs = 0;
                      batsman2Balls = 0;
                      batsman2Fours = 0;
                      batsman2Sixes = 0;
                    }
                    currentStriker = newBatsmanName;
                  });
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  void swapBatsman() {
    setState(() {
      // Swap names
      String tempName = batsman1;
      batsman1 = batsman2;
      batsman2 = tempName;

      // Swap runs
      int tempRuns = batsman1Runs;
      batsman1Runs = batsman2Runs;
      batsman2Runs = tempRuns;

      // Swap balls faced
      int tempBalls = batsman1Balls;
      batsman1Balls = batsman2Balls;
      batsman2Balls = tempBalls;

      // Swap number of fours
      int tempFours = batsman1Fours;
      batsman1Fours = batsman2Fours;
      batsman2Fours = tempFours;

      // Swap number of sixes
      int tempSixes = batsman1Sixes;
      batsman1Sixes = batsman2Sixes;
      batsman2Sixes = tempSixes;

      // Update the current striker
      currentStriker = currentStriker == batsman1 ? batsman2 : batsman1;
    });
  }

  double calculateStrikeRate(int runs, int ballsFaced) {
    return ballsFaced > 0 ? (runs / ballsFaced) * 100 : 0.0;
  }

  Future<void> _showNewBatsmanDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('New Batsman'),
          content: TextField(
            onChanged: (value) {
              newBatsmanName = value;
            },
            decoration: InputDecoration(hintText: 'Enter new batsman\'s name'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Add'),
              onPressed: () {
                if (newBatsmanName.isNotEmpty) {
                  setState(() {
                    if (currentStriker == batsman1) {
                      batsman1 = newBatsmanName;
                      batsman1Runs = 0;
                      batsman1Balls = 0;
                      batsman1Fours = 0;
                      batsman1Sixes = 0;
                    } else {
                      batsman2 = newBatsmanName;
                      batsman2Runs = 0;
                      batsman2Balls = 0;
                      batsman2Fours = 0;
                      batsman2Sixes = 0;
                    }
                    currentStriker = newBatsmanName;
                  });
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showNewBowlerDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('New Bowler'),
          content: TextField(
            onChanged: (value) {
              currentBowler = value; // Update the new bowler's name
            },
            decoration: InputDecoration(hintText: 'Enter new bowler\'s name'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Add'),
              onPressed: () {
                if (currentBowler.isNotEmpty) {
                  setState(() {
                    // Update current bowler
                    // Clear or reset any relevant statistics if needed
                  });
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }




  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF3b3b6d),
        title: Text(
          'Team 1 v/s Team 2',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.data_exploration_outlined, color: Colors.white),
        //     onPressed: () {},
        //   ),
        //   IconButton(
        //     icon: Icon(Icons.scoreboard, color: Colors.white),
        //     onPressed: () {},
        //   ),
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${widget.battingTeam}, 1st inning',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Text(

                    '$score - $wickets ($overs - $balls)',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Text(
                    'CRR: ${crr.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              SizedBox(height: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('Batsman')),
                    DataColumn(label: Text('R')),
                    DataColumn(label: Text('B')),
                    DataColumn(label: Text('4s')),
                    DataColumn(label: Text('6s')),
                    DataColumn(label: Text('SR')),
                  ],
                  rows: [
                    DataRow(cells: [
                      DataCell(Text('$currentStriker*')),
                      DataCell(Text(currentStriker == batsman1 ? batsman1Runs.toString() : batsman2Runs.toString())),
                      DataCell(Text(currentStriker == batsman1 ? batsman1Balls.toString() : batsman2Balls.toString())),
                      DataCell(Text(currentStriker == batsman1 ? batsman1Fours.toString() : batsman2Fours.toString())),
                      DataCell(Text(currentStriker == batsman1 ? batsman1Sixes.toString() : batsman2Sixes.toString())),
                      DataCell(Text(calculateStrikeRate(
                          currentStriker == batsman1 ? batsman1Runs : batsman2Runs,
                          currentStriker == batsman1 ? batsman1Balls : batsman2Balls)
                          .toStringAsFixed(2))),
                    ]),
                    DataRow(cells: [
                      DataCell(Text(currentStriker == batsman1 ? batsman2 : batsman1)),
                      DataCell(Text(currentStriker == batsman1 ? batsman2Runs.toString() : batsman1Runs.toString())),
                      DataCell(Text(currentStriker == batsman1 ? batsman2Balls.toString() : batsman1Balls.toString())),
                      DataCell(Text(currentStriker == batsman1 ? batsman2Fours.toString() : batsman1Fours.toString())),
                      DataCell(Text(currentStriker == batsman1 ? batsman2Sixes.toString() : batsman1Sixes.toString())),
                      DataCell(Text(calculateStrikeRate(
                          currentStriker == batsman1 ? batsman2Runs : batsman1Runs,
                          currentStriker == batsman1 ? batsman2Balls : batsman1Balls)
                          .toStringAsFixed(2))),
                    ]),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('Bowler')),
                    DataColumn(label: Text('O')),
                    DataColumn(label: Text('M')),
                    DataColumn(label: Text('R')),
                    DataColumn(label: Text('W')),
                    DataColumn(label: Text('ER')),
                  ],
                  rows: [
                    DataRow(
                      cells: [
                        DataCell(Text(currentBowler.isNotEmpty ? currentBowler : 'N/A')), // Display the current bowler
                        DataCell(Text('0.0')), // Placeholder for overs
                        DataCell(Text('0')), // Placeholder for maidens
                        DataCell(Text('0')), // Placeholder for runs
                        DataCell(Text('0')), // Placeholder for wickets
                        DataCell(Text('0.00')), // Placeholder for economy rate
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('This over:'),
                  SizedBox(height: 8),
                  Wrap(
                    spacing: 8.0,
                    children: currentOverRuns.map((runData) {
                      int run = runData['run'];
                      bool isBoundary = runData['isBoundary'];
                      String type = runData.containsKey('type') ? runData['type'] : '';
                      return Chip(
                        label: Text(
                          '$run$type',
                          style: TextStyle(
                            color: type == 'W' ? Colors.red : (isBoundary ? Colors.deepOrange : Colors.black),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                          value: isWide,
                          onChanged: (val) {
                            setState(() {
                              isWide = val ?? false;
                              isNoBall = false; // Only one can be true at a time
                            });
                          }),
                      Text('Wide'),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                          value: isNoBall,
                          onChanged: (val) {
                            setState(() {
                              isNoBall = val ?? false;
                              isWide = false; // Only one can be true at a time
                            });
                          }),
                      Text('No Ball'),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                          value: isByes,
                          onChanged: (val) {
                            setState(() {
                              isByes = val ?? false;
                            });
                          }),
                      Text('Byes'),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                          value: isLegByes,
                          onChanged: (val) {
                            setState(() {
                              isLegByes = val ?? false;
                            });
                          }),
                      Text('Leg Byes'),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                        value: isWicket,
                        onChanged: (val) {
                          setState(() {
                            isWicket = val ?? false;
                            if (isWicket) {
                              addWicket(); // Call addWicket when the checkbox is selected
                            }
                          });
                        },
                      ),
                      Text('Wicket'),
                    ],
                  ),
                  SizedBox(width: 10), // Add some spacing between elements
                  ElevatedButton(
                    onPressed: retireBatsman,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green, // Background color
                    ),
                    child: Text(
                      '      Retire      ',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(width: 10), // Add some spacing between elements
                  ElevatedButton(
                    onPressed: swapBatsman,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green, // Background color
                    ),
                    child: Text(
                      'Swap Batsman',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 4, // 30% of the width
                    child: Container(
                      padding: const EdgeInsets.all(8.0), // Optional padding for styling
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ElevatedButton(
                            onPressed: undoLastAction,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green, // Background color
                            ),
                            child: Text(
                              '       Undo       ',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green, // Background color
                            ),
                            child: Text(
                              'Partnerships',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green, // Background color
                            ),
                            child: Text(
                              '      Extras     ',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 7, // 70% of the width
                    child: Container(
                      padding: const EdgeInsets.all(8.0), // Optional padding for buttons
                      child: Wrap(
                        spacing: 15,
                        runSpacing: 10,
                        alignment: WrapAlignment.center,
                        children: List.generate(7, (index) {
                          int buttonNumber = index; // Start from 0 instead of 1
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              side: BorderSide(color: Colors.green, width: 2), // Border color and width
                              minimumSize: Size(50, 50), // Optional size for buttons
                            ),
                            onPressed: () => updateScore(buttonNumber),
                            child: Text(buttonNumber.toString()),
                          );
                        })
                          ..add(
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                side: BorderSide(color: Colors.green, width: 2), // Border color and width
                                minimumSize: Size(50, 50), // Optional size for buttons
                              ),
                              onPressed: addExtras,
                              child: Text('      More      '),
                            ),
                          ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

