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

  final wideController = TextEditingController();
  final noBallController = TextEditingController();
  final legByesController = TextEditingController();
  final byesController = TextEditingController();

  int score = 0;
  int balls = 0;
  int overs = 0;
  int wickets = 0;
  double crr = 0.0;
  List<int> extrasHistory = [];
  List<int> scoreHistory = [];
  List<int> ballsHistory = [];
  List<int> wicketsHistory = [];
  List<int> batsmanRunsHistory = [];
  List<int> bowlerRunsHistory = [];
  List<int> bowlerWicketsHistory = [];

  List<int> batsman1RunsHistory = [];
  List<int> batsman1BallsHistory = [];
  List<int> batsman1FoursHistory = [];
  List<int> batsman1SixesHistory = [];

  List<int> batsman2RunsHistory = [];
  List<int> batsman2BallsHistory = [];
  List<int> batsman2FoursHistory = [];
  List<int> batsman2SixesHistory = [];



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
  String selectedWicketType = 'LBW';
  // String selectedWicketType = 'LBW';
  // String newBatsmanName = '';
  int partnershipRuns = 0;
  // String newBatsmanName = '';
  int batsman1Runs = 0;
  int batsman2Runs = 0;
  int batsman1Balls = 0;
  int batsman2Balls = 0;
  int batsman1Fours = 0;
  int batsman2Fours = 0;
  int batsman1Sixes = 0;
  int batsman2Sixes = 0;
  int penaltyRuns = 0;



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

      batsman1RunsHistory.add(batsman1Runs);
      batsman1BallsHistory.add(batsman1Balls);
      batsman1FoursHistory.add(batsman1Fours);
      batsman1SixesHistory.add(batsman1Sixes);

      batsman2RunsHistory.add(batsman2Runs);
      batsman2BallsHistory.add(batsman2Balls);
      batsman2FoursHistory.add(batsman2Fours);
      batsman2SixesHistory.add(batsman2Sixes);

      // Handle extras first
      if (isWide || isNoBall || isByes || isLegByes) {
        int extraRuns = 0;
        if (isWide) {
          extraRuns = extraWides;
        } else if (isNoBall) {
          extraRuns = extraNoBalls;
        } else if (isByes) {
          extraRuns = extraByes;
        } else if (isLegByes) {
          extraRuns = extraLegByes;
        }

        score += extraRuns;
        currentOverRuns.add({
          'run': extraRuns,
          'isBoundary': false,
          'type': isWide ? 'W' : isNoBall ? 'NB' : isByes ? 'B' : 'LB',
        });

        isWide = false;
        isNoBall = false;
        isByes = false;
        isLegByes = false;
      } else {
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


//add penality run
  void addPenaltyRuns(int runs) {
    setState(() {
      score += runs;
      penaltyRuns += runs;
      currentOverRuns.add({
        'run': runs,
        'isBoundary': false,
        'type': 'P', // Indicate it's a penalty
      });
      crr = balls > 0 ? (score / balls) * 6 : 0.0;
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
  //add extras section in this code
  int extraWides=0;
  int extraNoBalls = 0;
  int extraLegByes = 0;
  int extraByes = 0;


  void updateExtras(int wides, int noBalls, int legByes, int byes) {
    setState(() {
      extraWides = wides;
      extraNoBalls = noBalls;
      extraLegByes = legByes;
      extraByes = byes;
    });
  }

  void _showExtrasDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Extras"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: [
                  Text("Wides: "),
                  Spacer(),
                  Text(extraWides.toString()),
                ],
              ),
              Row(
                children: [
                  Text("No Balls: "),
                  Spacer(),
                  Text(extraNoBalls.toString()),
                ],
              ),
              Row(
                children: [
                  Text("Leg Byes: "),
                  Spacer(),
                  Text(extraLegByes.toString()),
                ],
              ),
              Row(
                children: [
                  Text("Byes: "),
                  Spacer(),
                  Text(extraByes.toString()),
                ],
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  //undo action
  void undoLastAction() {
    if (scoreHistory.isNotEmpty && ballsHistory.isNotEmpty && wicketsHistory.isNotEmpty) {
      setState(() {
        score = scoreHistory.removeLast();
        balls = ballsHistory.removeLast();
        wickets = wicketsHistory.removeLast();

        batsman1Runs = batsman1RunsHistory.removeLast();
        batsman1Balls = batsman1BallsHistory.removeLast();
        batsman1Fours = batsman1FoursHistory.removeLast();
        batsman1Sixes = batsman1SixesHistory.removeLast();

        batsman2Runs = batsman2RunsHistory.removeLast();
        batsman2Balls = batsman2BallsHistory.removeLast();
        batsman2Fours = batsman2FoursHistory.removeLast();
        batsman2Sixes = batsman2SixesHistory.removeLast();

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
  void _showPartnershipDialog() {
    // Calculate the partnership runs as the sum of both batsmen's runs
    int currentPartnership = batsman1Runs + batsman2Runs;

    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Current Partnership'),
          content: Text(
            'Batsmen: $batsman1 & $batsman2\n'
                'Partnership Runs: $batsman1Runs + $batsman2Runs = $currentPartnership',
            style: TextStyle(fontSize: 16),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
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

  // Update overs logic to handle overs with fractional balls (e.g., 2.4 overs)
  void updateOvers() {
    if (balls >= 6) {
      overs++;
      balls = 0;
      _showNewBowlerDialog(); // Prompt for new bowler at end of over
      currentOverRuns.clear(); // Clear runs for the new over
    }
  }

// Modularize UI into smaller components for better readability
  Widget buildBatsmanStats() {
    return DataTable(
      columns: const [
        DataColumn(label: Text('Batsman')),
        DataColumn(label: Text('R')),
        DataColumn(label: Text('B')),
        DataColumn(label: Text('4s')),
        DataColumn(label: Text('6s')),
        DataColumn(label: Text('SR')),
      ],
      rows: [
        DataRow(cells: getBatsmanRowData(batsman1, batsman1Runs, batsman1Balls, batsman1Fours, batsman1Sixes)),
        DataRow(cells: getBatsmanRowData(batsman2, batsman2Runs, batsman2Balls, batsman2Fours, batsman2Sixes)),
      ],
    );
  }

  List<DataCell> getBatsmanRowData(String name, int runs, int balls, int fours, int sixes) {
    return [
      DataCell(Text(name)),
      DataCell(Text(runs.toString())),
      DataCell(Text(balls.toString())),
      DataCell(Text(fours.toString())),
      DataCell(Text(sixes.toString())),
      DataCell(Text(calculateStrikeRate(runs, balls).toStringAsFixed(2))),
    ];
  }


  double calculateStrikeRate(int runs, int ballsFaced) {
    return ballsFaced > 0 ? (runs / ballsFaced) * 100 : 0.0;
  }

  Future<void> showExtrasDialog() async {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Extras',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Checkbox(
                    value: isByes,
                    onChanged: (val) {
                      setState(() {
                        isByes = val ?? false;
                      });
                    },
                  ),
                  Text('Byes'),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value: isLegByes,
                    onChanged: (val) {
                      setState(() {
                        isLegByes = val ?? false;
                      });
                    },
                  ),
                  Text('Leg Byes'),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value: isWide,
                    onChanged: (val) {
                      setState(() {
                        isWide = val ?? false;
                        isNoBall = false; // Only one can be true at a time
                      });
                    },
                  ),
                  Text('Wide'),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value: isNoBall,
                    onChanged: (val) {
                      setState(() {
                        isNoBall = val ?? false;
                        isWide = false; // Only one can be true at a time
                      });
                    },
                  ),
                  Text('No Ball'),
                ],
              ),
              SizedBox(height: 16),
              // ElevatedButton(
              //   onPressed: undoLastExtras,
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: Colors.green, // Background color
              //   ),
              //   child: Text(
              //     '     Extras       ',
              //     style: TextStyle(color: Colors.white),
              //   ),
              // ),

            ],
          ),
        );
      },
    );
  }



  Future<void> _showPenaltyRunsDialog() async {
    TextEditingController penaltyRunsController = TextEditingController();

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add extra Runs'),
          content: TextField(
            controller: penaltyRunsController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: 'Enter extra runs'),
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
                int penaltyRuns = int.tryParse(penaltyRunsController.text) ?? 0;
                if (penaltyRuns > 0) {
                  addPenaltyRuns(penaltyRuns);
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }





  Future<void> _showNewBatsmanDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Wicket!'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              DropdownButton<String>(
                value: selectedWicketType,
                items: <String>[
                  'LBW',
                  'Stumping',
                  'Run Out (Striker)',
                  'Run Out (Non-Striker)',
                  'Catch Out',
                  'Wicket Stumping',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedWicketType = newValue!;
                  });
                },
              ),
              TextField(
                onChanged: (value) {
                  newBatsmanName = value;
                },
                decoration:
                InputDecoration(hintText: 'Enter new batsman\'s name'),
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
              child: Text('Add'),
              onPressed: () {
                if (newBatsmanName.isNotEmpty) {
                  setState(() {
                    // Update partnership runs
                    partnershipRuns += (currentStriker == batsman1)
                        ? batsman1Runs
                        : batsman2Runs;

                    switch (selectedWicketType) {
                      case 'LBW':
                      case 'Stumping':
                      case 'Run Out (Striker)':
                      case 'Catch Out':
                      case 'Wicket Stumping':
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
                        break;

                      case 'Run Out (Non-Striker)':
                        if (currentStriker == batsman1) {
                          batsman2 = newBatsmanName;
                          batsman2Runs = 0;
                          batsman2Balls = 0;
                          batsman2Fours = 0;
                          batsman2Sixes = 0;
                        } else {
                          batsman1 = newBatsmanName;
                          batsman1Runs = 0;
                          batsman1Balls = 0;
                          batsman1Fours = 0;
                          batsman1Sixes = 0;
                        }
                        break;
                    }

                    // Reset partnership runs after a wicket
                    partnershipRuns = 0;
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

      ),
      body: Padding(
        padding: const EdgeInsets.all(7.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${widget.battingTeam}, 1st inning',
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: 6),
              Row(
                children: [
                  Text(

                    '$score - $wickets ($overs - $balls)',
                    style: TextStyle(fontSize: 16),
                  ),
                  Spacer(),
                  Text(
                    'CRR: ${crr.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              SizedBox(height: 10),
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
                      DataCell(Text('$currentStriker 🏏')),
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
                    DataColumn(label: Text('Econ')),
                  ],
                  rows: [
                    // Add your bowler stats here (example)
                    DataRow(cells: [
                      DataCell(Text(currentBowler)),
                      DataCell(Text('$overs')),  // Overs bowled
                      DataCell(Text('0')),       // Maidens (assume 0 for now)
                      DataCell(Text('$score')),  // Runs given (use your score or another variable)
                      DataCell(Text('$wickets')), // Wickets taken
                      DataCell(Text(crr.toStringAsFixed(2))), // Economy rate
                    ]),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('This over:'),
                  SizedBox(height: 8),
                  Wrap(
                    spacing: 7.0,
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
              SizedBox(height: 5),
              Wrap(
                spacing: 6,
                runSpacing: 6,
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
                      Text('Wide',style: TextStyle(fontSize: 12),),
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
                      Text('No Ball',style: TextStyle(fontSize: 12),),
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
                      Text('Byes',style: TextStyle(fontSize: 12),),
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
                      Text('Leg Byes',style: TextStyle(fontSize: 12),),
                    ],
                  ),
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
                          }),
                      Text('Wicket',style: TextStyle(fontSize: 12),),
                    ],
                  ),
                  SizedBox(width: 6), // Add some spacing between elements
                  ElevatedButton(
                    onPressed: retireBatsman,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF3b3b6d), // Background color
                    ),
                    child: Text(
                      '      Retire      ',
                      style: TextStyle(color: Colors.white,fontSize: 12),
                    ),
                  ),
                  SizedBox(width: 8), // Add some spacing between elements
                  ElevatedButton(
                    onPressed: swapBatsman,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF3b3b6d), // Background color
                    ),
                    child: Text(
                      'Swap Batsman',
                      style: TextStyle(color: Colors.white,fontSize: 12),
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
                              backgroundColor: const Color(0xFF3b3b6d), // Background color
                              padding: EdgeInsets.symmetric(
                                vertical: MediaQuery.of(context).size.height * 0.015,
                                horizontal: MediaQuery.of(context).size.width * 0.04,
                              ),
                            ),
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                // Adjust font size based on width constraint
                                double fontSize = constraints.maxWidth * 0.05; // Adjust this factor as needed
                                if (fontSize > 12) fontSize = 12; // Max font size to prevent it from being too large
                                if (fontSize < 8) fontSize = 11; // Min font size to ensure readability

                                return Text(
                                  '      Undo      ',
                                  style: TextStyle(color: Colors.white, fontSize: fontSize),
                                );
                              },
                            ),
                          ),

                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: _showPartnershipDialog,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF3b3b6d), // Background color
                              padding: EdgeInsets.symmetric(
                                vertical: MediaQuery.of(context).size.height * 0.015,
                                horizontal: MediaQuery.of(context).size.width * 0.04,
                              ),
                            ),
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                // Adjust font size based on width constraint
                                double fontSize = constraints.maxWidth * 0.05; // Adjust this factor as needed
                                if (fontSize > 12) fontSize = 12; // Max font size to prevent it from being too large
                                if (fontSize < 8) fontSize = 11; // Min font size to ensure readability

                                return Text(
                                  'Partnership',
                                  style: TextStyle(color: Colors.white, fontSize: fontSize),
                                );
                              },
                            ),
                          ),

                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: _showExtrasDialog,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF3b3b6d), // Background color
                              padding: EdgeInsets.symmetric(
                                vertical: MediaQuery.of(context).size.height * 0.015,
                                horizontal: MediaQuery.of(context).size.width * 0.04,
                              ),
                            ),
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                // Adjust font size based on width constraint
                                double fontSize = constraints.maxWidth * 0.05; // Adjust this factor as needed
                                if (fontSize > 12) fontSize = 12; // Max font size to prevent it from being too large
                                if (fontSize < 8) fontSize = 11; // Min font size to ensure readability

                                return Text(
                                  '     Extras      ',
                                  style: TextStyle(color: Colors.white, fontSize: fontSize),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 7, // 70% of the width
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        double buttonWidth = (constraints.maxWidth - 48) / 4; // Calculate button width based on available space
                        double buttonHeight = buttonWidth * 1; // Adjust height relative to width, change as needed

                        return Container(
                          padding: const EdgeInsets.all(5.0), // Optional padding for buttons
                          child: Wrap(
                            spacing: 1,
                            runSpacing: 4,
                            alignment: WrapAlignment.center,
                            children: List.generate(7, (index) {
                              int buttonNumber = index; // Start from 0 instead of 1
                              return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  side: BorderSide(color: Color(0xFF3b3b6d), width: 1), // Border color and width
                                  minimumSize: Size(buttonWidth, buttonHeight), // Responsive size for buttons
                                ),
                                onPressed: () => updateScore(buttonNumber),
                                child: Text(buttonNumber.toString()),
                              );

                            })
                              ..add(
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    side: BorderSide(color: Color(0xFF3b3b6d), width: 2), // Border color and width
                                    minimumSize: Size(buttonWidth, buttonHeight), // Responsive size for buttons
                                  ),
                                  onPressed: _showPenaltyRunsDialog, // Open penalty runs dialog
                                  child: Text('More'),
                                ),
                              ),
                          ),
                        );
                      },
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

