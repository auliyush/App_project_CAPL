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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color(0xFF3b3b6d),
        title: Text(
          "Create Your Team",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Form(
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
              ElevatedButton(
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
                        allRounders: []);

                    Navigator.pop(context, teamItem);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                  }
                },
                child: Text(
                  "Save",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    // text color
                    backgroundColor: Colors.orange[900],
                    // background color
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10), // rounded corners
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24, // horizontal padding
                      vertical: 16, // vertical padding
                    ),
                    textStyle: const TextStyle(
                      fontSize: 18, // font size
                      fontWeight: FontWeight.bold, // font weight
                    ),
                    elevation: 10,
                    shadowColor: Colors.orange.shade900),
              )
            ],
          ),
        ),
      ),
    );
  }
}
