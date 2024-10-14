import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:merge_capl/integration/providers/login_provider.dart';
import 'package:provider/provider.dart';
import '../../adminScreens/moreScreen/tournament_screens/add_teams_tournament.dart';
import '../response_classes/team_data.dart';

class TeamApiServices {
  final getTeamListUrl = "http://localhost:8080/capl/team/listOf/Teams";
  final createTeamUrl = "http://localhost:8080/capl/team/create/Team";
  final deleteTeamUrl = "http://localhost:8080/capl/team/delete/team/by/teamId";

  Future<List<TeamData>?> getTeamList(BuildContext context) async {
    try {
      final response = await http.get(Uri.parse(getTeamListUrl));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData is List<dynamic>) {
          final teamList = jsonData.map((e) => TeamData.fromJson(e))
              .toList();
          Team.addTeamFromResponse(teamList);
          return jsonData.map((teamJson) => TeamData.fromJson(teamJson)).toList().cast<TeamData>();
        } else {
          throw FormatException('Invalid response from server');
        }
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

  Future<bool?> deleteTeam(String teamId, BuildContext context) async {
    final counter = Provider.of<LoginProvider>(
      context,
      listen: false,
    ).loginResponse?.signInId;

    try {
      final uri = Uri.parse(deleteTeamUrl);
      final queryParameters = {
        'teamId': teamId,
        'teamCreatorId': counter,
      };
      final requestUri = uri.replace(queryParameters: queryParameters);

      final response = await http.delete(
        requestUri,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        print(jsonData);
        if (jsonData) {
          if (context.mounted) { // Check if widget is still mounted
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Successfully team deleted')),
            );
          }
          return true;
        } else {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Something went wrong')),
            );
          }
          return false;
        }
      }
    } on http.ClientException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Network Error : $e")),
        );
      }
      return null;
    } on FormatException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid response from server')),
        );
      }
      return null;
    } catch (e) {
      print('Unknown Error: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('An unknown error occurred. Please try again.')),
        );
      }
      return null;
    }
    return null;
  }

}


