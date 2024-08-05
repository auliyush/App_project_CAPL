import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    // Get screen width and height
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Upper background and texts
            Stack(
              children: [
                Container(
                  height: screenHeight * 0.25,
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
                  padding: EdgeInsets.only(left: screenWidth * 0.04, top: screenHeight * 0.15),
                  child: Text(
                    "About Us",
                    style: TextStyle(
                      fontSize: screenWidth * 0.06,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            // Address
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02, vertical: screenHeight * 0.01),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(screenWidth * 0.02),
                        child: Text(
                          'Address :',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: screenWidth * 0.05,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: screenHeight * 0.01),
                        height: 1,
                        color: Colors.black54,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: screenWidth * 0.02),
                            child: Icon(
                              Icons.location_on_outlined,
                              color: Color(0xFF3b3b6d),
                              size: screenWidth * 0.06,
                            ),
                          ),
                          SizedBox(
                            width: screenWidth * 0.7,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                'B/173 Shruti kunj, pc colony, kankarbagh, 800020',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: screenWidth * 0.04,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Contact
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02, vertical: screenHeight * 0.01),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(screenWidth * 0.02),
                        child: Text(
                          'Contact Us :',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: screenWidth * 0.05,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: screenHeight * 0.01),
                        height: 1,
                        color: Colors.black54,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: screenWidth * 0.02),
                            child: Icon(
                              Icons.call,
                              color: Color(0xFF3b3b6d),
                              size: screenWidth * 0.06,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: screenWidth * 0.02),
                            child: Text(
                              '+91 9693243217',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: screenWidth * 0.04,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(screenWidth * 0.02),
                            child: Icon(
                              Icons.email_outlined,
                              color: Color(0xFF3b3b6d),
                              size: screenWidth * 0.06,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: screenWidth * 0.02),
                            child: Text(
                              'Info@codingage.biz',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: screenWidth * 0.04,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.2),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: screenHeight * 0.02),
                    child: Text(
                      'Created By',
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        color: Color.fromRGBO(171, 86, 53, 12.0),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Coding',
                        style: TextStyle(
                          color: Color.fromRGBO(205, 76, 42, 20),
                          fontSize: screenWidth * 0.08,
                        ),
                      ),
                      Container(
                        color: const Color.fromRGBO(225, 128, 126, 12),
                        child: Text(
                          'Age',
                          style: TextStyle(
                            fontSize: screenWidth * 0.08,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
