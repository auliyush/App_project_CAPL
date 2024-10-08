import 'package:flutter/material.dart';
import 'package:merge_capl/amit/startmatch.dart';

import '../Login.dart';

class CreateMatch extends StatefulWidget {
  @override
  _CreateMatchState createState() => _CreateMatchState();
}

class _CreateMatchState extends State<CreateMatch> {
  final hostController = TextEditingController();
  final visitorController = TextEditingController();
  final tossWinnerController = TextEditingController();
  final selectedByTossWinner = TextEditingController();

  String? _tossWinner;
  String? _selectedByTossWinner;
  DateTime? matchDate;
  TimeOfDay? matchTime;

  final _formKey = GlobalKey<FormState>();
  void _validateAndProceed() {
    if (hostController.text.isEmpty ||
        visitorController.text.isEmpty ||
        tossWinnerController.text.isEmpty ||
        selectedByTossWinner.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Incomplete Information'),
            content: Text('Please fill in all the fields to proceed.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
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
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 100,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/images/bg.jpg"),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 15,
                    left: 0,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.02,
                          vertical: screenHeight * 0.02),
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 30,
                    child: Text(
                      'Create Match',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Teams',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: hostController,
                      decoration: InputDecoration(
                        labelText: 'Host Team',
                        labelStyle: TextStyle(color: Colors.green),
                        filled: true,
                        fillColor: Colors.green.withOpacity(0.1),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: Colors.green, width: 2),
                        ),
                        prefixIcon: Icon(Icons.home, color: Colors.green),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the host team';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: visitorController,
                      decoration: InputDecoration(
                        labelText: 'Visitor Team',
                        labelStyle: TextStyle(color: Colors.blue),
                        filled: true,
                        fillColor: Colors.blue.withOpacity(0.1),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                        ),
                        prefixIcon: Icon(Icons.group, color: Colors.blue),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the visitor team';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    const Text(
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
                            title: const Text('Host Team'),
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
                            title: const Text('Visitor Team'),
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
                    const Text(
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
                            title: const Text('Bat'),
                            value: 'Bat',
                            groupValue: _selectedByTossWinner,
                            activeColor: Colors.green,
                            onChanged: (value) {
                              setState(() {
                                _selectedByTossWinner = value as String?;
                                selectedByTossWinner.text =
                                _selectedByTossWinner!;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile(
                            title: const Text('Bowl'),
                            value: 'Bowl',
                            groupValue: _selectedByTossWinner,
                            activeColor: Colors.green,
                            onChanged: (value) {
                              setState(() {
                                _selectedByTossWinner = value as String?;
                                selectedByTossWinner.text =
                                _selectedByTossWinner!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Overs?',
                        labelStyle: TextStyle(
                            color: Colors.green,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      keyboardType: TextInputType.number,
                      style: const TextStyle(color: Colors.black),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the number of overs';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Match Date and Time',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    ),
                    const SizedBox(height: 10),
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
                              backgroundColor: Color(0xFF3b3b6d),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 5,
                              padding: EdgeInsets.symmetric(vertical: 15),
                            ),
                            child: Text(
                              matchDate != null
                                  ? '${matchDate!.day}/${matchDate!.month}/${matchDate!.year}'
                                  : 'Select Date',
                              style: const TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
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
                              backgroundColor: Color(0xFF3b3b6d),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 5,
                              padding: EdgeInsets.symmetric(vertical: 15),
                            ),
                            child: Text(
                              matchTime != null
                                  ? '${matchTime!.format(context)}'
                                  : 'Select Time',
                              style: const TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: _validateAndProceed,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF3b3b6d),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 5,
                            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                          ),
                          child: Text(
                            'Start match',
                            style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    hostController.dispose();
    visitorController.dispose();
    tossWinnerController.dispose();
    selectedByTossWinner.dispose();
    super.dispose();
  }
}
