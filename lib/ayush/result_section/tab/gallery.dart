import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Gallery extends StatefulWidget {
  const Gallery({super.key});

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  File? _image;
  bool _isHovering = false;

  Future<void> _takePhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        _image = null;
      }
    });
  }

  Future<void> _selectImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        _image = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _image != null
                    ? Image.file(_image!, width: screenWidth * 0.8)
                    : const Text('No image selected'),
                const SizedBox(height: 20),
              ],
            ),
          ),
          Positioned(
            right: 20,
            bottom: 20,
            child: MouseRegion(
              onEnter: (event) => setState(() => _isHovering = true),
              onExit: (event) => setState(() => _isHovering = false),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: screenWidth * 0.3),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: _isHovering ? screenWidth * 0.3 : screenWidth * 0.15,
                  height: _isHovering ? screenHeight * 0.1 : screenHeight * 0.05,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Color(0xFF3b3b6d),
                  ),
                  child: _isHovering
                      ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.camera, color: Colors.white,),
                        onPressed: _takePhoto,
                      ),
                      IconButton(
                        icon: const Icon(Icons.photo_library, color: Colors.white,),
                        onPressed: _selectImage,
                      ),
                    ],
                  )
                      : GestureDetector(
                    onTap: _selectImage,
                    child: const Icon(Icons.add_photo_alternate, size: 30, color: Colors.white,),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}