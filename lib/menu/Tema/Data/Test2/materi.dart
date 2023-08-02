import 'package:flutter/material.dart';
import 'package:project_hallo_ivy/login.dart';
import 'design_course_app_theme.dart';

class MateriPage extends StatefulWidget {
  final UserData userData;
  const MateriPage(
      {super.key,
      required this.userData,
      AnimationController? animationController});
  @override
  State<MateriPage> createState() => _MateriPageState();
}

class _MateriPageState extends State<MateriPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: DesignCourseAppTheme.nearlyWhite,
        title: const Text("List Materi"),
      ),
      body: Container(
        padding: const EdgeInsets.only(bottom: 70),
        child: ListView(
          padding: const EdgeInsets.only(top: 8),
          children: <Widget>[
            for (var i = 0; i < 6; i++)
              CustomCard(
                  title: "Judul Game",
                  image:
                      "https://i0.wp.com/www.gimbot.com/wp-content/uploads/2022/11/Gaming_1-1.png?fit=1200%2C628&ssl=1"),
          ],
        ),
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
            InkWell(
              onTap: () {
                debugPrint('Card tapped.');
              },
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                        image,
                      ),
                      fit: BoxFit.cover),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5.0),
                    topRight: Radius.circular(5.0),
                  ),
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
