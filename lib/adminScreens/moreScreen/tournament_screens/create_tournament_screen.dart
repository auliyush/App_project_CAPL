import 'package:flutter/material.dart';
import 'package:merge_capl/adminScreens/admin_bottom_nav.dart';
import 'package:merge_capl/adminScreens/moreScreen/tournament_screens/add_teams_tournament.dart';
import 'package:merge_capl/adminScreens/teamScreens/create_team_screen.dart';
import 'package:merge_capl/integration/api/tournament_api_service.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class CreateTournament extends StatefulWidget {
  const CreateTournament({Key? key}) : super(key: key);

  @override
  State<CreateTournament> createState() => _CreateTournamentState();
}

class _CreateTournamentState extends State<CreateTournament> {
  final _formKey = GlobalKey<FormState>();
  final _tournamentNameController = TextEditingController();
  final _stadiumNameController = TextEditingController();
  final _adminNameController = TextEditingController();
  final _numberOfTeamsController = TextEditingController();
  final stateController = TextEditingController();
  final cityController = TextEditingController();
  final pinCodeController = TextEditingController();

  DateTime? _tournamentStartDate;
  DateTime? _tournamentEndDate;

  List<String> _selectedTeams = [];

  @override
  void dispose() {
    _tournamentNameController.dispose();
    _stadiumNameController.dispose();
    _adminNameController.dispose();
    stateController.dispose();
    cityController.dispose();
    pinCodeController.dispose();
    _numberOfTeamsController.dispose();
    super.dispose();
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _tournamentStartDate) {
      setState(() {
        _tournamentStartDate = picked;
      });
    }
  }
  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _tournamentEndDate) {
      setState(() {
        _tournamentEndDate = picked;
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
    String? startDateString = _tournamentStartDate?.toIso8601String();
    String? endDateString = _tournamentEndDate?.toIso8601String();
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;
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
                    padding: EdgeInsets.only(
                        left: 18, top: isSmallScreen ? 60 : 80),
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
              padding: EdgeInsets.symmetric(
                  horizontal: isSmallScreen ? 16 : 50),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 20),
                    _buildTextField(_adminNameController, 'Admin Name *'),
                    const SizedBox(height: 20),
                    _buildTextField(_tournamentNameController,
                        'Tournament / Series Name *'),
                    const SizedBox(height: 20),
                    _buildTextField(_stadiumNameController, 'Stadium Name *'),
                    const SizedBox(height: 20),
                    _buildTextField(cityController, 'City *'),
                    const SizedBox(height: 20),
                    _buildTextField(stateController, ' State *'),
                    const SizedBox(height: 20),
                    _buildTextField(pinCodeController, 'Pin-Code *'),
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
                                MaterialPageRoute(
                                    builder: (context) => AddTeamsTournament()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF3b3b6d),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: const Text('Add Teams',
                                style: TextStyle(color: Colors.white)),
                          ),
                        )
                      ],
                    ),

                    const SizedBox(height: 20),
                    const Text(
                      'Tournament Date',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () => _selectStartDate(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF3b3b6d),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: Text(
                            _tournamentStartDate != null
                                ? '${_tournamentStartDate!
                                .day}/${_tournamentStartDate!
                                .month}/${_tournamentStartDate!.year}'
                                : 'Select Start Date *',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => _selectEndDate(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF3b3b6d),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: Text(
                            _tournamentEndDate != null
                                ? '${_tournamentEndDate!
                                .day}/${_tournamentEndDate!
                                .month}/${_tournamentEndDate!.year}'
                                : 'Select End Date *',
                            style: const TextStyle(color: Colors.white),
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
                            padding: const EdgeInsets.only(left: 15, right: 15),
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
                              // if (_selectedTeams.length !=
                              //     int.parse(_numberOfTeamsController.text)) {
                              //   ScaffoldMessenger.of(context).showSnackBar(
                              //     SnackBar(
                              //       content: Text(
                              //           'Please select exactly ${_numberOfTeamsController
                              //               .text} teams'),
                              //     ),
                              //   );
                              // } else {
                              //   /// here i have to call an api of create tournament
                                TournamentApiService service = TournamentApiService();
                                service.createTournament(
                                    _tournamentNameController.text,
                                    startDateString!,
                                    endDateString!,
                                    _stadiumNameController.text,
                                    '${cityController.text} ${stateController.text} ${pinCodeController.text} ',
                                    context);
                              // }
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
