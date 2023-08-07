import 'dart:io';
import 'package:flutter/material.dart';
import 'package:project_hallo_ivy/login.dart';
import 'package:project_hallo_ivy/menu/Tema/Data/Test/bottom_navigation_view/bottom_bar_view.dart';

class PRHome extends StatelessWidget {
  const PRHome({super.key, required this.userData, required this.dataTugas});
  final UserData userData;
  final List<Linktugasrumah> dataTugas; // Perubahan pada bagian ini

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // title: const Text('PR'),
        backgroundColor: HexColor('#85f29d'),
      ),
      body: Container(
        decoration: BoxDecoration(color: HexColor('#85f29d')),
        child: Center(
          child: Container(
            width: 350.0,
            height: 350.0,
            padding: const EdgeInsets.all(16.0),
            child: CustomCard(
              title: userData.tugasRumah[0].judulPr, // Tambahkan judul yang sesuai di sini
              text:
                 userData.tugasRumah[0].deskripsi,
              deadln: userData.tugasRumah[0].tenggat,
            ),
          ),
        ),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  CustomCard({super.key, required this.title, required this.text, required this.deadln});
  String title;
  String text;
  String deadln;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      elevation: 7,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(
            flex: 1,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  text,
                  textAlign: TextAlign.start,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  deadln,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
