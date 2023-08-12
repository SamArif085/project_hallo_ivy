// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_hallo_ivy/login.dart';
import '../Test/bottom_navigation_view/bottom_bar_view.dart';

class UserProfilePage extends StatelessWidget {
  final UserData userData;
  const UserProfilePage({Key? key, required this.userData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor('#85f29d'),
        title: const Padding(
          padding: EdgeInsets.only(left: 50),
          child: Center(child: Text('Profile')),
        ),
        actions: const [
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.red,
            ),
            onPressed: _logout,
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(bottom: 70),
        child: ListView(
          children: [
            userBar(
              nama: userData.values.nama,
            ),
            buildInfo(
              label: "NISN",
              value: userData.values.nisnSiswa,
            ),
            buildInfo(
              label: "Kelas",
              value: userData.values.kelas,
            ),
            buildInfo(
              label: "Jenis Kelamin",
              value: userData.values.seks,
            ),
            buildInfo(
              label: "Nama Orang Tua",
              value: userData.values.ortu,
            ),
            buildInfo(
              label: "Alamat",
              value: userData.values.alamat,
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class userBar extends StatelessWidget {
  String nama;
  userBar({super.key, required this.nama});
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.only(bottom: 35),
      width: screenWidth * 1,
      height: 200,
      decoration: const BoxDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Flexible(
          //   flex: 1,
          //   child: IconButton(
          //     icon: const Icon(
          //       Icons.logout,
          //       color: Colors.red,
          //     ),
          //     onPressed: _logout,
          //   ),
          // ),
          Flexible(
            flex: 3,
            child: Center(
              child: Image.asset('assets/design_course/userImage.png'),
            ),
          ),
          Flexible(
            flex: 1,
            child: Center(
              child: Text(
                nama,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
            ),
          )
        ],
      ),
    );
  }
}

// ignore: camel_case_types
class buildInfo extends StatelessWidget {
  String label;
  String value;
  buildInfo({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: const EdgeInsets.only(
                  left: 40,
                ),
                child: Text(
                  label,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                )),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 40, right: 40, top: 15, bottom: 15),
                child: Stack(
                  children: [
                    Container(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            value,
                            style: const TextStyle(color: Colors.black),
                          ),
                        )),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 2.0,
                        color: HexColor('#f0f1f2'),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}

void _logout() {
  Get.off(() => LoginPage());
  Get.delete<LoginController>();
}
