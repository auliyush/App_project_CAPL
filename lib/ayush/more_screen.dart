
import 'package:flutter/material.dart';
import 'package:merge_capl/ayush/results_screen.dart';

import 'about_us.dart';
import 'account_screen.dart';
import 'feedback_screen.dart';

class MorePage extends StatefulWidget {
  const MorePage({super.key});

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text('More'),
      ),

      body: SingleChildScrollView(
        child:
        Column(
          children: [
            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                surfaceTintColor: Colors.white,
                foregroundColor: Colors.grey,
              ),
                onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => AccountPage(
                    playerPhotoUrl: 'assets/images/profile.webp',
                    playerName: 'Rahul',
                    playerMobNumber: '74638900034',
                    playerEmail: 'playerEmail',
                    playerGender: 'Male')));
                },
                child: _card_builder('Account'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                surfaceTintColor: Colors.white,
                foregroundColor: Colors.grey,
              ),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => ResultScreen()));
              },
              child: _card_builder('Results'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                surfaceTintColor: Colors.white,
                foregroundColor: Colors.grey,
              ),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => AboutUsScreen()));

              },
              child: _card_builder('About Us'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                surfaceTintColor: Colors.white,
                foregroundColor: Colors.grey,
              ),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => FeedBackScreen()));
              },
              child: _card_builder('FeedBack'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _card_builder(String text){
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Padding(
          padding: EdgeInsets.only(top: 16.0,bottom: 16,left: 0,right: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      text,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 19,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
    );
      // child: ElevatedButton(
      //   style: ElevatedButton.styleFrom(
      //     backgroundColor: Colors.white,
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.zero,
      //     ),
      //     surfaceTintColor: Colors.white,
      //     foregroundColor: Colors.grey,
      //   ),
      //   child: Text(
      //       text,
      //     style: TextStyle(
      //       color: Colors.blue
      //     ),
      //   ),
      //   onPressed: (){},
      // ),

  }
}
