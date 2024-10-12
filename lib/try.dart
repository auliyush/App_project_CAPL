// // import 'dart:io';
// //
// // import 'package:flutter/material.dart';
// // import 'package:image_picker/image_picker.dart';
// // import 'package:share_plus/share_plus.dart';
// // import 'dart:typed_data';
// // import 'package:uuid/uuid.dart';
// // import '../hold_models/items/team_data.dart';
// // import 'dart:convert';
// // import 'package:http/http.dart' as http;
// //
// // void main() {
// //   runApp(MyApp());
// // }
// //
// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Image Picker',
// //       theme: ThemeData(
// //         primarySwatch: Colors.blue,
// //       ),
// //       home: MyHomePage(),
// //     );
// //   }
// // }
// //
// // class MyHomePage extends StatefulWidget {
// //   @override
// //   _MyHomePageState createState() => _MyHomePageState();
// // }
// //
// // class _MyHomePageState extends State<MyHomePage> {
// //   final ImagePicker imagePicker = ImagePicker();
// //   XFile? imageFile;
// //   String base64String = '';
// //   Uint8List? _image;
// //
// //   String? base64S;
// //
// //   // Method to take a photo
// //   void takePhoto(ImageSource source) async {
// //     final pickedFile = await imagePicker.pickImage(source: source);
// //     if (pickedFile != null) {
// //       String imagePath = pickedFile.path;
// //
// //       List<int> imageByte = File(pickedFile.path).readAsBytesSync();
// //       base64S = base64Encode(imageByte);
// //
// //       File file = File(imagePath);
// //
// //       // Read the image file as bytes
// //       Uint8List imageBytes = await file.readAsBytes();
// //
// //       // Convert the image bytes to Base64 string
// //       base64String = base64.encode(imageBytes);
// //
// //       setState(() {
// //         imageFile = pickedFile;
// //       });
// //     }
// //   }
// //
// //   // Method to convert Base64 string back to image
// //   void convertBase64ToImage() {
// //     _image = base64Decode(base64String);
// //     // Create a data URL from the decoded image bytes
// //     String imageDataUrl = 'data:image/jpg;base64,$base64String';
// //     // Print the data URL to the console
// //     // print(imageDataUrl);
// //     setState(() {
// //       // Decode the Base64 string to Uint8List
// //       _image = base64Decode(base64String);
// //     });
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Image Picker'),
// //       ),
// //       body: Center(
// //         child: base64S != null
// //             ? Stack(
// //                 children: [
// //                   CircleAvatar(
// //                     radius: 60,
// //                     backgroundImage: MemoryImage(base64Decode(base64S!)),
// //                   ),
// //                   Positioned(
// //                     top: 0,
// //                     left: 0,
// //                     right: 0,
// //                     bottom: 0,
// //                     child: CircularProgressIndicator(),
// //                   ),
// //                 ],
// //               )
// //             : Text('No image selected'),
// //       ),
// //       floatingActionButton: FloatingActionButton(
// //         onPressed: () => takePhoto(ImageSource.gallery),
// //         tooltip: 'Pick Image',
// //         child: Icon(Icons.add_a_photo),
// //       ),
// //     );
// //   }
// // }
//
//
//
//
//
//
//
//
//
//
// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart';
// // import 'package:http_parser/http_parser.dart';
// // import 'package:image_picker/image_picker.dart';
// // import 'package:dio/dio.dart';
// //
// // void main() {
// //   runApp(MaterialApp(home: CloudinaryImageUpload()));
// // }
// //
// // class CloudinaryImageUpload extends StatefulWidget {
// //   @override
// //   _CloudinaryImageUploadState createState() => _CloudinaryImageUploadState();
// // }
// //
// class _CloudinaryImageUploadState extends State<CloudinaryImageUpload> {
//   final ImagePicker _picker = ImagePicker();
//   String? _uploadedImageUrl;
//   Future<void> _uploadImageToCloudinary(XFile imageFile) async {
//     try {
//       String cloudinaryUrl = 'https://api.cloudinary.com/v1_1/YOUR_CLOUD_NAME/image/upload';
//       String uploadPreset = 'YOUR_PRESET_NAME';
//
//       FormData formData = FormData.fromMap({
//         'file': await MultipartFile.fromFile(imageFile.path, contentType: MediaType.parse('multipart/form-data')),
//         'upload_preset': uploadPreset,
//       });
//
//       Response response = await Dio().post(cloudinaryUrl, data: formData);
//
//       if (response.statusCode == 200) {
//         setState(() {
//           _uploadedImageUrl = response.data['secure_url'];
//           print(_uploadedImageUrl);
//         });
//       } else {
//         print('Failed to upload image: ${response.statusMessage}');
//       }
//     } catch (e) {
//       print('Error uploading image: $e');
//     }
//   }
//
//   Future<void> _pickAndUploadImage() async {
//     final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       await _uploadImageToCloudinary(image);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Upload Image to Cloudinary'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             _uploadedImageUrl != null
//                 ? Image.network(_uploadedImageUrl!)
//                 : Text('No image uploaded'),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _pickAndUploadImage,
//               child: Text('Upload Image'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
