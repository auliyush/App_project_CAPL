import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:merge_capl/hold_models/items/team_data.dart';

import '../../teams/member_screen.dart';

class DecorateTeam extends StatelessWidget {
  final TeamData teamData;

  const DecorateTeam({
    super.key,
    required this.teamData,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: Colors.blue.shade50, // changed to white
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 20),
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: MemoryImage(base64Decode(teamData.teamProfileUrl)),
                  fit: BoxFit.cover,
                ),
                border: Border.all(
                  width: 3,
                  color: Colors.black12,
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${teamData.teamName}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    '${teamData.teamNickName}',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: IconButton(
                icon: Icon(Icons.arrow_forward_ios, color: Colors.black),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MemberScreen(teamData: teamData)));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}