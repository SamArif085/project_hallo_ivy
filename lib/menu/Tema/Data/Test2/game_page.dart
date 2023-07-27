import 'package:flutter/material.dart';

import 'package:project_hallo_ivy/login.dart';

import 'design_course_app_theme.dart';

class GamePage extends StatelessWidget {
  final UserData userData;

  const GamePage(
      {super.key,
      required this.userData,
      AnimationController? animationController});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: DesignCourseAppTheme.nearlyWhite,
        title: null,
      ),
      body: ListView(
        children: [
          CustomCard(
              title: "Judul Card Pertama",
              image:
                  "https://images7.alphacoders.com/131/thumbbig-1311796.webp"),
          CustomCard(
              title: "Judul Card Kedua",
              image:
                  "https://images7.alphacoders.com/131/thumbbig-1311796.webp"),
        ],
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  CustomCard({super.key, required this.title, required this.image});
  String title;
  String image;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0), //<-- SEE HERE
        ),
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                      image,
                    ),
                    fit: BoxFit.cover),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(5.0),
                  topRight: Radius.circular(.0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
