// ignore_for_file: must_be_immutable
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hello_ivy_test/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Module/bottom_navigation_view/bottom_bar_view.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({
    Key? key,
  }) : super(key: key);
  Future<void> _logout(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('userData');
    Fluttertoast.showToast(
        msg: "Logout Successful",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.amber,
        textColor: Colors.white,
        fontSize: 16.0);

    // ignore: use_build_context_synchronously
    Navigator.push(context, MaterialPageRoute(builder: (context) => const Login()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: HexColor('#85f29d'),
        title: const Padding(
          padding: EdgeInsets.only(left: 50),
          child: Center(child: Text('Profile')),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: FutureBuilder(
        future: fetchUserData(), // Fetch user data from SharedPreferences
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            Map<String, dynamic> userData =
                snapshot.data as Map<String, dynamic>;
            return Container(
              padding: const EdgeInsets.only(bottom: 70),
              child: ListView(
                children: [
                  userBar(nama: userData['nama']),
                  buildInfo(label: "NISN", value: userData['nisn_siswa']),
                  buildInfo(label: "Kelas", value: userData['kelas']),
                  buildInfo(
                      label: "Jenis Kelamin", value: userData['jenis_kelamin']),
                  buildInfo(
                      label: "Nama Orang Tua", value: userData['nama_ortu']),
                  buildInfo(label: "Alamat", value: userData['alamat_ortu']),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Future<Map<String, dynamic>> fetchUserData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userDataString = preferences.getString('userData');
    if (userDataString != null) {
      Map<String, dynamic> userData = jsonDecode(userDataString);
      return userData['values'];
    } else {
      return {}; // Return an empty map if no user data is found
    }
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
  final String label;
  final String value;

  const buildInfo({
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
