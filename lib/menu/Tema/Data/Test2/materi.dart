import 'package:flutter/material.dart';
import 'package:project_hallo_ivy/login.dart';
import 'package:project_hallo_ivy/menu/Tema/Data/Test2/testmateri.dart';
import '../Test/bottom_navigation_view/bottom_bar_view.dart';
import 'video_screen.dart';

class MateriPage extends StatefulWidget {
  void navigateToDetail(BuildContext context, MateriUser materi) {
    // Navigasi ke halaman detail dan kirim data materi yang dipilih
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoScreen(
          userData: userData,
          userDataMateri: materi,
        ),
      ),
    );
  }

  final UserData userData;
  final List<MateriUser> userDataMateri;
  const MateriPage(
      {super.key,
      required this.userData,
      AnimationController? animationController, 
      required this.userDataMateri,
      });

  @override
  State<MateriPage> createState() => _MateriPageState();
}

class _MateriPageState extends State<MateriPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: HexColor('#85f29d'),
        // backgroundColor: DesignCourseAppTheme.nearlyWhite,
        title: const Padding(
          padding: EdgeInsets.only(right: 50),
          child: Center(child: Text('Materi')),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(color: HexColor('#85f29d')),
        child: ListView(
          padding: const EdgeInsets.only(top: 20),
          children: <Widget>[
            for (var materi in widget.userData.values.materiuser)
              CustomCard(
                key: Key(materi.id),
                title: materi.judulMateri,
                status: "1",
                image:
                    "https://i0.wp.com/www.gimbot.com/wp-content/uploads/2022/11/Gaming_1-1.png?fit=1200%2C628&ssl=1",
                userData: widget.userData,
                onTap: () {
                  widget.navigateToDetail(context, materi );
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
  // void navigateToDetail(
  //   BuildContext context,
  //   LinkMateri id,
  // ) {
  //   // Navigasi ke halaman detail dan kirim data materi yang dipilih
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => TestMateri(
  //         userData: userData,
  //         userDataMateri: id,
  //       ), // Ganti DetailPage dengan nama halaman detail Anda
  //     ),
  //   );
  // }

  CustomCard({
    Key? key,
    required this.title,
    required this.image,
    required this.status,
    required this.userData,
    required this.onTap,
  }) : super(key: key);
  final UserData userData;
  String title;
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
            Container(
              // decoration: BoxDecoration(color: HexColor('#85f29d')),
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
