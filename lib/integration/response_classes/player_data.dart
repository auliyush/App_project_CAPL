
class FetchedPlayerData {
  String playerPhotoUrl;
  String? playerName;
  String? playerNickName;
  String? playerPhone;
  String? playerEmail;
  String playerType;
  String playerSubType;
  String playerAddress;
  int highestScore;
  int totalHalfCentury;
  int totalFullCentury;
  int totalMatches;
  int totalRuns;
  int totalFours;
  int totalSixes;

  FetchedPlayerData({
    required this.playerPhotoUrl,
    required this.playerName,
    required this.playerNickName,
    required this.playerPhone,
    required this.playerEmail,
    required this.playerType,
    required this.playerSubType,
    required this.playerAddress,
    required this.highestScore,
    required this.totalHalfCentury,
    required this.totalFullCentury,
    required this.totalMatches,
    required this.totalRuns,
    required this.totalSixes,
    required this.totalFours,
  });

  factory FetchedPlayerData.fromJson(Map<String, dynamic> jsonData) {
    return FetchedPlayerData(
      playerPhotoUrl: jsonData["playerProfilePhotoUrl"],
      playerName: jsonData["playerName"],
      playerNickName: jsonData["playerNickName"],
      playerPhone: jsonData["playerPhone"],
      playerEmail: jsonData["playerEmail"],
      playerType: jsonData["playerType"],
      playerSubType: jsonData["playerSubType"],
      playerAddress: jsonData["playerAddress"],
      highestScore: jsonData["highestScore"],
      totalFullCentury: jsonData["totalFullCentury"],
      totalHalfCentury: jsonData["totalHalfCentury"],
      totalMatches: jsonData["totalMatches"],
      totalRuns: jsonData["totalRuns"],
      totalFours: jsonData["totalFours"],
      totalSixes: jsonData["totalSixes"],
    );
  }
}
