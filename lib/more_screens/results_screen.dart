
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:merge_capl/more_screens/result_section/result_card.dart';
import 'package:merge_capl/more_screens/result_section/result_entity.dart';

class ResultScreen extends StatefulWidget {
  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final results = ResultEntity.resultsList();
  List<ResultEntity> _resultsList = [];

  @override
  void initState() {
    _resultsList = results;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF3b3b6d),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          Opacity(
            opacity: 0.8,
           child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/trofeeimg.jpg'),
                  fit: BoxFit.cover, // <--- Fit the image to cover the entire widget
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                for (ResultEntity resultEntity in results)
                  ResultCard(resultEntity: resultEntity)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
