import 'dart:io';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:image_picker/image_picker.dart';

import '../hold_models/items/player_data.dart';
import '../hold_models/items/team_data.dart';

class BatterScreen extends StatefulWidget {
  final TeamData teamData;
  const BatterScreen({super.key, required this.teamData});

  @override
  State<BatterScreen> createState() => _BatterScreenState();
}

class _BatterScreenState extends State<BatterScreen> {

  final _nameController = TextEditingController();
  final _nickNameController = TextEditingController();

  String type = "Left-Arm";

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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
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
          "Add Batter's",
          style: TextStyle(fontSize: 22, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                child: Container(
                  height: 120,
                  width: 120,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: imageFile == null
                            ? AssetImage("assets/images/bg.jpg")
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
            SizedBox(height: 30),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 25, right: 25, left: 25),
                    child: TextFormField(
                      controller: _nameController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Name *",
                        labelStyle: TextStyle(
                          color: Color(0xFF3b3b6d),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(31),
                          borderSide:
                              BorderSide(color: Color(0xFF3b3b6d), width: 2),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 25, right: 25, left: 25),
                    child: TextFormField(
                      controller: _nickNameController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Nickname *",
                        labelStyle: TextStyle(
                          color: Color(0xFF3b3b6d),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(31),
                          borderSide:
                              BorderSide(color: Color(0xFF3b3b6d), width: 2),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 25, right: 25, left: 25),
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
                          borderSide:
                              BorderSide(color: Color(0xFF3b3b6d), width: 2),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 25, right: 25, left: 25),
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
                          borderSide:
                              BorderSide(color: Color(0xFF3b3b6d), width: 2),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 25, right: 25, left: 25),
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
                          borderSide:
                              BorderSide(color: Color(0xFF3b3b6d), width: 2),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Type:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 16.0),
                      Theme(
                        data: Theme.of(context).copyWith(
                          radioTheme: RadioThemeData(
                            fillColor: MaterialStateProperty.all(Colors.orange
                                .shade900), // color for selected radio button
                          ),
                        ),
                        child: Radio(
                          value: 'Left-Arm',
                          groupValue: type,
                          onChanged: (value) {
                            setState(() {
                              type = value as String;
                            });
                          },
                        ),
                      ),
                      Text('Left-Arm'),
                      SizedBox(width: 16.0),
                      Theme(
                        data: Theme.of(context).copyWith(
                          radioTheme: RadioThemeData(
                            fillColor: MaterialStateProperty.all(Colors.orange
                                .shade900), // color for selected radio button
                          ),
                        ),
                        child: Radio(
                          value: 'Right-Arm',
                          groupValue: type,
                          onChanged: (value) {
                            setState(() {
                              type = value as String;
                            });
                          },
                        ),
                      ),
                      Text('Right-Arm'),
                    ],
                  ),
                  SizedBox(height: 45),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final playerLists = PlayerData(
                            playerPhotoUrl: "assets/images/default.jpg",
                            playerName: _nameController.text,
                            playerNickName: _nickNameController.text);

                        Navigator.pop(context, playerLists);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Data Saved!')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.orange[900],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 16),
                      textStyle: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                      elevation: 10,
                      shadowColor: Colors.orange.shade900,
                    ),
                    child: Text("Save"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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
