import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Module/bottom_navigation_view/bottom_bar_view.dart';
import 'color_Theme.dart';
import 'laporan_page.dart';
import 'models/data_laporan_tema.dart';

class ListLaporan extends StatefulWidget {
  const ListLaporan({
    super.key,
    AnimationController? animationController,
  });

  @override
  // ignore: no_logic_in_create_state
  State<ListLaporan> createState() => _ListLaporanState();
}

Future<String> kdKelas() async {
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

class _ListLaporanState extends State<ListLaporan> {
  String kodeKelas = '';

  @override
  void initState() {
    super.initState();
    kdKelas().then((value) {
      setState(() {
        kodeKelas = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: HexColor('#ff8478'),
        title: const Padding(
          padding: EdgeInsets.only(left: 50),
          child: Center(
            child: Text(
              'Laporan',
              style: TextStyle(color: DesignCourseAppTheme.nearlyWhite),
            ),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.info),
            color: DesignCourseAppTheme.nearlyWhite,
            iconSize: 30,
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text(
                      'Laporan',
                    ),
                    content: const Text(
                        'Anda dapat melihat pesan guru dan laporan statistik pertema pada halaman ini.'),
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
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: DesignCourseAppTheme.nearlyWhite,
        ),
        child: FutureBuilder<List<DataTema>>(
          future: getDataTema(kodeKelas),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              List<DataTema> dataTema = snapshot.data as List<DataTema>;
              print('dataTema: $dataTema');
              return ListView.builder(
                padding: const EdgeInsets.only(top: 20),
                itemCount: dataTema.length,
                itemBuilder: (context, index) {
                  var dataLaporanTema = dataTema[index];
                  return CustomCard(
                    key: Key(dataLaporanTema.id.toString()),
                    title: dataLaporanTema.judulmateri,
                    image: dataLaporanTema.gambarmateri,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LaporanHome(
                            materi: dataLaporanTema.toMap(),
                            kodeKelas: kodeKelas,
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
}

// ignore: must_be_immutable
class CustomCard extends StatelessWidget {
  final VoidCallback onTap;

  CustomCard({
    Key? key,
    required this.title,
    required this.image,
    required this.onTap,
  }) : super(key: key);

  String title;
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
                height: sizedHeight * 1.2,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(image),
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
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
