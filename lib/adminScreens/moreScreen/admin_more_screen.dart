import 'package:flutter/material.dart';
import 'package:merge_capl/integration/api/api_services.dart';
import '../../more_screens/about_us.dart';
import '../../more_screens/feedback_screen.dart';
import '../../more_screens/results_screen.dart';
import 'admin_tournament.dart';
import '../admin_bottom_nav.dart';

class AdminMorePage extends StatefulWidget {
  const AdminMorePage({super.key});

  @override
  State<AdminMorePage> createState() => _AdminMorePageState();
}

class _AdminMorePageState extends State<AdminMorePage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Column(
      children: [
        // this stack for app bar image and back button
        Stack(
          children: [
            // background image
            Container(
              height: 130,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/bg.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // back button
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
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AdminBottomNav()));
                },
              ),
            ),
            // screen name
            Padding(
              padding: const EdgeInsets.only(left: 18, top: 70),
              child: Text(
                "More",
                style: TextStyle(
                  fontSize: screenWidth <= 750 ? screenWidth * 0.06 : 44,
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
              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white70,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  surfaceTintColor: Colors.white,
                  foregroundColor: Colors.grey,
                ),
                onPressed: () {
                  ApiServices obj = ApiServices();
                  obj.navigateToAccounts(context);
                },
                child: _cardBuilder('Account'),
              ),
              // Account button

              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white70,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  surfaceTintColor: Colors.white,
                  foregroundColor: Colors.grey,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>  ResultScreen()));
                },
                child: _cardBuilder('Results'),
              ),
              // Results Button

              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white70,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  surfaceTintColor: Colors.white,
                  foregroundColor: Colors.grey,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const AboutUsScreen()));
                },
                child: _cardBuilder('About Us'),
              ),
              // About us button

              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white70,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  surfaceTintColor: Colors.white,
                  foregroundColor: Colors.grey,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FeedBackScreen()));
                },
                child: _cardBuilder('FeedBack'),
              ),
              // FeedBack button

              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white70,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  surfaceTintColor: Colors.white,
                  foregroundColor: Colors.grey,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Tournament()));
                },
                child: _cardBuilder('Tournament'),
              ),
              // Tournament Button
            ],
          ),
        ),
      ],
    ));
  }

  // buttons Card decorator method
  Widget _cardBuilder(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0, bottom: 16, left: 0, right: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(width: 0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                      color: Colors.black,
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
}
