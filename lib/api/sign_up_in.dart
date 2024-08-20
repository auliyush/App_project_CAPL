import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import '../aman/bottom_nav.dart';
import '../hold_models/items/team_data.dart';

class ApiService {
  static const loginUrl = "http://localhost:8080/capl/user/signIn";
  static String loggedUserId = "";
  final createTeamUrl = "http://localhost:8080/capl/team/create/Team";
  static const getApiUrl = "http://localhost:8080/capl/user/logged/in/user/Id";

  Future<void> signInRequest(String userPhone, String userPassword, BuildContext context) async {
    try {
      final uri = Uri.parse(loginUrl).replace(queryParameters: {
        'userPhone': userPhone,
        'userPassword': userPassword,
      });
      final response = await http.post(uri);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData) {
          await getUserId(userPhone, userPassword);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNav()));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Authentication failed')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Server error: ${response.statusCode}')),
        );
      }
    } on http.ClientException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Network error: $e')),
      );
    } on FormatException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid response from server')),
      );
    } catch (e) {
      print('Unknown Error: $e'); // log the error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An unknown error occurred. Please try again.')),
      );
    }
  }

  Future<void> getUserId(String userPhone, String userPassword) async {
    try {
      final response = await http.get(Uri.parse(getApiUrl).replace(queryParameters: {
        'userPhone': userPhone,
        'userPassword': userPassword,
      }));

      if (response.statusCode == 200) {
        final userId = response.body.toString();
        if (userId.isNotEmpty) {
          loggedUserId = userId;
          print(loggedUserId);
        } else {
          // handle empty user ID
        }
      } else {
        // handle failed login
      }
    } on http.ClientException catch (e) {
      // handle network error
    } on FormatException catch (e) {
      // handle invalid response
    } catch (e) {
      print('Unknown Error: $e'); // log the error
      // handle unknown error
    }
  }

  Future<void> postApiCreateTeam(String teamName, String teamNickName, BuildContext context) async {
    try {
      final response = await http.post(Uri.parse(createTeamUrl),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            "teamCreatorId": loggedUserId,
            "teamName": teamName,
            "teamNickName": teamNickName
          }));

      if (response.statusCode == 200) {
        print("jj"); //for check purpose
        final teamId = Uuid().v4();
        final teamItem = TeamData(
          teamId: teamId,
          teamProfileUrl: "assets/images/default.jpg",
          teamName: teamName,
          teamNickName: teamNickName,
          batters: [],
          bowlers: [],
          allRounders: [],
        );
        Navigator.pop(context, teamItem);
      }
    } on http.ClientException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Network error: $e')),
      );// rethrow the exception
    } on FormatException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid response from server')),
      );// rethrow the exception
    } catch (e) {
      print('Unknown Error: $e'); // log the error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An unknown error occurred. Please try again.')),
      );// rethrow the exception
    }
  }}