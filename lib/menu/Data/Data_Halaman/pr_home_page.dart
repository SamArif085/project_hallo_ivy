// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Module/bottom_navigation_view/bottom_bar_view.dart';

class PRHome extends StatefulWidget {
  const PRHome({Key? key}) : super(key: key);

  @override
  _PRHomeState createState() => _PRHomeState();
}

class _PRHomeState extends State<PRHome> {
  late Future<List<Map<String, dynamic>>> userMaterials;

  @override
  void initState() {
    super.initState();
    userMaterials = fetchUserMaterials();
  }

  Future<List<Map<String, dynamic>>> fetchUserMaterials() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userDataString = preferences.getString('userData');
    if (userDataString != null) {
      Map<String, dynamic> userData = jsonDecode(userDataString);
      // Assuming "tugas_rumah" is the key for user's homework
      return userData['tugas_rumah'].cast<Map<String, dynamic>>();
    } else {
      return []; // Return an empty list if no user data is found
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(right: 55),
          child: Center(
              child: Text(
            'PR',
            style: TextStyle(
              color: Colors.white,
            ),
          )),
        ),
        elevation: 0,
        backgroundColor: Colors.redAccent,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: userMaterials,
        builder: (BuildContext context,
            AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            ); // Show loading indicator while fetching data
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<Map<String, dynamic>>? userMaterials = snapshot.data
                ?.where((material) => material['status'] == 'selesai')
                .toList();
            List<Map<String, dynamic>>? activeMaterials = snapshot.data
                ?.where((material) => material['status'] == 'aktif')
                .toList();
            return Container(
              decoration: BoxDecoration(color: Colors.redAccent),
              child: ListView(
                children: [
                  const Center(
                    child: Text(
                      '- - - Terbaru - - -',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (activeMaterials!.isEmpty)
                    Center(
                      child: Container(
                        width: 350.0,
                        height: 100.0,
                        padding: const EdgeInsets.fromLTRB(16, 5, 10, 10),
                        child: CustomCard(
                          title: '',
                          text: 'Belum Ada PR',
                          deadln: '',
                        ),
                      ),
                    ),
                  for (var material in activeMaterials)
                    Center(
                      child: Container(
                        width: 350.0,
                        height: 300.0,
                        padding: const EdgeInsets.fromLTRB(16, 5, 10, 0),
                        child: CustomCard(
                          title: material['judulPr'],
                          text: material['deskripsi'],
                          deadln: material['tenggat'],
                        ),
                      ),
                    ),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 16, top: 16),
                      child: const Text(
                        '- - - Riwayat - - -',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  if (userMaterials!.isEmpty)
                    Center(
                      child: Container(
                        width: 350.0,
                        height: 100.0,
                        padding: const EdgeInsets.fromLTRB(16, 5, 10, 10),
                        child: CustomCard(
                          title: '',
                          text: 'Belum Ada Riwayat PR',
                          deadln: '',
                        ),
                      ),
                    ),
                  for (var material in userMaterials)
                    Center(
                      child: Container(
                        width: 350.0,
                        height: 300.0,
                        padding: const EdgeInsets.fromLTRB(16, 5, 10, 0),
                        child: CustomCard(
                          title: material['judulPr'],
                          text: material['deskripsi'],
                          deadln: material['status'],
                        ),
                      ),
                    ),
                ],
              ),
            );
          }
        },
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
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      elevation: 7,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(
            flex: 1,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  text,
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  deadln,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
