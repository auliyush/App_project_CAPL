import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import 'dart:html' as html;
import 'package:http/http.dart' as http;
import 'package:email_validator/email_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_web/image_picker_web.dart';

import '../integration/api/player_list.dart';
import '../integration/api/player_more_screen.dart';


class AccountPage extends StatefulWidget {
  final String playerPhotoUrl;
  final String playerName;
  final String playerNickName;
  final String playerMobNumber;
  final String playerEmail;
  final String playerAddress;
  final String playerType;
  final String playerSubType;

  const AccountPage({
    Key? key,
    required this.playerPhotoUrl,
    required this.playerName,
    required this.playerNickName,
    required this.playerMobNumber,
    required this.playerEmail,
    required this.playerAddress,
    required this.playerType,
    required this.playerSubType,
  }) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {

  final _formKey = GlobalKey<FormState>();
  final playerPhotoUrlController = TextEditingController();
  final phoneController = TextEditingController();
  final _nameController = TextEditingController();
  final _nicknameController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _playerTypeController = TextEditingController();
  final _playerSubTypeController = TextEditingController();

  String? type;
  String? subtype;
  String? _uploadedImageUrl;

  File? _imageFile;
  Uint8List? _webImage;
  final ImagePicker _mobileImagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    playerPhotoUrlController.text = widget.playerPhotoUrl;
    _nameController.text = widget.playerName;
    _nicknameController.text = widget.playerNickName;
    phoneController.text = widget.playerMobNumber;
    _emailController.text = widget.playerEmail;
    _addressController.text = widget.playerAddress;
    type = widget.playerType;
    subtype = widget.playerSubType;
  }

  @override
  void dispose() {
    playerPhotoUrlController.dispose();
    _nameController.dispose();
    _nicknameController.dispose();
    phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _playerTypeController.dispose();
    _playerSubTypeController.dispose();
    super.dispose();
  }

  // done
  void _takePhoto(ImageSource source) async {
    if (kIsWeb) {
      final Uint8List? image = await ImagePickerWeb.getImageAsBytes();
      if (image != null) {
        setState(() {
          _webImage = image; // Update the local image
        });
      }
    } else {
      final XFile? pickedFile = await _mobileImagePicker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path); // Update the local image
        });
      }
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
                    "Accounts",
                    style: TextStyle(
                      fontSize: screenWidth <= 750 ? screenWidth * 0.06 : 44,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Container(
                  height: 120,
                  width: 120,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: _webImage != null // For web
                            ? MemoryImage(_webImage!)
                            : _imageFile != null // For mobile
                            ? FileImage(_imageFile!)
                            : (playerPhotoUrlController != null
                            ? NetworkImage(playerPhotoUrlController.text) // Show uploaded image
                            : AssetImage('assets/images/default.jpg') as ImageProvider),
                        backgroundColor: Colors.transparent,
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
                            child: const Icon(
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
                        labelStyle: const TextStyle(
                          color: Color(0xFF3b3b6d),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(31),
                          borderSide: const BorderSide(
                              color: Color(0xFF3b3b6d), width: 2),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(top: 25, right: 25, left: 25),
                    child: TextFormField(
                      controller: _nicknameController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Nickname *",
                        labelStyle: const TextStyle(
                          color: Color(0xFF3b3b6d),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(31),
                          borderSide: const BorderSide(
                              color: Color(0xFF3b3b6d), width: 2),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(top: 25, right: 25, left: 25),
                    child: TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
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
                        labelStyle: const TextStyle(
                          color: Color(0xFF3b3b6d),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(31),
                          borderSide: const BorderSide(
                              color: Color(0xFF3b3b6d), width: 2),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(top: 25, right: 25, left: 25),
                    child: TextFormField(
                      controller: _emailController,
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
                        labelStyle: const TextStyle(
                          color: Color(0xFF3b3b6d),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(31),
                          borderSide: const BorderSide(
                              color: Color(0xFF3b3b6d), width: 2),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(top: 25, right: 25, left: 25),
                    child: TextFormField(
                      controller: _addressController,
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
                          borderSide: const BorderSide(
                              color: Color(0xFF3b3b6d), width: 2),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Player Type',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Theme(
                              data: Theme.of(context).copyWith(
                                unselectedWidgetColor: Colors.orange.shade900,
                              ),
                              child: Radio(
                                activeColor: Colors.orange.shade900,
                                value: 'Batsman',
                                groupValue: type,
                                onChanged: (value) {
                                  setState(() {
                                    // if (type == null){
                                      type = value.toString();
                                    // }
                                    // else {
                                    //   type = widget.playerType;
                                    // }
                                    subtype ??= widget.playerSubType;
                                  });
                                },
                              ),
                            ),
                            const Text(
                              'Batsman',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Theme(
                              data: Theme.of(context).copyWith(
                                unselectedWidgetColor: Colors.orange.shade900,
                              ),
                              child: Radio(
                                activeColor: Colors.orange.shade900,
                                value: 'Bowler',
                                groupValue: type,  // if there is initillization is done of playerType and playerSubType then show that on screen selected
                                onChanged: (value) {
                                  setState(() {
                                    type = value.toString();
                                    subtype ??= widget.playerSubType;
                                  });
                                },
                              ),
                            ),
                            const Text(
                              'Bowler',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Theme(
                              data: Theme.of(context).copyWith(
                                unselectedWidgetColor: Colors.orange.shade900,
                              ),
                              child: Radio(
                                activeColor: Colors.orange.shade900,
                                value: 'Allrounder',
                                groupValue: type,
                                onChanged: (value) {
                                  setState(() {
                                    type = value.toString();
                                  });
                                },
                              ),
                            ),
                            const Text(
                              'Allrounder',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  if (type == 'Bowler') ...[
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // const Text(
                          //   'Bowler Type:',
                          //   style: TextStyle(
                          //       fontSize: 18,
                          //       fontWeight: FontWeight.bold),
                          // ),
                          Row(
                            children: [
                              Theme(
                                data: Theme.of(context).copyWith(
                                  unselectedWidgetColor: Colors.orange.shade900,
                                ),
                                child: Radio(
                                  activeColor: Colors.orange.shade900,
                                  value: 'Spinner',
                                  groupValue: subtype,
                                  onChanged: (value) {
                                    setState(() {
                                      subtype = value.toString();
                                    });
                                  },
                                ),
                              ),
                              const Text(
                                'Spinner',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Theme(
                                data: Theme.of(context).copyWith(
                                  unselectedWidgetColor: Colors.orange.shade900,
                                ),
                                child: Radio(
                                  activeColor: Colors.orange.shade900,
                                  value: 'Pace',
                                  groupValue: subtype,
                                  onChanged: (value) {
                                    setState(() {
                                      subtype = value.toString();
                                    });
                                  },
                                ),
                              ),
                              const Text(
                                'Pace',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ] else if (type == 'Batsman') ...[
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // const Text(
                          //   'Batsman Type:',
                          //   style: TextStyle(
                          //       fontSize: 18,
                          //       fontWeight: FontWeight.bold),
                          // ),
                          Row(
                            children: [
                              Theme(
                                data: Theme.of(context).copyWith(
                                  unselectedWidgetColor: Colors.orange.shade900,
                                ),
                                child: Radio(
                                  activeColor: Colors.orange.shade900,
                                  value: 'Left Arm',
                                  groupValue: subtype,
                                  onChanged: (value) {
                                    setState(() {
                                      subtype = value.toString();
                                    });
                                  },
                                ),
                              ),
                              const Text(
                                'Left Arm',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Theme(
                                data: Theme.of(context).copyWith(
                                  unselectedWidgetColor: Colors.orange.shade900,
                                ),
                                child: Radio(
                                  activeColor: Colors.orange.shade900,
                                  value: 'Right Arm',
                                  groupValue: subtype,
                                  onChanged: (value) {
                                    setState(() {
                                      subtype = value.toString();
                                    });
                                  },
                                ),
                              ),
                              const Text(
                                'Right Arm',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                  SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade900,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      onPressed: () async {
                        if (kIsWeb && _webImage != null) {
                          final blob = html.Blob([_webImage!], 'image/jpeg');
                          final file = html.File([blob], 'temp_image.jpg', {'type': 'image/jpeg'});
                          await _uploadWebImageToCloudinaryWeb(file);
                        } else if (_imageFile != null) {
                          await _uploadImageToCloudinaryMob(_imageFile! as XFile);
                        }
                        PlayerMoreAccount obj = PlayerMoreAccount();
                        obj.updatePlayerAccountApi(
                            _uploadedImageUrl != null ? _uploadedImageUrl! : widget.playerPhotoUrl,
                            _nameController.text,
                            _nicknameController.text,
                            phoneController.text,
                            _emailController.text,
                            _addressController.text,
                            type!,
                            subtype!,
                            context
                        );

                      },

                      child: const Padding(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          "Update",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
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
      height: 150,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Choose Profile Photo",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange.shade900,
                  foregroundColor: Colors.white,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  _takePhoto(ImageSource.camera);
                },
                child: Text("Camera"),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade900,
                  foregroundColor: Colors.white,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  _takePhoto(ImageSource.gallery);
                },
                child: Text("Gallery"),
              ),
            ],
          ),
        ],
      ),
    );
  }
  Future<void> _uploadWebImageToCloudinaryWeb(html.File imageFile) async {
    try {
      String cloudinaryUrl = 'https://api.cloudinary.com/v1_1/dxzkqjacj/image/upload';
      String uploadPreset = 'CrickAge';

      // Convert html.File to FormData for Dio
      final reader = html.FileReader();
      reader.readAsArrayBuffer(imageFile);
      await reader.onLoadEnd.first;

      FormData formData = FormData.fromMap({
        'file': MultipartFile.fromBytes(reader.result as List<int>, filename: imageFile.name, contentType: MediaType.parse('multipart/form-data')),
        'upload_preset': uploadPreset,
      });

      Response response = await Dio().post(cloudinaryUrl, data: formData);

      if (response.statusCode == 200) {
        setState(() {
          _uploadedImageUrl = response.data['secure_url'];
          print('Uploaded Image URL: $_uploadedImageUrl');
        });
      } else {
        print('Failed to upload image: ${response.statusMessage}');
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  Future<void> _uploadImageToCloudinaryMob(XFile imageFile) async {
    try {
      String cloudinaryUrl = 'https://api.cloudinary.com/v1_1/dxzkqjacj/image/upload';
      String uploadPreset = 'CrickAge';

      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(imageFile.path, contentType: MediaType.parse('multipart/form-data')),
        'upload_preset': uploadPreset,
      });

      Response response = await Dio().post(cloudinaryUrl, data: formData);

      if (response.statusCode == 200) {
        setState(() {
          _uploadedImageUrl = response.data['secure_url'];
          print(_uploadedImageUrl);
        });
      } else {
        print('Failed to upload image: ${response.statusMessage}');
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  }
}
