import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../hold_models/items/team_data.dart';
class CreateTeamScreen extends StatefulWidget {
  @override
  State<CreateTeamScreen> createState() => _CreateTeamScreenState();
}

class _CreateTeamScreenState extends State<CreateTeamScreen> {
  final _teamNameController = TextEditingController();
  final _teamNicknameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 130,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/bg.jpg"),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.02, vertical: screenHeight * 0.02),
                child:
                IconButton(
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
                padding: const EdgeInsets.only(left: 18, top: 80),
                child: Text(
                  "Create Your Team",
                  style: TextStyle(
                    fontSize: screenWidth <= 750 ? screenWidth * 0.06 : 44, // adjust font size based on screen width
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

            ],
          ),
          Form(
            key: _formKey,
            child: Container(
              margin: EdgeInsets.only(top: 40),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 25, right: 25, left: 25),
                    child: TextFormField(
                      controller: _teamNameController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: "Team Name  *",
                          labelStyle: TextStyle(
                            color: Color(0xFF3b3b6d),
                            wordSpacing: 3,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(31),
                            borderSide:
                            BorderSide(color: Color(0xFF3b3b6d), width: 2),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25, right: 25, left: 25),
                    child: TextFormField(
                      controller: _teamNicknameController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: "Nickname  *",
                          labelStyle: TextStyle(
                            color: Color(0xFF3b3b6d),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(31),
                            borderSide:
                            BorderSide(color: Color(0xFF3b3b6d), width: 2),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18),
                    child: Container(
                      height: 60, // Reduced width
                      decoration: BoxDecoration(
                        color: Color(0xFF3b3b6d),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(25.0),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF3b3b6d).withOpacity(0.5), // Added opacity
                            blurRadius: 10.0, // Reduced blur radius
                            offset: Offset(0, 5), // Added offset
                          ),
                        ],
                        gradient: LinearGradient( // Added gradient
                          colors: [
                            Color(0xFF3b3b6d),
                            Color(0xFF2b2b4d),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                       child:
                       LayoutBuilder(
                         builder: (context, constraints) {
                           return ElevatedButton(
                             style: ElevatedButton.styleFrom(
                               backgroundColor: Color(0xFF3b3b6d),
                               foregroundColor: Colors.white,
                               elevation: 10,
                               shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(25.0),
                               ),
                               padding: EdgeInsets.all(15),
                               minimumSize: Size(constraints.maxWidth * 0.9, 40),
                             ),
                             onPressed: () {
                               if (_formKey.currentState!.validate()) {
                                 final teamId = Uuid().v4();
                                 final teamItem = TeamData(
                                   teamId: teamId,
                                   teamProfileUrl: "assets/images/default.jpg",
                                   teamName: _teamNameController.text,
                                   teamNickName: _teamNicknameController.text,
                                   batters: [],
                                   bowlers: [],
                                   allRounders: [],
                                 );

                                 Navigator.pop(context, teamItem);

                                 ScaffoldMessenger.of(context).showSnackBar(
                                   const SnackBar(content: Text('Processing Data')),
                                 );
                               }

                             },
                             child: Text(
                               'Save Team',
                               style: TextStyle(
                                 fontFamily: "Netflix",
                                 fontWeight: FontWeight.w600,
                                 fontSize: 18,
                                 letterSpacing: 0.2,
                               ),
                             ),
                           );
                         },
                       )
                    ),
                  ),



                ],
              ),
            ),
          ),
        ],
      )


    );
  }
}
