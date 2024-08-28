import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:typed_data';
import 'dart:convert';


import 'package:uuid/uuid.dart';
import '../hold_models/items/team_data.dart';

class CreateTeamScreen extends StatefulWidget {
  @override
  State<CreateTeamScreen> createState() => _CreateTeamScreenState();
}

class _CreateTeamScreenState extends State<CreateTeamScreen> {
  final _teamNameController = TextEditingController();
  final _teamNicknameController = TextEditingController();

  XFile? imageFile;

  final ImagePicker imagePicker = ImagePicker();

  String imagePath = "";
  String? base64String;

  // 11:47 --- 79

  final _formKey = GlobalKey<FormState>();

  void takePhoto(ImageSource source) async {
    final pickedFile = await imagePicker.pickImage(source: source);
    if (pickedFile != null) {
      String imagePath = pickedFile.path;

      List<int> imageByte = File(pickedFile.path).readAsBytesSync();
      base64String = base64Encode(imageByte);

      File file = File(imagePath);

      Uint8List imageBytes = await file.readAsBytes();

      base64String = base64.encode(imageBytes);

      setState(() {
        imageFile = pickedFile;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
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
                    padding: const EdgeInsets.only(left: 18, top: 80),
                    child: Text(
                      "Create Your Team",
                      style: TextStyle(
                        fontSize: screenWidth <= 750 ? screenWidth * 0.06 : 44,
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
                      Center(
                        child: Container(
                          height: 120,
                          width: 120,
                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius: 60,
                                backgroundImage: imageFile == null
                                    ? AssetImage("assets/images/default.jpg")
                                    : base64String != null
                                    ? MemoryImage(base64Decode(base64String!)) as ImageProvider
                                    : AssetImage("assets/images/default.jpg"),
                              ),
                              Positioned(
                                bottom: 10,
                                right: 15,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.orange.shade900,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: EdgeInsets.all(8),
                                  child: InkWell(
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (builder) => bottomSheet(),
                                      );
                                    },
                                    child: Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 15,),
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
                            height: 60,
                            decoration: BoxDecoration(
                              color: Color(0xFF3b3b6d),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(25.0),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFF3b3b6d).withOpacity(0.5),
                                  // Added opacity
                                  blurRadius: 10.0,
                                  // Reduced blur radius
                                  offset: Offset(0, 5), // Added offset
                                ),
                              ],
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFF3b3b6d),
                                  Color(0xFF2b2b4d),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                            child: LayoutBuilder(
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
                                      // ApiService obj = ApiService();
                                      //
                                      // obj.postApiCreateTeam(_teamNameController.text,
                                      //     _teamNicknameController.text, base64String, context);
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
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget bottomSheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          Text(
            "Profile Photo",
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  takePhoto(ImageSource.camera);
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.camera_alt_outlined),
                    ),
                    Text("Camera"),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  takePhoto(ImageSource.gallery);
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.image),
                    ),
                    Text("Gallery"),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }



}

