import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:merge_capl/ayush/account_screen.dart';
import 'package:provider/provider.dart';

import '../data_classes/player_data_model.dart';
import '../providers/login_provider.dart';

class PlayerMoreAccount {

  final String getPlayerAccountUrl = "http://localhost:8080/capl/player/get/player";
  static String playerPassword = '';
  final String updatePlayerAccountUrl = 'http://localhost:8080/capl/player/update/profile';

  // LoginProvider obj = LoginProvider();

  Future<PlayerDataModel?> playerDataApi(BuildContext context) async {
    final counter = Provider.of<LoginProvider>(context, listen: false);
    try {
      final response = await http.get(Uri.parse(getPlayerAccountUrl).replace(
          queryParameters: {"playerId": counter.loginResponse?.creatorId}));
      print(counter.loginResponse?.creatorId);
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final playerDataModel = PlayerDataModel.fromJson(jsonData);
        playerPassword = playerDataModel.playerPassword;
        Navigator.push(context, MaterialPageRoute(builder: (context) =>
            AccountPage(
              playerPhotoUrl: playerDataModel.playerPhotoUrl,
              playerName: playerDataModel.playerName,
              playerMobNumber: playerDataModel.playerMobNumber,
              playerEmail: playerDataModel.playerEmail,
              playerAddress: playerDataModel.address,
              playerNickName: playerDataModel.playerNickName,
              playerType: playerDataModel.playerType,
              playerSubType: playerDataModel.playerSubType,
            )));
      }
    } on http.ClientException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Network Error : $e")));
      return null;
    } on FormatException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid response from server')),
      );
      return null;
    } catch (e) {
      print('Unknown Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An unknown error occurred. Please try again.')),
      );
      return null;
    }
    return null;
  }
  Future<void> updatePlayerAccountApi(String playerPhotoUrl, String playerName,
      String playerNickName, String playerMobNumber, String playerEmail,
      String address, String playerType, String playerSubType , BuildContext context) async {
    try {
      final counter = Provider.of<LoginProvider>(context, listen: false);

      final response = await http.put(Uri.parse(updatePlayerAccountUrl),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            "playerId": counter.loginResponse?.creatorId,
            "playerProfilePhotoUrl": playerPhotoUrl,
            "playerName": playerName,
            "playerNickName": playerNickName,
            "playerPhone": playerMobNumber,
            "playerEmail": playerEmail,
            "playerPassword": playerPassword,
            "playerDob": "",
            "playerAddress": address,
            "playerType": playerType,
            "playerSubType": playerSubType
          })
      );



      if(response.statusCode == 200){
        final jsonData = jsonDecode(response.body);
        print(jsonData);
        if (jsonData['success']) {
          Navigator.pop(context);
        }
        else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('')),
          );
        }
      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Server error: ${response.statusCode}')),
        );
      }
    }
    on http.ClientException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Network error: $e')),
      );
      print("$e");
    } on FormatException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid response from server')),
      );
    } catch (e) {
      print('Unknown Error: $e'); // it is use for the error print in console
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('An unknown error occurred. Please try again.')),
      );
    }
  }
}