import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MatchInfo extends StatefulWidget {
  const MatchInfo({super.key});

  @override
  State<MatchInfo> createState() => _MatchInfoState();
}

class _MatchInfoState extends State<MatchInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Container(
             margin: const EdgeInsets.only(top: 5),
             color: Colors.grey,
             alignment: Alignment.centerLeft,
             child: const Padding(
               padding: EdgeInsets.only(left: 8.0,top: 4,bottom: 4),
               child: Text(
                  'INFO',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
             ),
           ),
          Container(
            child: _rowBuilder('Match', '1st CAPL T20'),
          ),
          Container(
            child: _rowBuilder('Series', '1st Internship competition'),
          ),
          Container(
            child: _rowBuilder('Date', '15 Aug'),
          ),
          Container(
            child: _rowBuilder('Time', '1:00 pm'),
          ),
          Container(
            child: _rowBuilder('Toss', 'Team Mobile'),
          ),
          Container(
            child: _rowBuilder('Referee', 'Abhishek Jha'),
          ),
          Container(
            margin: const EdgeInsets.only(top: 5),
            color: Colors.grey,
            alignment: Alignment.centerLeft,
            child: const Padding(
              padding: EdgeInsets.only(left: 8.0,top: 4,bottom: 4),
              child: Text(
                'VENUE GUIDE',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            child: _rowBuilder('Stadium', 'Patliputra Stadium'),
          ),
          Container(
            child: _rowBuilder('Stadium Address', 'Kankarbagh near Jay prabha Medanta'),
          ),
          Container(
            child: _rowBuilder('Stadium City', 'Patna'),
          ),
        ],
      ),
    );
  }
  Widget _rowBuilder(String text, String text2){
    return Padding(
      padding: const EdgeInsets.only(top: 10.0,bottom: 10.0,left: 20,right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           Text(
             text,
             style: const TextStyle(
               color: Colors.black,
               fontSize: 17,
               fontWeight: FontWeight.w500,
             ),
           ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 51.0),
              child: Text(
                text2,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
