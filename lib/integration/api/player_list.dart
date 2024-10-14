import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../adminScreens/teamScreens/teamPlayersScreens/playerListScreens/player_list.dart';
import '../../player_screens/player_update_account_screen.dart';
import '../providers/login_provider.dart';
import '../response_classes/player_data.dart';
import '../response_classes/player_data_model.dart';
import '../response_classes/player_role_response.dart';

class PlayerApi {
  final playerListUrl = "http://localhost:8080/capl/player/listOf/player/ByRole";
  final getPlayerByRoleUrl = "http://localhost:8080/capl/team/listOf/player/ByRole/from/Team";
  final addPlayerInTeamUrl = "http://localhost:8080/capl/team/add/player";

  final String getPlayerAccountUrl = "http://localhost:8080/capl/player/get/player";

  Future<PlayerRoleResponse?> getPlayerListByRole(String playerType,
      BuildContext context) async {
    try {
      final response = await http.get(
        Uri.parse(playerListUrl).replace(queryParameters: {
          "playerRole": playerType,
        }),
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData is List) {
          final playerList = jsonData.map((e) => PlayerDataByRole.fromJson(e))
              .toList();
          final playerResponse = PlayerRoleResponse(playerRoles: playerList);
          Player.addPlayersFromResponse(playerList);
          return playerResponse;
        }

        /// rest to do...
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

  Future<List<FetchedPlayerData>?> getPlayerByRoleForTeam(String teamId,String playerRole, BuildContext context) async {
    try {
      final uri = Uri.parse(getPlayerByRoleUrl).replace(queryParameters: {
        "teamId": Uri.encodeComponent(teamId),
        "playerRole": Uri.encodeComponent(playerRole)
      });

      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData is List) {
          return jsonData.map((e) => FetchedPlayerData.fromJson(e))
              .toList();
        }
      }
    } on http.ClientException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Network Error : $e")));
    } on FormatException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid URL: $e')),
      );
    } catch (e) {
      print('Unknown Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An unknown error occurred. Please try again.')),
      );
    }
    return null;
  }

  Future<void> addPlayerInTeam(List<String> playerId, String teamId, BuildContext context) async {
    try {
      print(Provider.of<LoginProvider>(context, listen: false).loginResponse?.signInId);
      final headers = {
        'Content-Type': 'application/json',
      };

      final body = jsonEncode({
        "teamId" : teamId,
        "players" : playerId,
        "creatorId" :Provider.of<LoginProvider>(context, listen: false).loginResponse?.signInId
      });

      final response = await http.put(Uri.parse(addPlayerInTeamUrl), headers: headers, body: body);
      if(response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if(jsonData) {
          print("workded");
        } else {
          print("not worked");
        }
      }
    } on http.ClientException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Network Error : $e")));
    } on FormatException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid URL: $e')),
      );
    } catch (e) {
      print('Unknown Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An unknown error occurred. Please try again.')),
      );
    }
  }

  Future<PlayerDataModel?> playerDataApi(BuildContext context) async {
    final counter = Provider.of<LoginProvider>(context, listen: false);
    try {
      final response = await http.get(Uri.parse(getPlayerAccountUrl).replace(
          queryParameters: {"playerId": counter.loginResponse?.signInId}));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final playerDataModel = PlayerDataModel.fromJson(jsonData);
        Navigator.push(context, MaterialPageRoute(builder: (context) =>
            PlayerUpdateAccountScreen(
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

}