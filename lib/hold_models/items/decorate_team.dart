import 'package:flutter/material.dart';
import 'package:merge_capl/hold_models/items/team_data.dart';

import '../../teams/member_screen.dart';

class DecorateTeam extends StatelessWidget{
  final TeamData teamData;

  const DecorateTeam({
    super.key, required this.teamData,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0,bottom: 8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          surfaceTintColor: Colors.white,
          foregroundColor: Colors.grey,
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 16.0,bottom: 16,left: 0,right: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage('${teamData.teamProfileUrl}') ,
              ),
              SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text(
                    //   '${teamData.teamId}',
                    //   style: TextStyle(
                    //     fontWeight: FontWeight.bold,
                    //     fontSize: 19,
                    //     color: Colors.black,
                    //   ),
                    // ),
                    Text(
                      '${teamData.teamName}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 19,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      '${teamData.teamNickName}',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => MemberScreen(teamData:teamData)));
        },
      ),
    );
  }

}