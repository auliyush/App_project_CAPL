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
  final _formKey = GlobalKey<FormState>();

  void _validateAndProceed() {
    if (strikerController.text.isEmpty ||
        nonStrikerController.text.isEmpty ||
        openingBowlerController.text.isEmpty) {
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
      // Navigate to the next page if all fields are filled
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
    }
  }
  bool _isHovered = false;

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
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 30,
                    child: Text(
                      'Select Opining Players',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: strikerController,
                      decoration: InputDecoration(
                        labelText: 'Striker',
                        labelStyle: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          letterSpacing: 0.5, // add some letter spacing for a more modern look
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 15.0,
                          horizontal: 15.0,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          gapPadding: 4, // add some gap padding to make the border more rounded
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blue,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          gapPadding: 4,
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        hoverColor: Colors.grey.shade100, // add a hover color to give a subtle effect
                      )
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: nonStrikerController,
                      decoration: InputDecoration(
                        labelText: 'Non-Striker',
                        labelStyle: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          letterSpacing: 0.5,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 15.0,
                          horizontal: 15.0,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          gapPadding: 4,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blue,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          gapPadding: 4,
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        hoverColor: Colors.grey.shade100,
                      )
                    ),
                    SizedBox(height:20),
                    TextField(
                      controller: openingBowlerController,
                      decoration: InputDecoration(
                        labelText: 'Opening-Bowler',
                        labelStyle: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          letterSpacing: 0.5,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 15.0,
                          horizontal: 15.0,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          gapPadding: 4,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blue,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          gapPadding: 4,
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        hoverColor: Colors.grey.shade100,
                      )
                    ),
                    SizedBox(height: 30),
                    MouseRegion(
                      cursor: SystemMouseCursors.click, // Change the cursor to a click cursor on hover
                      child: SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _validateAndProceed,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF3b3b6d), // Button background color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10), // Add rounded corners
                            ),
                            elevation: 5,
                            padding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 20,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Start Match',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18, // Increase font size
                                fontWeight: FontWeight.bold, // Make the text bold
                              ),
                            ),
                          ),
                        ),
                      ),

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
}
