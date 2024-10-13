import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:merge_capl/integration/api/api_services.dart';
import 'dart:html' as html;
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';

import 'package:merge_capl/adminScreens/teamScreens/team_screen.dart';

import 'package:image_picker_web/image_picker_web.dart';

import '../../integration/api/RemoveBgApi.dart';


class CreateTeamScreen extends StatefulWidget {
  @override
  State<CreateTeamScreen> createState() => _CreateTeamScreenState();
}

class _CreateTeamScreenState extends State<CreateTeamScreen> {
  final _teamNameController = TextEditingController();
  final _teamNicknameController = TextEditingController();
  File? _imageFile;
  Uint8List? _webImage;
  String? _uploadedImageUrl;
  final ImagePicker _mobileImagePicker = ImagePicker();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  RemoveBgApi remove = RemoveBgApi();

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
                            backgroundImage: _webImage != null // For web
                                ? MemoryImage(_webImage!)
                                : _imageFile != null // For mobile
                                ? FileImage(_imageFile!)
                                : (_uploadedImageUrl != null
                                ? NetworkImage(_uploadedImageUrl!) // Show uploaded image
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
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 25, right: 25, left: 25),
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
                    padding:
                        const EdgeInsets.only(top: 25, right: 25, left: 25),
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
                                minimumSize:
                                    Size(constraints.maxWidth * 0.9, 40),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  // Upload the image to Cloudinary
                                  String? uploadedUrl;
                                  if (kIsWeb && _webImage != null) {
                                    final blob = html.Blob([_webImage!], 'image/jpeg');
                                    final file = html.File([blob], 'temp_image.jpg', {'type': 'image/jpeg'});
                                    await _uploadWebImageToCloudinaryWeb(file);
                                  } else if (_imageFile != null) {
                                    await _uploadImageToCloudinaryMob(_imageFile! as XFile);
                                  }
                                    // Create the team using the uploaded image URL
                                    ApiServices service = ApiServices();
                                    service.createTeam(
                                      _teamNameController.text,
                                      _teamNicknameController.text,
                                      _uploadedImageUrl!,
                                      context,
                                    );

                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TeamScreen()));
                                  } else {
                                    // Handle image upload failure
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Image upload failed. Please try again.')),
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