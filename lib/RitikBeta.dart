// import 'dart:io';
//
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:share_plus/share_plus.dart';
// import 'dart:typed_data';
// import 'dart:convert';
//
//
// class CreateTeamScreen extends StatefulWidget {
//   @override
//   State<CreateTeamScreen> createState() => _CreateTeamScreenState();
// }
//
// class _CreateTeamScreenState extends State<CreateTeamScreen> {
//
//   XFile? imageFile;
//
//   final ImagePicker imagePicker = ImagePicker();
//
//   String imagePath = "";
//   String? base64String;
//
//   // 11:47 --- 79
//
//   final _formKey = GlobalKey<FormState>();
//
//   void takePhoto(ImageSource imageSource) async {
//     final pickedFile = await ImagePicker().pickImage(source: imageSource);
//     if (pickedFile != null) {
//       File file = File(pickedFile.path);
//
//       Uint8List imageBytes = await file.readAsBytes();
//
//       String base64String = base64.encode(imageBytes);
//
//       print(base64String);
//
//       setState(() {
//         imageFile = pickedFile;
//       });
//     } else {
//       print('No image selected');
//     }
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
//     return Scaffold(
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               Stack(
//                 children: [
//                   Container(
//                     height: 130,
//                     decoration: const BoxDecoration(
//                       image: DecorationImage(
//                         fit: BoxFit.cover,
//                         image: AssetImage("assets/images/bg.jpg"),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(
//                         horizontal: screenWidth * 0.02,
//                         vertical: screenHeight * 0.02),
//                     child: IconButton(
//                       icon: const Icon(
//                         Icons.arrow_back_ios_new,
//                         color: Colors.white,
//                       ),
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//               Form(
//                 key: _formKey,
//                 child: Container(
//                   margin: EdgeInsets.only(top: 40),
//                   child: Column(
//                     children: [
//                       Center(
//                         child: Container(
//                           height: 120,
//                           width: 120,
//                           child: Stack(
//                             children: [
//                               CircleAvatar(
//                                 radius: 60,
//                                 backgroundImage: imageFile == null
//                                     ? AssetImage("assets/images/default.jpg")
//                                     : base64String != null
//                                     ? MemoryImage(base64Decode(base64String!)) as ImageProvider
//                                     : AssetImage("assets/images/default.jpg"),
//                               ),
//                               Positioned(
//                                 bottom: 10,
//                                 right: 15,
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                     color: Colors.orange.shade900,
//                                     borderRadius: BorderRadius.circular(20),
//                                   ),
//                                   padding: EdgeInsets.all(8),
//                                   child: InkWell(
//                                     onTap: () {
//                                       showModalBottomSheet(
//                                         context: context,
//                                         builder: (builder) => bottomSheet(),
//                                       );
//                                     },
//                                     child: Icon(
//                                       Icons.camera_alt,
//                                       color: Colors.white,
//                                       size: 20,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 15,),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 25, right: 25, left: 25),
//                         child: TextFormField(
//                           controller: _teamNameController,
//                           autovalidateMode: AutovalidateMode.onUserInteraction,
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter some text';
//                             }
//                             return null;
//                           },
//                           decoration: InputDecoration(
//                               labelText: "Team Name  *",
//                               labelStyle: TextStyle(
//                                 color: Color(0xFF3b3b6d),
//                                 wordSpacing: 3,
//                               ),
//                               focusedBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(31),
//                                 borderSide:
//                                 BorderSide(color: Color(0xFF3b3b6d), width: 2),
//                               )),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ));
//   }
//
//   Widget bottomSheet() {
//     return Container(
//       height: 100,
//       width: MediaQuery.of(context).size.width,
//       margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//       child: Column(
//         children: [
//           Text(
//             "Profile Photo",
//             style: TextStyle(fontSize: 20),
//           ),
//           SizedBox(height: 20),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               InkWell(
//                 onTap: () {
//                   takePhoto(ImageSource.camera);
//                   Navigator.pop(context);
//                 },
//                 child: Row(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Icon(Icons.camera_alt_outlined),
//                     ),
//                     Text("Camera"),
//                   ],
//                 ),
//               ),
//               InkWell(
//                 onTap: () {
//                   takePhoto(ImageSource.gallery);
//                   Navigator.pop(context);
//                 },
//                 child: Row(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Icon(Icons.image),
//                     ),
//                     Text("Gallery"),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

//
//
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceAround,
// children: [
// TextFormField(
//   controller: _tournamentNameController,
//   decoration: InputDecoration(
//     labelText: 'Number of Teams *',
//     labelStyle: TextStyle(color: Colors.grey),
//     focusedBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(10.0),
//       borderSide: BorderSide(color: Colors.blue, width: 2.0),
//     ),
//     enabledBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(10.0),
//       borderSide: BorderSide(color: Colors.grey, width: 1.0),
//     ),
//   ),
//   validator: (value) {
//     if (value == null || value.isEmpty) {
//       return 'Please enter the number of teams';
//     }
//     return 'Please enter a valid number';
//   },
// ),
// Container(
// width: 180,
// child: TextFormField(
// keyboardType: TextInputType.number,
// decoration: const InputDecoration(
// labelText: 'Number of Teams *',
// border: OutlineInputBorder(),
// ),
// validator: (value) {
// if (value == null || value.isEmpty) {
// return 'Please enter the number of teams';
// }
// if (int.tryParse(value) == null) {
// return 'Please enter a valid number';
// }
// return null;
// },
// ),
// ),
// SizedBox(width: 10),
// ElevatedButton(
// onPressed: () {
// Navigator.push(
// context,
// MaterialPageRoute(builder: (context) => CreateTeamScreen()),
// );
// },
// child: Text('Add your teams', style: TextStyle(color: Colors.white),),
// style: ElevatedButton.styleFrom(
// backgroundColor: Color(0xFF3b3b6d),
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(10.0),
// ),
// ),
// )
// ],
// ),