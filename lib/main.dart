import 'package:flutter/material.dart';
import 'package:merge_capl/hold_models/player_list_model.dart';
import 'package:merge_capl/splashScreen.dart';
import 'package:provider/provider.dart';

import 'integration/providers/login_provider.dart';
import 'integration/providers/teamId_provider.dart';
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(create: (context) => ListModel()),
        ChangeNotifierProvider(create: (context) => TeamIdProvider()), // Add this line
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: SplashScreen(),
    );
  }
}


