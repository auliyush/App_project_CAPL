import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:merge_capl/UpcomingPage.dart';
import 'CompletedPage.dart';
import 'LivePage.dart';

class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isLiveHovering = false;
  bool _isUpcomingHovering = false;
  bool _isCompletedHovering = false;

  @override
  Widget build(BuildContext context) {
    return
      DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            // backgroundColor: Colors.grey.shade500,
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
                        fontWeight: FontWeight.w900,
                        fontSize: _isCompletedHovering ? 20 : 15,
                      ),
                    ),
                  ),
                ),
              ],
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