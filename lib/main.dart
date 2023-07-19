import 'package:flutter/material.dart';
import 'login.dart';
// import 'BasePage.dart';
import 'menu/Tema/Data/Quiz/Quiz.dart';
import 'menu/Tema/Data/Test/Test.dart';
import 'menu/Tema/Data/Video/VideoApp.dart';
import 'menu/Tema/Data/Game/Game1.dart';
import 'menu/Tema/Konten.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    // BasePage.tag: (context) => const BasePage(),
    Konten.tag: (context) => const Konten(),
    VideoApp.tag: (context) => const VideoApp(),
    Game1.tag: (context) => Game1(),
    Quiz.tag: (context) => const Quiz(),
    FitnessAppHomeScreen.tag: (context) => const FitnessAppHomeScreen(),
  };
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kodeversitas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        fontFamily: 'Nunito',
      ),
      home: LoginPage(),
      routes: routes,
    );
  }
}
