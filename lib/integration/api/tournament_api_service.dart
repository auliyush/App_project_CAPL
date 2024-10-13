import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../providers/login_provider.dart';

class TournamentApiService {

  final addTeamInTournamentUrl = "";


  Future<void> addTeamsInTournament(List<String> teamId, String tournamentId, BuildContext context) async {
    try {
      print(Provider.of<LoginProvider>(context, listen: false).loginResponse?.signInId);
      final headers = {
        'Content-Type': 'application/json',
      };

      final body = jsonEncode({
        "tournamentId" : tournamentId,
        "players" : teamId,
        "creatorId" :Provider.of<LoginProvider>(context, listen: false).loginResponse?.signInId
      });

      final response = await http.put(Uri.parse(addTeamInTournamentUrl), headers: headers, body: body);
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

  // Future<void> createTournament(String tournamentName, String teamNickName, String teamPhotoUrl, BuildContext context) async {
  //   try {
  //     final response = await http.post(Uri.parse(createTeamUrl),
  //         headers: {
  //           'Content-Type': 'application/json',
  //         },
  //         body: jsonEncode({
  //           "teamCreatorId": loggedId,
  //           "teamName": tournamentName,
  //           "teamNickName": teamNickName,
  //           "teamProfilePhotoUrl" : teamPhotoUrl
  //         }));
  //
  //     if (response.statusCode == 200) {
  //       Navigator.pop(context);
  //     }
  //   } on http.ClientException catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Network error: $e')),
  //     );// rethrow the exception
  //   } on FormatException catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Invalid response from server')),
  //     );// rethrow the exception
  //   } catch (e) {
  //     print('Unknown Error: $e'); // log the error
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('An unknown error occurred. Please try again.')),
  //     );// rethrow the exception
  //   }
  // }


}