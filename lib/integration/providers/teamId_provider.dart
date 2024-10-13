import 'package:flutter/cupertino.dart';
import '../response_classes/team_response.dart';

class TeamIdProvider with ChangeNotifier {

  TeamId? _teamId;

  TeamId? get teamId => _teamId;

  void updateTeamIdResponse(TeamId teamId) {
    _teamId = teamId;
    notifyListeners();
  }
}