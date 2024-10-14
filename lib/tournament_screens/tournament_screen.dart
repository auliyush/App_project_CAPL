import 'package:flutter/material.dart';
import 'package:merge_capl/navigation/bottom_nav_screen.dart';
import 'package:merge_capl/start/Login.dart';
import 'package:provider/provider.dart';

import '../integration/api/api_services.dart';
import '../integration/providers/login_provider.dart';


class TournamentScreen extends StatefulWidget {

  @override
  State<TournamentScreen> createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TournamentScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 20, bottom: 15),

      ),
      body: Column(
        children: [
          SizedBox(
            height: 130,
            child: Stack(
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
                        if( Provider.of<LoginProvider>
                          (context, listen: false).loginResponse?.role.toLowerCase() == "admin") {
                          Navigator.pop(context);
                        } else {
                          ApiServices obj = ApiServices();
                          obj.navigateToBottomNav(context);
                        }

                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18, top: 80),
                  child: Text(
                    "Tournament",
                    style: TextStyle(
                      fontSize: screenWidth <= 750 ? screenWidth * 0.06 : 44, // adjust font size based on screen width
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}