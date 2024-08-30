import 'package:flutter/material.dart';
import 'package:merge_capl/Login.dart';
import 'package:provider/provider.dart';

import '../hold_models/items/decorate_team.dart';
import '../hold_models/player_list_model.dart';


class UpdatedTournamentScreen extends StatefulWidget {

  @override
  State<UpdatedTournamentScreen> createState() => _TeamScreenState();
}

class _TeamScreenState extends State<UpdatedTournamentScreen> {
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
                  decoration: BoxDecoration(
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