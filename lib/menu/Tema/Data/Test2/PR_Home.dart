import 'package:flutter/material.dart';
import 'package:project_hallo_ivy/menu/Tema/Data/Test/bottom_navigation_view/bottom_bar_view.dart';
import 'design_course_app_theme.dart';

class PRHome extends StatelessWidget {
  const PRHome({super.key});

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
            padding: EdgeInsets.all(16.0),
            child: CustomCard(
                title: "Tugas Rumah",
                text:
                    "Lorem ipsum dolor silicitudin hendrerit sed quis est. Cras accumsan consequat faucibus. Nullam ornare, ipsum eu convallis bibendum, metus lorem laoreet lectehicula lorem orci nec orci. Suspendisse potenti. Proin laoreet",
                deadln: "31 Desember 2022"),
          ),
        ),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  CustomCard(
      {super.key,
      required this.title,
      required this.text,
      required this.deadln});
  String title;
  String text;
  String deadln;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0), //<-- SEE HERE
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
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  text,
                  textAlign: TextAlign.justify,
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
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
    // );
  }
}
