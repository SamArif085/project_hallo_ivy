import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Module/bottom_navigation_view/bottom_bar_view.dart';
import 'play_quiz.dart';


class QuizMenu extends StatefulWidget {
  const QuizMenu({
    super.key,
    AnimationController? animationController,
  });

  @override
  State<QuizMenu> createState() => _QuizMenuState();
}

class _QuizMenuState extends State<QuizMenu> {
  // ignore: non_constant_identifier_names
  List<Map<String, dynamic>> MateriPerTema = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: HexColor('#85f29d'),
        // backgroundColor: DesignCourseAppTheme.nearlyWhite,
        title: const Padding(
          padding: EdgeInsets.only(right: 50),
          child: Center(child: Text('Quiz')),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(color: HexColor('#85f29d')),
        child: FutureBuilder(
          future: fetchUserMaterials(), // Fetch the user's materials
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(); // Show loading indicator
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              // Populate MateriPerTema with fetched data
              MateriPerTema = snapshot.data as List<Map<String, dynamic>>;
              return ListView.builder(
                padding: const EdgeInsets.only(top: 20),
                itemCount: MateriPerTema.length,
                itemBuilder: (context, index) {
                  var materi = MateriPerTema[index];
                  return CustomCard(
                    key: Key(materi['id'].toString()),
                    title: materi['judul_materi'],
                    status: "1",
                    image: materi["gambar_materi"],
                    materi: materi['link_materi'],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlayQuiz(
                            materi: materi,
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  // Replace this with your actual fetching logic
  Future<List<Map<String, dynamic>>> fetchUserMaterials() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userDataString = preferences.getString('userData');
    if (userDataString != null) {
      Map<String, dynamic> userData = jsonDecode(userDataString);
      // Assuming "materi_user" is the key for user's materials
      return userData['values']['materi_user'].cast<Map<String, dynamic>>();
    } else {
      return []; // Return an empty list if no user data is found
    }
  }
}

// ignore: must_be_immutable
class CustomCard extends StatelessWidget {
  final VoidCallback onTap;

  CustomCard({
    Key? key,
    required this.title,
    required this.image,
    required this.status,
    required this.onTap,
    required this.materi,
  }) : super(key: key);

  String title;
  String materi;
  String status;
  String image;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 30, left: 30, bottom: 10),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        elevation: 7,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: onTap,
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(image), // Use a placeholder image URL
                    fit: BoxFit.cover,
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5.0),
                    topRight: Radius.circular(5.0),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                  top: 10, bottom: 10, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    child: status == "1"
                        ? Image.asset(
                            'assets/icon/unlock_icon.png',
                            height: 20,
                          )
                        : Image.asset(
                            'assets/icon/lock_icon.png',
                            height: 20,
                          ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
