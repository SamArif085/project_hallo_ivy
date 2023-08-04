import 'package:flutter/material.dart';
import 'package:project_hallo_ivy/login.dart';
import 'package:project_hallo_ivy/menu/Tema/Data/Game/TestGame.dart';
import 'design_course_app_theme.dart';

class GamePage extends StatefulWidget {
  void navigateToDetail(BuildContext context, LinkGame game) {
    // Navigasi ke halaman detail dan kirim data materi yang dipilih
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GameTest(
         userData: userData,
          dataGame: game,
        ),
      ),
    );
  }

  final UserData userData;
  final List<LinkMateri> userDataMateri;
  final List<LinkGame> dataGame;
  const GamePage(
      {super.key,
      required this.userData,
      AnimationController? animationController,
      required this.userDataMateri,
      required this.dataGame});
  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: DesignCourseAppTheme.nearlyWhite,
        title: const Text("List Game"),
      ),
      body: Container(
        padding: const EdgeInsets.only(bottom: 62),
        child: ListView(
          padding: const EdgeInsets.only(top: 8),
          children: <Widget>[
            for (var game in widget.dataGame)
              CustomCard(
                key: Key(game.id),
                title: game.namaGame,
                image:
                    "https://i0.wp.com/www.gimbot.com/wp-content/uploads/2022/11/Gaming_1-1.png?fit=1200%2C628&ssl=1",
                userData: widget.userData,
                onTap: () {
                  widget.navigateToDetail(context, game);
                },
              ),
          ],
        ),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final VoidCallback onTap;
  final UserData userData;
  CustomCard({
    super.key,
    required this.title,
    required this.image,
    required this.onTap,
    required this.userData,
  });

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
              onTap: onTap,
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
