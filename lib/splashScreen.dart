import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:merge_capl/Login.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextPage();
  }

  _navigateToNextPage() async {
    await Future.delayed(Duration(seconds: 3), () {});
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    double topPadding = deviceHeight * 0.16; // equivalent to 150 on 915 height
    double leftPadding1 = deviceWidth * 0.09; // equivalent to 38 on 412 width
    double leftPadding2 = deviceWidth * 0.19; // equivalent to 80 on 412 width
    double imageHeight1 = deviceHeight * 0.55; // equivalent to 500 on 915 height
    double imageHeight2 = deviceHeight * 0.27; // equivalent to 250 on 915 height
    double imageWidth2 = deviceWidth * 0.61; // equivalent to 250 on 412 width

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(top: topPadding),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: leftPadding1),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/splash.gif',
                    height: imageHeight1,
                  ).animate().fadeIn(),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: leftPadding2),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/c.gif',
                    height: imageHeight2,
                    width: imageWidth2,
                  ).animate().fadeIn(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}