import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:merge_capl/integration/response_classes/tournament_response.dart';
import 'package:provider/provider.dart';

import '../providers/login_provider.dart';

class TournamentApiService {

  final addTeamInTournamentUrl = "http://localhost:8080/capl/tournament/add/Teams/Tournament";
  final createTournamentUrl = "http://localhost:8080/capl/tournament/create/tournament";

  String? tournamentId;


  int currentYear = DateTime.now().year;


  Future<TournamentResponse?> createTournament(
      String tournamentName,
      String tournamentStartDate,
      String tournamentEndDate,
      String stadium,
      String address,
      List<String> teamsIdList,
      BuildContext context
      ) async {
    try {
      final response = await http.post(Uri.parse(createTournamentUrl),

          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            "tournamentName":tournamentName,
            "seasonYear": currentYear.toString(),
            "creatorId": Provider
                .of<LoginProvider>(context, listen: false)
                .loginResponse
                ?.signInId,
            "tournamentStartDate": tournamentStartDate,
            "tournamentEndDate": tournamentEndDate,
            "stadiumName": stadium,
            "stadiumAddress": address,
          }));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final tournamentResponse = TournamentResponse.fromJson(jsonData);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Successfully Created Tournament')),
        );
        tournamentId = tournamentResponse.tournamentId;
        /// calling when before tournament created...
        addTeamInTournament(teamsIdList, context);
        return tournamentResponse;
        /// todo here i have to navigate prince designed tournament list screen
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Returned Null through Server')),
        );
      }
    } on http.ClientException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Network error: $e')),
      ); // rethrow the exception
    } on FormatException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid response from server')),
      ); // rethrow the exception
    } catch (e) {
      print('Unknown Error: $e'); // log the error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An unknown error occurred. Please try again.')),
      ); // rethrow the exception
    }
    return null;
  }

  Future<void> addTeamInTournament(List<String> teamsId ,BuildContext context) async{
    print("enter");
    try{
      print(Provider.of<LoginProvider>(context, listen: false).loginResponse?.signInId);
      final headers = {
        'Content-Type' : 'application/json',
      };
      final body = jsonEncode({
        "tournamentId" : tournamentId,
        "teamsId" : teamsId,
        "tournamentCreatorId" : Provider.of<LoginProvider>(context, listen: false).loginResponse?.signInId
      });

      final response = await http.put(Uri.parse(addTeamInTournamentUrl), headers: headers, body: body);
      if(response.statusCode == 200){
        print("enter2");
        final jsonData = jsonDecode(response.body);
        if(jsonData){
          print("enter3");
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Tournament Created Success")));
        }else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Tournament Created Failed")));
        }
      }
    } on http.ClientException {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Network Error")));
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


}