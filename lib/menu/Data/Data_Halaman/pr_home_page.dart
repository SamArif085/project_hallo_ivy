import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/data_pr.dart';

class PRHome extends StatefulWidget {
  const PRHome({super.key});
  @override
  _PRHomeState createState() => _PRHomeState();
}

class _PRHomeState extends State<PRHome> {
  late Future<List<dataPRAktif>> aktifData = Future.value([]);
  late Future<List<dataPRSelesai>> selesaiData = Future.value([]);
  String kodeKelas = '';

  @override
  void initState() {
    super.initState();
    getkodeKelas().then((value) {
      setState(() {
        kodeKelas = value;
        aktifData = getDataPRAktif(kodeKelas);
        selesaiData = getDataPRSelesai(kodeKelas);
      });
    });
  }

  Future<String> getkodeKelas() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userDataString = preferences.getString('userData');
    if (userDataString != null) {
      Map<String, dynamic> userData = jsonDecode(userDataString);
      if (userData['values'] != null &&
          userData['values']['materi_user'][0]['kode_kelas'] != null) {
        String kodeKelas = userData['values']['materi_user'][0]['kode_kelas'];
        print('kdKelas: $kodeKelas');
        return kodeKelas;
      }
    }
    throw Exception('Data pengguna tidak ditemukan atau tidak sesuai format.');
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
        body: FutureBuilder(
          future: Future.wait([aktifData, selesaiData]),
          builder:
              (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                color: Colors.redAccent,
                child: const Center(child: CircularProgressIndicator()),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              List<dataPRAktif> aktifMaterials =
                  snapshot.data![0] as List<dataPRAktif>;
              List<dataPRSelesai> selesaiMaterials =
                  snapshot.data![1] as List<dataPRSelesai>;
              return Container(
                decoration: const BoxDecoration(color: Colors.redAccent),
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
                    if (aktifMaterials.isEmpty)
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
                    for (var material in aktifMaterials)
                      Center(
                        child: Container(
                          width: 350.0,
                          height: 300.0,
                          padding: const EdgeInsets.fromLTRB(16, 5, 10, 0),
                          child: CustomCard(
                            title: material.judulPr,
                            text: material.deskripsi,
                            deadln: material.tenggat,
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
                    if (selesaiMaterials.isEmpty)
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
                    for (var material in selesaiMaterials)
                      Center(
                        child: Container(
                          width: 350.0,
                          height: 300.0,
                          padding: const EdgeInsets.fromLTRB(16, 5, 10, 0),
                          child: CustomCard(
                            title: material.judulPr,
                            text: material.deskripsi,
                            deadln: material.status,
                          ),
                        ),
                      ),
                  ],
                ),
              );
            }
          },
        ));
  }
}

// ignore: must_be_immutable
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
