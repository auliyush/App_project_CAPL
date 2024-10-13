import 'package:flutter/material.dart';
import 'package:merge_capl/start/Login.dart';
import 'package:merge_capl/integration/api/api_services.dart';
import 'package:merge_capl/more_screens/results_screen.dart';

import '../integration/api/player_more_screen.dart';
import 'about_us.dart';
import 'feedback_screen.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MorePageState();
}

class _MorePageState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 130,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/bg.jpg'),
                    fit: BoxFit.cover,
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
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18, top: 80),
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
          SizedBox(height: 20),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(10.0),
              children: [
                _buildCard(
                  title: "Account",
                  icon: Icons.person,
                  onTap: () {
                    ApiServices api = ApiServices();
                    api.navigateToAccounts(context);
                  },
                ),
                _buildCard(
                  title: "Results",
                  icon: Icons.score,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  ResultScreen()));
                  },
                ),
                _buildCard(
                  title: "About Us",
                  icon: Icons.info,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutUsScreen()));
                  },
                ),
                _buildCard(
                  title: "Feedback",
                  icon: Icons.feedback,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const FeedBackScreen()));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: Colors.deepPurple[50],
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.deepPurple[100],
                radius: 30,
                child: Icon(
                  icon,
                  size: 30,
                  color: Colors.deepPurple[800],
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.deepPurple[900],
                  ),
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.deepPurple,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
