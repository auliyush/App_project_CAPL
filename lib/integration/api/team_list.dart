import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:merge_capl/integration/data_classes/login_response.dart';
import 'package:provider/provider.dart';

import '../../hold_models/items/team_data.dart';
import '../data_classes/team_response.dart';
import '../providers/login_provider.dart';
import '../providers/teamId_provider.dart';

class TeamList {
  final getTeamListUrl = "http://localhost:8080/capl/team/listOf/Teams";
  final createTeamUrl = "http://localhost:8080/capl/team/create/Team";

  // Future<Teams?> getTeamList(BuildContext context) async {
  //   try {
  //     final response = await http.get(Uri.parse(getTeamListUrl));
  //
  //     if (response.statusCode == 200) {
  //       final jsonData = jsonDecode(response.body);
  //       List<Teams> classes = (jsonDecode(response.body) as List)
  //           .map((classJson) => Teams.fromJson(classJson))
  //           .toList();
  //     }
  //   } on http.ClientException catch (e) {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text("Network Error : $e")));
  //     return null;
  //   } on FormatException catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Invalid response from server')),
  //     );
  //     return null;
  //   } catch (e) {
  //     print('Unknown Error: $e');
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('An unknown error occurred. Please try again.')),
  //     );
  //     return null;
  //   }
  //
  //   return null;
  // }

  Future<TeamId?> createTeam(
      String teamName,
      String teamNickname,
      String teamProfilePhotoUrl,
      BuildContext context) async {
    try {
      // for getting data from path provider....
      final loginResponse = context.read<LoginProvider>().loginResponse;
      final response = await http.post(Uri.parse(createTeamUrl),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            "teamCreatorId":loginResponse?.creatorId,
            "teamName": teamName,
            "teamNickName": teamNickname,
            "teamProfilePhotoUrl": teamProfilePhotoUrl
          }));

      if(response.statusCode == 200) {
        final responseBody = response.body;
        if (responseBody == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Invalid Creator Id!!!')),
          );
          return null;
        } else {
          final jsonData = jsonDecode(response.body);
          final teamId = TeamId.fromJson(jsonData);
          Provider.of<TeamIdProvider>(context, listen: false).updateTeamIdResponse(teamId);

          final teamItem = TeamData(
              teamId: teamId.teamId,
              teamProfileUrl: "",
              teamName: teamName,
              teamNickName: teamNickname,
              batters: [],
              bowlers: [],
              allRounders: [],
            );
          Navigator.pop(context, teamItem);

          /// for check
          print(loginResponse?.creatorId);
          print(teamId.teamId);
          return teamId;
        }
      } else {
        //
      }

    } on http.ClientException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Network Error : $e")));
      return null;
    } on FormatException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid response from server')),
      );
      print(e);
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
