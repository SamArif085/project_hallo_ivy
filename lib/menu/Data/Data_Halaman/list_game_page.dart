import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Game/game_page.dart';
import '../Module/bottom_navigation_view/bottom_bar_view.dart';
import 'color_Theme.dart';

class ListGamePage extends StatefulWidget {
  const ListGamePage({
    super.key,
    AnimationController? animationController,
  });
  @override
  State<ListGamePage> createState() => _ListGamePageState();
}

class _ListGamePageState extends State<ListGamePage> {
  List<Map<String, dynamic>> linkMateriFull = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: DesignCourseAppTheme.nearlyWhite,
        title: const Center(
            child: Text("List Game", style: TextStyle(color: Colors.black))),
      ),
      body: Container(
        decoration: BoxDecoration(color: HexColor('#ffffff')),
        child: FutureBuilder(
          future: fetchUserMaterials(), // Fetch the user's materials
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              ); // Show loading indicator
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              // Populate linkMateriFull with fetched data
              linkMateriFull = snapshot.data as List<Map<String, dynamic>>;
              print('linkMateriFull: $linkMateriFull');
              return ListView.builder(
                padding: const EdgeInsets.only(top: 20, bottom: 60),
                itemCount: linkMateriFull.length,
                itemBuilder: (context, index) {
                  var materi = linkMateriFull[index];
                  return CustomCard(
                    key: Key(materi['id'].toString()),
                    image: materi["gambar_game"],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GamePage(
                            materi: materi,
                          ),
                        ),
                      );
                    },
                    dataGame: materi['nama_game'],
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  Future<List<Map<String, dynamic>>> fetchUserMaterials() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userDataString = preferences.getString('userData');
    if (userDataString != null) {
      Map<String, dynamic> userData = jsonDecode(userDataString);
      return userData['link_game'].cast<Map<String, dynamic>>();
    } else {
      return [];
    }
  }
}

// ignore: must_be_immutable
class CustomCard extends StatelessWidget {
  final VoidCallback onTap;

  String dataGame;
  CustomCard({
    super.key,
    required this.image,
    required this.onTap,
    required this.dataGame,
  });

  // String title;
  String image;
  @override
  Widget build(BuildContext context) {
    double sizedHeight = MediaQuery.of(context).size.width > 600 ? 230 : 130;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, right: 30, left: 30),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0), //<-- SEE HERE
        ),
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: onTap,
              child: Container(
                height: sizedHeight,
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
                  dataGame,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
