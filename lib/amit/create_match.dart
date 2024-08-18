import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:merge_capl/amit/startmatch.dart';

class CreateMatch extends StatefulWidget {
  @override
  _CreateMatchState createState() => _CreateMatchState();
}

class _CreateMatchState extends State<CreateMatch> {
  final hostController = TextEditingController();
  final visitorController = TextEditingController();
  final battingController = TextEditingController();
  final tossWinnerController = TextEditingController();
  final selectedByTossWinner = TextEditingController();

  String? _tossWinner;
  String? _selectedByTossWinner;
  String tossWinner = 'Host Team';
  String optedFor = 'Bat';
  DateTime? matchDate;
  TimeOfDay? matchTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF3b3b6d),
        title: Text(
          'Create Team',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Navigator.pop(context);
          },
        ),
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.notifications, color: Colors.white),
        //     onPressed: () {},
        //   ),
        //   IconButton(
        //     icon: Icon(Icons.settings, color: Colors.white),
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
                'Teams',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
              TextField(
                controller: hostController,
                decoration: InputDecoration(
                  labelText: 'Host Team',
                ),
              ),
              TextField(
                controller: visitorController,
                decoration: InputDecoration(
                  labelText: 'Visitor Team',
                ),
              ),
              SizedBox(height: 20),


              Text(
                'Toss won by?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile(
                      title: Text('Host Team'),
                      value: 'Host Team',
                      groupValue: _tossWinner,
                      activeColor: Colors.green,
                      onChanged: (value) {
                        setState(() {
                          _tossWinner = value as String?;
                          tossWinnerController.text = _tossWinner!;


                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile(
                      title: Text('Visitor Team'),
                      value: 'Visitor Team',
                      groupValue: _tossWinner,
                      activeColor: Colors.green,
                      onChanged: (value) {
                        setState(() {
                          _tossWinner = value as String?;
                          tossWinnerController.text = _tossWinner!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Text(
                'Opted to?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile(
                      title: Text('Bat'),
                      value: 'Bat',
                      groupValue: _selectedByTossWinner,
                      activeColor: Colors.green,
                      onChanged: (value) {
                        setState(() {
                          _selectedByTossWinner = value as String?;
                          selectedByTossWinner.text = _selectedByTossWinner!;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile(
                      title: Text('Bowl'),
                      value: 'Bowl',
                      groupValue: _selectedByTossWinner,
                      activeColor: Colors.green,
                      onChanged: (value) {
                        setState(() {
                          _selectedByTossWinner = value as String?;
                          selectedByTossWinner.text = _selectedByTossWinner!;
                        });
                      },
                    ),
                  ),
                ],
              ),




              TextField(
                decoration: InputDecoration(
                  labelText: 'Overs?',
                  labelStyle: TextStyle(
                      color: Colors.green,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                keyboardType: TextInputType.number,
                style: TextStyle(
                    color: Colors.black), // Sets the text color of the input
              ),
              SizedBox(height: 20),
              Text(
                'Match Date and Time',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        final pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            matchDate = pickedDate;
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      child: Text(
                        matchDate != null
                            ? '${matchDate!.day}/${matchDate!.month}/${matchDate!.year}'
                            : 'Select Date',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        final pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (pickedTime != null) {
                          setState(() {
                            matchTime = pickedTime;
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      child: Text(
                        matchTime != null
                            ? '${matchTime!.format(context)}'
                            : 'Select Time',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 22),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // TextButton(
                  //   onPressed: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(builder: (context) => MatchSettingsPage()),
                  //     );
                  //   },
                  //   child: Text('Advanced settings'),
                  // ),battingTeam: '',
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(

                            builder: (context) => SelectOpeningPlayersPage(
                              battingTeam: selectedByTossWinner.text == 'Bat'
                                  ? tossWinnerController.text == 'Host Team'
                                  ? hostController.text
                                  : visitorController.text
                                  : tossWinnerController.text == 'Host Team'
                                  ? visitorController.text
                                  : hostController.text,
                            )),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                      Colors.orange[900], // Sets the background color
                    ),
                    child: Text(
                      'Start match',
                      style: TextStyle(fontSize: 20, color: Colors.white),
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