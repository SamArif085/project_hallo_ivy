import 'package:flutter/material.dart';
import 'package:project_hallo_ivy/menu/Tema/Data/VideoApp3.dart';
import 'login.dart';
import 'BasePage.dart';
import 'menu/Tema/Data/VideoApp.dart';
import 'menu/Tema/Data/VideoApp2.dart';
import 'menu/Tema/Game/Game1.dart';
import 'menu/Tema/Konten.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    LoginPage.tag: (context) => LoginPage(),
    BasePage.tag: (context) => const BasePage(),
    Konten.tag: (context) => const Konten(),
    VideoApp.tag: (context) => const VideoApp(),
    VideoApp2.tag: (context) => const VideoApp2(),
    VideoApp3.tag: (context) => const VideoApp3(),
    Game1.tag: (context) => Game1(),
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
