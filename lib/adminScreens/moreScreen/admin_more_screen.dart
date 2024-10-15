import 'package:flutter/material.dart';
import 'package:merge_capl/integration/api/api_services.dart';
import 'package:merge_capl/start/Login.dart';
import 'package:merge_capl/tournament_screens/tournament_list_sceen.dart';
import '../../more_screens/about_us.dart';
import '../../more_screens/feedback_screen.dart';
import '../../more_screens/results_screen.dart';
import '../../tournament_screens/tournament_screen.dart';
import 'tournament_screens/create_tournament_screen.dart';
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
              decoration: const BoxDecoration(
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
        SizedBox(height: 20),
        Expanded(
          child: ListView(
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
                  title: 'Create Tournament',
                  icon: Icons.touch_app,
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateTournament()));
                  }
              ),
              _buildCard(
                  title: 'Tournament',
                  icon: Icons.tour,
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  TournamentListScreen()));
                  }
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
              _buildCard(
                title: "Log-out",
                icon: Icons.logout,
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                },
              ),
            ],
          ),
        ),
      ],
    ));
  }

  Widget _buildCard({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        elevation: 7,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(left: 10,right: 10,top: 7,bottom: 7),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                child: Icon(
                  icon,
                  size: 30,
                ),
                backgroundColor: Colors.white54,
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
