import 'package:flutter/material.dart';
import 'package:merge_capl/teams/create_team_screen.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class Tournament extends StatefulWidget {
  const Tournament({Key? key}) : super(key: key);

  @override
  State<Tournament> createState() => _TournamentState();
}

class _TournamentState extends State<Tournament> {
  final _formKey = GlobalKey<FormState>();
  final _tournamentNameController = TextEditingController();
  final _stadiumNameController = TextEditingController();
  final _stadiumAddressController = TextEditingController();
  final _adminNameController = TextEditingController();
  final _numberOfTeamsController = TextEditingController();

  DateTime? _tournamentDate;
  TimeOfDay? _tournamentTime;

  List<String> _teams = ['Team 1', 'Team 2', 'Team 3' , 'Team 4', 'Team 5', 'Team 6' , 'Team 7', 'Team 8', 'Team 9' , ];
  List<String> _selectedTeams = [];

  @override
  void dispose() {
    _tournamentNameController.dispose();
    _stadiumNameController.dispose();
    _stadiumAddressController.dispose();
    _adminNameController.dispose();
    _numberOfTeamsController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _tournamentDate) {
      setState(() {
        _tournamentDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _tournamentTime) {
      setState(() {
        _tournamentTime = picked;
      });
    }
  }

  InputDecoration _inputDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: const TextStyle(color: Colors.grey),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: Colors.blue, width: 2.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: Colors.grey, width: 1.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 600;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: isSmallScreen ? 110 : 130,
              child: Stack(
                children: [
                  Container(
                    height: isSmallScreen ? 110 : 130,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/bg.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
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
                  Padding(
                    padding: EdgeInsets.only(left: 18, top: isSmallScreen ? 60 : 80),
                    child: Text(
                      "Create Your Tournament",
                      style: TextStyle(
                        fontSize: isSmallScreen ? screenWidth * 0.05 : 44,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 16 : 50),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 20),
                    _buildTextField(_adminNameController, 'Admin Name *'),
                    const SizedBox(height: 20),
                    _buildTextField(_tournamentNameController, 'Tournament / Series Name *'),
                    const SizedBox(height: 20),
                    _buildTextField(_stadiumNameController, 'Stadium Name *'),
                    const SizedBox(height: 20),
                    _buildTextField(_stadiumAddressController, 'Stadium Address *'),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 140,
                          child: TextFormField(
                            controller: _numberOfTeamsController,
                            keyboardType: TextInputType.number,
                            decoration: _inputDecoration('No. of Teams *'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the number of teams';
                              }
                              if (int.tryParse(value) == null) {
                                return 'Please enter a valid number';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => CreateTeamScreen()),
                              );
                            },
                            child: const Text('Create your teams', style: TextStyle(color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF3b3b6d),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),

                    const SizedBox(height: 20),
                    MultiSelectDialogField(
                      items: _teams.map((team) => MultiSelectItem(team, team)).toList(),
                      title: const Text("Select Teams"),
                      selectedColor: Colors.blue,
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        border: Border.all(
                          color: Colors.blue,
                          width: 2,
                        ),
                      ),
                      buttonIcon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.blue,
                      ),
                      buttonText: const Text(
                        "Select Teams",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                        ),
                      ),
                      onConfirm: (results) {
                        setState(() {
                          _selectedTeams = results.cast<String>();
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Tournament Date and Time',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => _selectDate(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF3b3b6d),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: Text(
                              _tournamentDate != null
                                  ? '${_tournamentDate!.day}/${_tournamentDate!.month}/${_tournamentDate!.year}'
                                  : 'Select Date *',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => _selectTime(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF3b3b6d),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: Text(
                              _tournamentTime != null
                                  ? _tournamentTime!.format(context)
                                  : 'Select Time *',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Transform(
                        transform: Matrix4.skewX(-0.2),
                        child: ElevatedButton(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15 , right: 15),
                            child: Text(
                              'Submit',
                              style: TextStyle(
                                fontFamily: "Netflix",
                                fontWeight: FontWeight.w600,
                                fontSize: 22,
                                letterSpacing: 0.2,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade900,
                            elevation: 15,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: isSmallScreen ? 14 : 18,
                                horizontal: isSmallScreen ? 30 : 40),
                            shadowColor: Colors.blue.shade900,
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if (_selectedTeams.length != int.parse(_numberOfTeamsController.text)) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'Please select exactly ${_numberOfTeamsController.text} teams'),
                                  ),
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Tournament(),
                                  ),
                                );
                              }
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        decoration: _inputDecoration(labelText),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a value';
          }
          return null;
        },
      ),
    );
  }
}
