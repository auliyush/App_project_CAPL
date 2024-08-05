import 'package:flutter/material.dart';
import 'package:merge_capl/hold_models/player_list_model.dart';
import 'package:provider/provider.dart';
import 'fuck.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => ListModel(),
      child: const MyApp()
  )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Pages(),
    );
  }
}


