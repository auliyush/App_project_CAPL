import 'package:flutter/material.dart';

class MatchScoreBoardPage extends StatefulWidget {
  final String batsman1;
  final String batsman2;
  final String bowler;
  final String battingTeam;

  const MatchScoreBoardPage({super.key, required this.batsman1, required this.batsman2, required this.bowler, required this.battingTeam});

  @override
  State<MatchScoreBoardPage> createState() => _MatchScoreBoardPageState();
}

class _MatchScoreBoardPageState extends State<MatchScoreBoardPage> {

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


 bool _isSelected = false;
  bool _isWide = false;
  bool _isNoBall = false;
  bool _isByes = false;
  bool _isLegByes = false;
  bool _isWicket = false;

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
      if (_isWide || _isNoBall || _isByes || _isLegByes) {
        int extraRuns = 0;
        if (_isWide) {
          extraRuns = extraWides;
        } else if (_isNoBall) {
          extraRuns = extraNoBalls;
        } else if (_isByes) {
          extraRuns = extraByes;
        } else if (_isLegByes) {
          extraRuns = extraLegByes;
        }

        score += extraRuns;
        currentOverRuns.add({
          'run': extraRuns,
          'isBoundary': false,
          'type': _isWide ? 'W' : _isNoBall ? 'NB' : _isByes ? 'B' : 'LB',
        });

        _isWide = false;
        _isNoBall = false;
        _isByes = false;
        _isLegByes = false;
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
      _isByes = false;
      _isLegByes = false;
      _isWicket = false;

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
      // Record the current state before making changes
      recordCurrentState1();

      // Update state for wicket
      wickets++;
      balls++; // Increment balls count when a wicket occurs
      currentOverRuns.add({
        'run': 0,
        'isBoundary': false,
        'type': 'W', // Indicate it's a wicket
      });

      // Update overs if needed
      updateOvers();

      // Ensure the wicket is reflected in the UI
      hasActionPerformed = true; // Mark that an action has been performed
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

  void recordCurrentState1() {
    // Record all necessary state variables to their respective history lists
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
  }

  bool hasActionPerformed = false;

  void performSomeAction() {
    recordCurrentState1();
    score += 1;             // Update the score
    balls += 1;             // Update the number of balls

    setState(() {
      hasActionPerformed = true;  // Mark the action as performed
    });
  }

  void undoLastAction() {
    if (scoreHistory.isNotEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Confirm Undo"),
            content: Text("Are you sure you want to undo the last action?"),
            actions: [
              TextButton(
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
              TextButton(
                child: Text("Undo"),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog

                  setState(() {
                    // Restore the previous state from history (undo the last ball)
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
                      currentOverRuns.removeLast();
                    }

                    crr = balls > 0 ? (score / (balls / 6)) : 0.0;

                    // Clear the history to prevent undoing further
                    scoreHistory.clear();
                    ballsHistory.clear();
                    wicketsHistory.clear();

                    batsman1RunsHistory.clear();
                    batsman1BallsHistory.clear();
                    batsman1FoursHistory.clear();
                    batsman1SixesHistory.clear();

                    batsman2RunsHistory.clear();
                    batsman2BallsHistory.clear();
                    batsman2FoursHistory.clear();
                    batsman2SixesHistory.clear();

                    hasActionPerformed = false;  // Allow a new action to be performed
                  });
                },
              ),
            ],
          );
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("No actions to undo.")),
      );
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
                    value: _isByes,
                    onChanged: (val) {
                      setState(() {
                        _isByes = val ?? false;
                      });
                    },
                  ),
                  Text('Byes'),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value: _isLegByes,
                    onChanged: (val) {
                      setState(() {
                        _isLegByes = val ?? false;
                      });
                    },
                  ),
                  Text('Leg Byes'),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value: _isWide,
                    onChanged: (val) {
                      setState(() {
                        _isWide = val ?? false;
                        _isNoBall = false; // Only one can be true at a time
                      });
                    },
                  ),
                  Text('Wide'),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value: _isNoBall,
                    onChanged: (val) {
                      setState(() {
                        _isNoBall = val ?? false;
                        _isWide = false; // Only one can be true at a time
                      });
                    },
                  ),
                  Text('No Ball'),
                ],
              ),
              SizedBox(height: 16),
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


  final _formKey = GlobalKey<FormState>();
  final jerseyController = TextEditingController();
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
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildJerseyNumberField(),
                    _buildBatsmanNameField(),
                  ],
                ),
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text(
                'Add',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _addNewBatsman();
                  _isWicket  = false;
                }
              },
            ),

            ElevatedButton(
              child: Text(
                'Cancel',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {

                _isWicket  = false;
                Navigator.pop(context);

              },
            ),
          ],
        );
      },
    );
  }

  // this is text-field of jersey
  Widget _buildJerseyNumberField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: jerseyController,
      validator: _validateJerseyNumber,
      decoration: InputDecoration(
        hintText: "Enter new player jersey number",
        errorStyle: TextStyle(fontSize: 12),
      ),
    );
  }

  // this is text-field of add new batsman
  Widget _buildBatsmanNameField() {
    return TextFormField(
      validator: _validateBatsmanName,
      onChanged: (value) {
        newBatsmanName = value;
      },
      decoration: InputDecoration(
        hintText: 'Enter new batsman\'s name',
        errorStyle: TextStyle(fontSize: 12),
      ),
    );
  }

  // both are validator
  String? _validateBatsmanName(String? value) {
    if (value == null || value.length < 4) {
      return "Enter at least 4 characters";
    }
    return null;
  }
  String? _validateJerseyNumber(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter a jersey number";
    }
    if (int.tryParse(value) == null) {
      return "Please enter a valid number";
    }
    return null;
  }

  void _addNewBatsman() {
    setState(() {
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
    Navigator.of(context).pop();
  }


  void _showNewBowlerDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'New Bowler',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          content: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter bowler\'s name';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        currentBowler = value; // Update the new bowler's name
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter new bowler\'s name',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                  ),
                  SizedBox(height: 16), // Add some space between the text field and buttons
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.grey),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Add'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade900,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Perform your logic to add the new bowler here
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
              Center(
                child: Text(
                  '${widget.battingTeam}, 1st Inning',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
              SizedBox(height: 6),
              Row(
                children: [
                  Text(
                    '$score - $wickets ($overs - $balls)',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  Spacer(),
                  Text(
                    'CRR: ${crr.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black),
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
                // i changed it here that a checkbox is clicked at a time...
                spacing: 6,
                runSpacing: 6,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                        value: _isWide,
                        onChanged: (val) {
                          setState(() {
                            _isWide = val ?? false;
                            _isNoBall = false;
                            _isByes = false;
                            _isLegByes = false;
                          });
                        },
                      ),
                      Text('Wide', style: TextStyle(fontSize: 12),),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                        value: _isNoBall,
                        onChanged: (val) {
                          setState(() {
                            _isNoBall = val ?? false;
                            _isWide = false;
                            _isByes = false;
                            _isLegByes = false;
                          });
                        },
                      ),
                      Text('No Ball', style: TextStyle(fontSize: 12),),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                        value: _isByes,
                        onChanged: (val) {
                          setState(() {
                            _isByes = val ?? false;
                            _isWide = false;
                            _isNoBall = false;
                            _isLegByes = false;
                          });
                        },
                      ),
                      Text('Byes', style: TextStyle(fontSize: 12),),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                        value: _isLegByes,
                        onChanged: (val) {
                          setState(() {
                            _isLegByes = val ?? false;
                            _isWide = false;
                            _isNoBall = false;
                            _isByes = false;
                          });
                        },
                      ),
                      Text('Leg Byes', style: TextStyle(fontSize: 12),),
                    ],
                  ),

                  SizedBox(width: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Transform(
                        transform: Matrix4.skewX(-0.2),
                        child: ElevatedButton(
                          child: Text('Wicket', style: TextStyle(fontSize: 15),),
                          onPressed: () {
                            setState(() {
                              _isWicket = !_isWicket;
                              // todo i want once new batsman add then wicket will count
                              // todo wicket will able to create multiple times ????
                              if (_isWicket) {
                                _showNewBatsmanDialog();
                              }
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                            backgroundColor: _isWicket ? Colors.red : Color(0xFF3b3b6d),
                            foregroundColor: _isWicket ? Colors.white : Colors.white,
                          ),
                        ),
                      ),
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
                  )

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

