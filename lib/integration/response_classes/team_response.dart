
class TeamId {
  String teamId;
  String teamCreatorId;
  TeamId({
    required this.teamId,
    required this.teamCreatorId
  });

  factory TeamId.fromJson(Map<String, dynamic> jsonData) {
    return TeamId(
        teamId: jsonData["teamId"],
        teamCreatorId: jsonData["teamCreatorId"]
    );
  }
}








