import 'package:flutter/material.dart';
import 'package:project_hallo_ivy/login.dart';
import 'package:project_hallo_ivy/menu/Tema/Data/Test2/laporantema.dart';
// import '../Test/bottom_navigation_view/bottom_bar_view.dart';
import 'design_course_app_theme.dart';

class LaporanList extends StatefulWidget {
  void navigateToDetail(BuildContext context, LinkMateri materi) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LaporanHome(
          userData: userData,
          userDataMateri: materi,
        ),
      ),
    );
  }

  final UserData userData;
  final List<LinkMateri> userDataMateri;
  const LaporanList(
      {super.key,
      required this.userData,
      AnimationController? animationController,
      required this.userDataMateri});

  @override
  State<LaporanList> createState() => _LaporanListState();
}

class _LaporanListState extends State<LaporanList> {
  @override
  Widget build(BuildContext context) {
    print(widget.userDataMateri.length);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: DesignCourseAppTheme.nearlyWhite,
        title: Text('Laporan'),
      ),
      body: Container(
        decoration: BoxDecoration(color: DesignCourseAppTheme.nearlyWhite),
        child: ListView(
          padding: const EdgeInsets.only(top: 8),
          children: <Widget>[
            for (var materi in widget.userDataMateri)
              // if (materi.status == "1")
              CustomCard(
                key: Key(materi.id),
                title: materi.judulMateri,
                status: "1",
                image:
                    "https://i0.wp.com/www.gimbot.com/wp-content/uploads/2022/11/Gaming_1-1.png?fit=1200%2C628&ssl=1",
                userData: widget.userData,
                onTap: () {
                  widget.navigateToDetail(context, materi);
                },
              ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
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
              child: Center(
                child: Text(
                  title,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
