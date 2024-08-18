
import 'package:flutter/material.dart';
import 'package:merge_capl/ayush/result_section/tab/score_board_screen.dart';
import 'package:merge_capl/ayush/result_section/tab/squads_screen.dart';

import 'match_info_screen.dart';

class MemberScreen1 extends StatefulWidget {

  @override
  State<MemberScreen1> createState() => _MemberScreen1State();
}

class _MemberScreen1State extends State<MemberScreen1> {
  @override
  Widget build(BuildContext context) {
    final List<Widget> tabs = [
      const MatchInfo(),
       ScorecardScreen(),
       SquadsScreen()
    ];
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Color(0xFF3b3b6d),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          bottom: TabBar(
            tabs: const [
             Tab(
                text: 'Match INFO',
              ),
              Tab(
                text: 'Score Card',
              ),
              Tab(
                text: "Squads",
              ),
            ],
            labelStyle: TextStyle(
                color: Colors.orange.shade900,
              fontWeight: FontWeight.w700
            ),
            unselectedLabelColor: const Color(0xFF3b3b6d),
          ),
        ),
        body: TabBarView(
          children: tabs,
        ),
      ),
    );
  }
}