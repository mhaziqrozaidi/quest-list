import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/quest_data.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => QuestData(),
      child: const QuestListApp(),
    ),
  );
}

class QuestListApp extends StatelessWidget {
  const QuestListApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuestList',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        fontFamily: 'Roboto',
        textTheme: const TextTheme(
          displayLarge: TextStyle(  // replaced headline1
            fontSize: 24.0, 
            fontWeight: FontWeight.bold,
            color: Color(0xFF3A3A3A),
          ),
          bodyLarge: TextStyle(  // replaced bodyText1
            fontSize: 16.0,
            color: Color(0xFF3A3A3A),
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
