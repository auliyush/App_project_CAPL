import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:merge_capl/start/Login.dart';
import 'CompletedPage.dart';
import 'LivePage.dart';
import 'UpcomingPage.dart';

class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isLiveHovering = false;
  bool _isUpcomingHovering = false;
  bool _isCompletedHovering = false;

  bool _isLiveSelected = true;
  bool _isUpcomingSelected = false;
  bool _isCompletedSelected = false;
  @override
  Widget build(BuildContext context) {
    return
      DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            // leading: IconButton(
            //   onPressed: (){
            //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
            //   },
            //   icon: Icon(Icons.arrow_back_ios, color: Colors.grey,),
            // ),
            bottom: TabBar(
              tabs: [
                MouseRegion(
                  onEnter: (event) {
                    setState(() {
                      _isLiveHovering = true;
                    });
                  },
                  onExit: (event) {
                    setState(() {
                      _isLiveHovering = false;
                    });
                  },
                  child: Tab(
                    child: Text(
                      "Live",
                      style: TextStyle(
                        color: _isLiveSelected ? Colors.blue.shade800 : Colors.black,
                        fontWeight: FontWeight.w900,
                        fontSize: _isLiveHovering ? 20 : 20,
                      ),
                    ),
                  ),
                ),
                MouseRegion(
                  onEnter: (event) {
                    setState(() {
                      _isUpcomingHovering = true;
                    });
                  },
                  onExit: (event) {
                    setState(() {
                      _isUpcomingHovering = false;
                    });
                  },
                  child: Tab(
                    child: Text(
                      "Upcoming",
                      style: TextStyle(
                        color: _isUpcomingSelected ? Colors.blue.shade800 : Colors.black,
                        fontWeight: FontWeight.w900,
                        fontSize: _isUpcomingHovering ? 20 : 15,
                      ),
                    ),
                  ),
                ),
                MouseRegion(
                  onEnter: (event) {
                    setState(() {
                      _isCompletedHovering = true;
                    });
                  },
                  onExit: (event) {
                    setState(() {
                      _isCompletedHovering = false;
                    });
                  },
                  child: Tab(
                    child: Text(
                      "Completed",
                      style: TextStyle(
                        color: _isCompletedSelected ? Colors.blue.shade800 : Colors.black,
                        fontWeight: FontWeight.w900,
                        fontSize: _isCompletedHovering ? 20 : 15,
                      ),
                    ),
                  ),
                ),

              ],
              onTap: (index) {
                setState(() {
                  _isLiveSelected = index == 0;
                  _isUpcomingSelected = index == 1;
                  _isCompletedSelected = index == 2;
                });
              },
            ),
          ),
          body: const TabBarView(
            children: [
              LivePage(),
             UpcomingPage(),
              CompletedPage(),
            ],
          ),
        ),
      );
  }
}