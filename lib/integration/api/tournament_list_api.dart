import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;

class TournamentListApi {
  final String tournamentId;
  final String tournamentName;
  final String seasonYear;
  final String tournamentCreatorId;
  final String? highestScoreBatterId;
  final String? highestScoreBowlerId;
  final String? winnerTeam;
  final DateTime tournamentStartDate; // Change to DateTime
  final DateTime tournamentEndDate; // Change to DateTime
  final String stadiumName;
  final String stadiumAddress;
  final String? teamStatsList;
  final List<dynamic> teamList;

  TournamentListApi({
    required this.tournamentId,
    required this.tournamentName,
    required this.seasonYear,
    required this.tournamentCreatorId,
    this.highestScoreBatterId,
    this.highestScoreBowlerId,
    this.winnerTeam,
    required this.tournamentStartDate,
    required this.tournamentEndDate,
    required this.stadiumName,
    required this.stadiumAddress,
    this.teamStatsList,
    required this.teamList,
  });

  factory TournamentListApi.fromJson(Map<String, dynamic> json) {
    return TournamentListApi(
      tournamentId: json['tournamentId'],
      tournamentName: json['tournamentName'],
      seasonYear: json['seasonYear'],
      tournamentCreatorId: json['tournamentCreatorId'],
      highestScoreBatterId: json['highestScoreBatterId'],
      highestScoreBowlerId: json['highestScoreBowlerId'],
      winnerTeam: json['winnerTeam'],
      tournamentStartDate: DateTime.parse(json['tournamentStartDate']),
      tournamentEndDate: DateTime.parse(json['tournamentEndDate']),
      stadiumName: json['stadiumName'],
      stadiumAddress: json['stadiumAddress'],
      teamStatsList: json['teamStatsList'],
      teamList: List<dynamic>.from(json['teamList'] ?? []),
    );
  }
}

class TournamentService {
  final String apiUrl = 'http://localhost:8080/capl/tournament/get/listOf/tournament';

  Future<List<TournamentListApi>> fetchTournaments() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        return jsonResponse.map((data) => TournamentListApi.fromJson(data)).toList();
      } else {
        print('Failed to load tournaments: ${response.body}');
        throw Exception('Failed to load tournaments: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching tournaments: $e');
      throw Exception('Error fetching tournaments: $e');
    }
  }
}




class AdminNameByID {
  String adminID;
  AdminNameByID(this.adminID);

  final String apiUrl = 'http://localhost:8080/admin/byId?adminId=';

  Future<String?> fetchAdminName() async {
    try {
      final response = await http.get(Uri.parse('$apiUrl$adminID'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        String adminName = data['adminName'] ?? 'Unknown Admin';
        return adminName;
      } else {
        print('Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching admin: $e');
      return null;
    }
  }
}
