class ResultEntity{
  final String matchDate;
  final String firstTeamImageUrl;
  final String secondTeamImageUrl;
  final String firstTeamNickName;
  final String manOfTheMatchName;
  final int firstTeamRuns;
  final int firstTeamWickets;
  final String secondTeamNickName;
  final int secondTeamRuns;
  final int secondTeamWickets;

  const ResultEntity({

    required this.matchDate,
    required this.firstTeamImageUrl,
    required this.secondTeamImageUrl,
    required this.firstTeamNickName,
    required this.firstTeamRuns,
    required this.firstTeamWickets,
    required this.secondTeamNickName,
    required this.secondTeamRuns,
    required this.secondTeamWickets,
    required this.manOfTheMatchName,
  });

  static List<ResultEntity> resultsList(){
    return[
     const ResultEntity(
          matchDate: '30 july',
          firstTeamImageUrl: 'assets/images/bg.jpg',
          secondTeamImageUrl: 'assets/images/bg.jpg',
          firstTeamNickName: 'WI',
          firstTeamRuns: 120,
          firstTeamWickets: 4,
          secondTeamNickName: 'MI',
          secondTeamRuns: 245,
          secondTeamWickets: 6,
       manOfTheMatchName: 'Rahul Gandhi',
      ),
      const ResultEntity(
        matchDate: '30 july',
        firstTeamImageUrl: 'assets/images/bg.jpg',
        secondTeamImageUrl: 'assets/images/bg.jpg',
        firstTeamNickName: 'WI',
        firstTeamRuns: 220,
        firstTeamWickets: 4,
        secondTeamNickName: 'MI',
        secondTeamRuns: 145,
        secondTeamWickets: 6,
        manOfTheMatchName: 'Rahul Gandhi',
      ),
      const ResultEntity(
        matchDate: '30 july',
        firstTeamImageUrl: 'assets/images/bg.jpg',
        secondTeamImageUrl: 'assets/images/bg.jpg',
        firstTeamNickName: 'WI',
        firstTeamRuns: 120,
        firstTeamWickets: 4,
        secondTeamNickName: 'MI',
        secondTeamRuns: 120,
        secondTeamWickets: 6,
        manOfTheMatchName: 'Rahul Gandhi',
      ),
      const ResultEntity(
        matchDate: '30 july',
        firstTeamImageUrl: 'assets/images/bg.jpg',
        secondTeamImageUrl: 'assets/images/bg.jpg',
        firstTeamNickName: 'WI',
        firstTeamRuns: 120,
        firstTeamWickets: 4,
        secondTeamNickName: 'MI',
        secondTeamRuns: 120,
        secondTeamWickets: 6,
        manOfTheMatchName: 'Rahul Gandhi',
      ),
    ];
  }
}