class TournamentResponse {
  final String tournamentId;
  final String tournamentCreatorId;

  TournamentResponse({
    required this.tournamentId,
    required this.tournamentCreatorId,
  });

  factory TournamentResponse.fromJson(Map<String, dynamic> jsonData) {
    return TournamentResponse(
        tournamentId: jsonData["tournamentId"],
        tournamentCreatorId: jsonData["tournamentCreatorId"]
    );
  }

}
