
class TeamResponse {

}



class TeamId {
  String teamId;
  TeamId({required this.teamId});

  factory TeamId.fromJson(Map<String, dynamic> jsonData) {
    return TeamId(teamId: jsonData["teamId"]);
  }
}








