import 'package:flutter/material.dart';
import 'package:project_hallo_ivy/menu/Tema/Data/Test/bottom_navigation_view/bottom_bar_view.dart';
import 'design_course_app_theme.dart';

class PRHome extends StatelessWidget {
  const PRHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PR'),
        backgroundColor: DesignCourseAppTheme.nearlyWhite,
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 8),
        children: <Widget>[
          // for (var i = 0; i < 1; i++)
          CustomCard(
              title: "Tugas Rumah",
              text:
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin dapibus diam sit amet nibh sollicitudin hendrerit sed quis est. Cras accumsan consequat faucibus. Nullam ornare, ipsum eu convallis bibendum, metus lorem laoreet lectus, id vehicula lorem orci nec orci. Suspendisse potenti. Proin laoreet",
              deadln: "31 Desember 2022"),
        ],
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
    return Padding(
      padding: const EdgeInsets.only(top: 30, right: 30, left: 30),
      child: Card(
        color: HexColor('#85f29d'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0), //<-- SEE HERE
        ),
        elevation: 7,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(5.0),
                  topRight: Radius.circular(5.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  text,
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            Container(
              // color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  deadln,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.red,

                    // fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
