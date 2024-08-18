import 'dart:io';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:image_picker/image_picker.dart';

import '../hold_models/items/player_data.dart';
import '../hold_models/items/team_data.dart';

class BowlerScreen extends StatefulWidget {
  final TeamData teamData;

  const BowlerScreen({super.key, required this.teamData});

  @override
  State<BowlerScreen> createState() => _BowlerScreenState();
}

class _BowlerScreenState extends State<BowlerScreen> {
  String type = "Spinner";
  final _nameController = TextEditingController();
  final _nicknameController = TextEditingController();

  XFile? imageFile;
  final ImagePicker imagePicker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();

  void takePhoto(ImageSource source) async {
    final pickedFile = await imagePicker.pickImage(source: source);
    setState(() {
      imageFile = pickedFile;
    });
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
                    "Add Bowlers",
                    style: TextStyle(
                      fontSize: screenWidth <= 750 ? screenWidth * 0.06 : 44, // adjust font size based on screen width
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

              ],
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Center(
                      child: Container(
                        height: 120,
                        width: 120,
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 60,
                              backgroundImage: imageFile == null
                                  ? AssetImage("assets/images/default.jpg")
                                  : FileImage(File(imageFile!.path)) as ImageProvider,
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
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 25, right: 25, left: 25),
                          child: TextFormField(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            controller: _nameController,
                            decoration: InputDecoration(
                              labelText: "Name *",
                              labelStyle: TextStyle(
                                color: Color(0xFF3b3b6d),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(31),
                                borderSide: BorderSide(color: Color(0xFF3b3b6d),
                                    width: 2),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 25, right: 25, left: 25),
                          child: TextFormField(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            controller: _nicknameController,
                            decoration: InputDecoration(
                              labelText: "Nickname *",
                              labelStyle: TextStyle(
                                color: Color(0xFF3b3b6d),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(31),
                                borderSide: BorderSide(color: Color(0xFF3b3b6d),
                                    width: 2),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 25, right: 25, left: 25),
                          child: TextFormField(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                              RegExp regExp = RegExp(pattern);
                              if (value!.isEmpty) {
                                return 'Please enter mobile number';
                              } else if (!regExp.hasMatch(value)) {
                                return 'Please enter valid mobile number';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: "Phone *",
                              labelStyle: TextStyle(
                                color: Color(0xFF3b3b6d),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(31),
                                borderSide: BorderSide(color: Color(0xFF3b3b6d),
                                    width: 2),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 25, right: 25, left: 25),
                          child: TextFormField(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              } else if (!EmailValidator.validate(value)) {
                                return "Invalid email";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: "Email *",
                              labelStyle: TextStyle(
                                color: Color(0xFF3b3b6d),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(31),
                                borderSide: BorderSide(color: Color(0xFF3b3b6d),
                                    width: 2),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 25, right: 25, left: 25),
                          child: TextFormField(
                            maxLines: 4,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: "Address *",
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(31),
                                borderSide: BorderSide(color: Color(0xFF3b3b6d),
                                    width: 2),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15,),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('Type:',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              Row(
                                children: [
                                  Theme(
                                    data: Theme.of(context).copyWith(
                                      radioTheme: RadioThemeData(
                                        fillColor: MaterialStateProperty.all(
                                            Colors.orange
                                                .shade900), // color for selected radio button
                                      ),
                                    ),
                                    child: Radio(
                                      value: 'Spinner',
                                      groupValue: type,
                                      onChanged: (value) {
                                        setState(() {
                                          type = value as String;
                                        });
                                      },
                                    ),
                                  ),

                                  Text('Spinner'),
                                ],
                              ), Row(
                                children: [
                                  Theme(
                                    data: Theme.of(context).copyWith(
                                      radioTheme: RadioThemeData(
                                        fillColor: MaterialStateProperty.all(
                                            Colors.orange
                                                .shade900), // color for selected radio button
                                      ),
                                    ),
                                    child: Radio(
                                      value: 'Pace',
                                      groupValue: type,
                                      onChanged: (value) {
                                        setState(() {
                                          type = value as String;
                                        });
                                      },
                                    ),
                                  ),
                                  Text('Pace'),
                                ],
                              ),


                            ],
                          ),
                        ),
                        SizedBox(height: 15),

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
                                      final playerList = PlayerData(
                                          playerPhotoUrl: "assets/images/default.jpg",
                                          playerName: _nameController.text,
                                          playerNickName: _nicknameController.text
                                      );
                                      Navigator.pop(context,playerList);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Data Saved!')),
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

                ],
              ),
            ),
          ],
        ),
      )


    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100,
      width: MediaQuery
          .of(context)
          .size
          .width,
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
