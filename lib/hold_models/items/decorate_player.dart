import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:merge_capl/aman/player/player_account.dart';
import 'player_data.dart';

class DecoratePlayer extends StatelessWidget {
  final FetchedPlayerData playerData;

  const DecoratePlayer({
    Key? key, required this.playerData,
  }) : super(key: key);

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
                  image: NetworkImage(playerData.playerPhotoUrl),
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
                    '${playerData.playerName}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    '${playerData.playerNickName}',
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
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) =>
                          PlayerAccount(
                              playerPhotoUrl: playerData.playerPhotoUrl,
                              playerName: playerData.playerName!,
                              playerMobNumber: playerData.playerNickName!,
                              playerEmail: playerData.playerEmail!,
                              playerGender: "MALE")));
                  // todo navigate it to player profile right now not in correct profile
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

}