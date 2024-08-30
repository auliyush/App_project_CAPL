import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../data_classes/player_role_response.dart';

class PlayerList {

  final playerListUrl = "http://localhost:8080/capl/player/listOf/player/ByRole";



  Future<PlayerRoleResponse?> playerListByRoleApi(String playerType , BuildContext context) async {
    try {
      final uri = Uri.parse(playerListUrl).replace(queryParameters: {
        "playerType": playerType,
      });

      final response = await http.post(uri);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final playerRoleResponse = PlayerRoleResponse.fromJson(jsonData);
      }
    }
    on http.ClientException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Network Error : $e")));
      return null;
    } on FormatException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid response from server')),
      );
      return null;
    } catch (e) {
      print('Unknown Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('An unknown error occurred. Please try again.')),
      );
    }
    return null;
  }

}