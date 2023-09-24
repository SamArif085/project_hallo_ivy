import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hello_ivy_test/menu/Dashboard.dart';
import 'package:hello_ivy_test/menu/Data/Data_Halaman/models/refreshdata.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Module/bottom_navigation_view/bottom_bar_view.dart';
import 'play_quiz.dart';

class QuizMenu extends StatefulWidget {
  final String? data;
  const QuizMenu({
    super.key,
    this.data,
  });

  @override
  State<QuizMenu> createState() => _QuizMenuState();
}

class _QuizMenuState extends State<QuizMenu> {
  // ignore: non_constant_identifier_names
  List<Map<String, dynamic>> MateriPerTema = [];

  @override
  void initState() {
    super.initState();
    if (widget.data == "refresh") {
      UserDataManager.refreshUserData();
    }
  }

  Future<List<Map<String, dynamic>>> _refreshQuizMenu() async {
    final newData = await refreshKuis();
    setState(() {
      MateriPerTema = newData;
    });
    return newData;
  }

  @override
  void didUpdateWidget(covariant QuizMenu oldWidget) {
    super.didUpdateWidget(oldWidget);
    _refreshQuizMenu();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: HexColor('#85f29d'),
        title: const Padding(
          padding: EdgeInsets.only(right: 50),
          child: Center(child: Text('Kuis')),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const DashboardHome(),
              ),
            );
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(color: HexColor('#85f29d')),
        child: FutureBuilder(
          future: refreshKuis(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              MateriPerTema = snapshot.data as List<Map<String, dynamic>>;
              return ListView.builder(
                padding: const EdgeInsets.only(top: 20),
                itemCount: MateriPerTema.length,
                itemBuilder: (context, index) {
                  var materi = MateriPerTema[index];
                  return CustomCard(
                    key: Key(materi['id'].toString()),
                    title: materi['judul_materi'],
                    status: materi['status'],
                    image: materi["gambar_materi"],
                    materi: materi['link_materi'],
                    onTap: () {
                      if (materi['status'] == "1") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PlayQuiz(
                              materi: materi,
                            ),
                          ),
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Quiz Terkunci'),
                              content: const Text(
                                  'Quiz ini masih terkunci. Anda tidak bisa mengaksesnya.'),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Tutup'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
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

  Future<List<Map<String, dynamic>>> refreshKuis() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userDataString = preferences.getString('userData');
    if (userDataString != null) {
      Map<String, dynamic> userData = jsonDecode(userDataString);
      return userData['values']['materi_user'].cast<Map<String, dynamic>>();
    } else {
      return [];
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
    double sizedHeight = MediaQuery.of(context).size.width > 600 ? 230 : 130;
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
                height: sizedHeight,
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
