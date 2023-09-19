import 'package:flutter/material.dart';
import 'package:hello_ivy_test/menu/Dashboard.dart';
import '../Module/bottom_navigation_view/bottom_bar_view.dart';
import 'laporan_page.dart';
import 'models/data_laporan_tema.dart';

class ListLaporan extends StatefulWidget {
  final String kdkelas;
  ListLaporan({
    super.key,
    AnimationController? animationController,
    required Map<String, dynamic> materi,
    required this.kdkelas,
  });

  @override
  // ignore: no_logic_in_create_state
  State<ListLaporan> createState() => _ListLaporanState();
}

class _ListLaporanState extends State<ListLaporan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: HexColor('#85f29d'),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DashboardHome(),
              ),
            );
          },
        ),
        title: const Padding(
          padding: EdgeInsets.all(0),
          child: Center(
            child: Text('Laporan'),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.info),
            iconSize: 30,
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Laporan Pertema'),
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
        decoration: BoxDecoration(color: HexColor('#85f29d')),
        child: FutureBuilder<List<DataTema>>(
          future: getDataTema(widget.kdkelas),
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
                    status: "1",
                    image: dataLaporanTema.gambarmateri,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LaporanHome(
                            kdkelas: widget.kdkelas,
                            materi: dataLaporanTema.toMap(),
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
    required this.status,
    required this.onTap,
  }) : super(key: key);

  String title;
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                  ),
                  // Container(
                  //   child: status == "1"
                  //       ? Image.asset(
                  //           'assets/icon/unlock_icon.png',
                  //           height: 20,
                  //         )
                  //       : Image.asset(
                  //           'assets/icon/lock_icon.png',
                  //           height: 20,
                  //         ),
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
