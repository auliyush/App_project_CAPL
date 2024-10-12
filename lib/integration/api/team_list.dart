import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:merge_capl/hold_models/items/decorate_team.dart';
import 'package:provider/provider.dart';
import '../../hold_models/items/team_data.dart';
import '../data_classes/team_response.dart';
import '../providers/login_provider.dart';
import '../providers/teamId_provider.dart';

class TeamList {
  final getTeamListUrl = "http://localhost:8080/capl/team/listOf/Teams";
  final createTeamUrl = "http://localhost:8080/capl/team/create/Team";

  Future<List<TeamData>?> getTeamList(BuildContext context) async {
    try {
      final response = await http.get(Uri.parse(getTeamListUrl));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData is List<dynamic>) {
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
}
