
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:merge_capl/ayush/result_section/result_entity.dart';
import 'package:merge_capl/ayush/result_section/tab/tab_page.dart';

import '../../teams/member_screen.dart';

class ResultCard extends StatefulWidget {
  final ResultEntity resultEntity;

  const ResultCard({
    super.key,
    required this.resultEntity,
  });

  @override
  State<ResultCard> createState() => _ResultCardState();
}

class _ResultCardState extends State<ResultCard> {

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isSmallScreen = constraints.maxWidth < 350;
        return Padding(
          padding: const EdgeInsets.all(6.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white70,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              surfaceTintColor: Colors.white,
              foregroundColor: Colors.grey,
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 11.0, bottom: 30),
              child: isSmallScreen
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.resultEntity.matchDate,
                    style: const TextStyle(
                      color: Colors.black87,
                    ),
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          const SizedBox(height: 21),
                          _buildTeamInfoForSmall(
                            widget.resultEntity.firstTeamImageUrl,
                            widget.resultEntity.firstTeamNickName,
                            widget.resultEntity.firstTeamRuns,
                            widget.resultEntity.firstTeamWickets,
                          ),
                          const SizedBox(height: 20),
                          _buildTeamInfoForSmall(
                            widget.resultEntity.secondTeamImageUrl,
                            widget.resultEntity.secondTeamNickName,
                            widget.resultEntity.secondTeamRuns,
                            widget.resultEntity.secondTeamWickets,
                          ),
                        ],
                      ),
                      const SizedBox(width: 80),
                      _buildWinnerInfoForSmall(widget.resultEntity),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 60),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                            'Man of The Match',
                          style: TextStyle(
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          widget.resultEntity.manOfTheMatchName,
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 27,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
                  : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.resultEntity.matchDate,
                        style: const TextStyle(
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 21),
                      _buildTeamInfo(
                        widget.resultEntity.firstTeamImageUrl,
                        widget.resultEntity.firstTeamNickName,
                        widget.resultEntity.firstTeamRuns,
                        widget.resultEntity.firstTeamWickets,
                      ),
                      const SizedBox(height: 20),
                      _buildTeamInfo(
                        widget.resultEntity.secondTeamImageUrl,
                        widget.resultEntity.secondTeamNickName,
                        widget.resultEntity.secondTeamRuns,
                        widget.resultEntity.secondTeamWickets,
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(top: 0, left: 80),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                                'Man of The Match',
                              style: TextStyle(
                                color: Colors.black87,
                              ),
                            ),
                            Text(
                              widget.resultEntity.manOfTheMatchName,
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 25,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  _buildWinnerInfo(widget.resultEntity),
                ],
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MemberScreen1()),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildTeamInfo(String imageUrl, String teamName, int runs, int wickets) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(imageUrl),
          ),
          const SizedBox(width: 20.0),
              Text(
                teamName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.black,
                ),
              ),
              SizedBox(width: 20),
              Text(
                '$runs - $wickets',
                style: const TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                ),
              ),
        ],
      );

  }
  Widget _buildTeamInfoForSmall(String imageUrl, String teamName, int runs, int wickets) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(imageUrl),
        ),
        const SizedBox(width: 20.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              teamName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            Text(
              '$runs - $wickets',
              style: const TextStyle(
                fontSize: 14.0,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ],
    );

  }

  Widget _buildWinnerInfo(ResultEntity resultEntity) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          _winnerName(resultEntity),
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 21,
          ),
        ),
        Text(
          '${_winnerRun(resultEntity)} Runs',
          style: const TextStyle(
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildWinnerInfoForSmall(ResultEntity resultEntity) {
    return Column(
      children: [
        Text(
          _winnerName(resultEntity),
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 21,
          ),
        ),
        Text(
          '${_winnerRun(resultEntity)} Runs',
          style: const TextStyle(
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  String _winnerName(ResultEntity resultEntity) {
    if (resultEntity.firstTeamRuns > resultEntity.secondTeamRuns) {
      return '${resultEntity.firstTeamNickName} Won \n by';
    } else if (resultEntity.secondTeamRuns > resultEntity.firstTeamRuns) {
      return '${resultEntity.secondTeamNickName} Won \n by';
    } else {
      return 'Match Tie';
    }
  }

  int _winnerRun(ResultEntity resultEntity) {
    if (resultEntity.firstTeamRuns > resultEntity.secondTeamRuns) {
      return resultEntity.firstTeamRuns - resultEntity.secondTeamRuns;
    } else if (resultEntity.secondTeamRuns > resultEntity.firstTeamRuns) {
      return resultEntity.secondTeamRuns - resultEntity.firstTeamRuns;
    } else {
      return 0;
    }
  }
}
