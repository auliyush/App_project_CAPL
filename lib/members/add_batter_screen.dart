import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../hold_models/items/decorate_team.dart';
import '../hold_models/items/team_data.dart';
import '../hold_models/player_list_model.dart';

class BatterScreen extends StatefulWidget {
  final TeamData teamData;

  const BatterScreen({super.key, required this.teamData});

  @override
  State<BatterScreen> createState() => _BatterScreenState();
}

class _BatterScreenState extends State<BatterScreen> {

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
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/bg.jpg"),
                  ),
                ),
              ),
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
                    Navigator.pop(context);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18, top: 80),
                child: Text(
                  "Add Bats-man",
                  style: TextStyle(
                    fontSize: screenWidth <= 750 ? screenWidth * 0.06 : 44,
                    // adjust font size based on screen width
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Consumer<ListModel>(
                  builder: (context, model, child) {
                    return ListView.builder(
                      shrinkWrap: false,
                      physics: ClampingScrollPhysics(),
                      itemCount: model.teams.length,
                      itemBuilder: (context, index) {
                        return DecorateTeam(teamData: model.teams[index]);
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
    );
  }
}