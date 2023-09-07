import 'package:flutter/material.dart';
import 'package:hello_ivy_test/menu/Data/Data_Halaman/models/data_laporan_kelas.dart';
import 'Color_Theme.dart';
import 'list_laporan_tema_page.dart';

class LaporanKelas extends StatefulWidget {
  const LaporanKelas({
    super.key,
    AnimationController? animationController,
  });

  @override
  State<LaporanKelas> createState() => _LaporanKelasState();
}

class _LaporanKelasState extends State<LaporanKelas> {
  List<Map<String, dynamic>> laporanKelas = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: DesignCourseAppTheme.nearlyWhite,
        title: const Center(
            child: Text("Laporan Perkelas",
                style: TextStyle(color: Colors.black))),
      ),
      body: Container(
        decoration:
            const BoxDecoration(color: DesignCourseAppTheme.nearlyWhite),
        child: FutureBuilder<List<DataKelas>>(
          future: getKelas(), // Fetch the user's materials
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(); // Show loading indicator
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              // Populate laporanKelas with fetched data
              List<DataKelas> laporanKelas = snapshot.data as List<DataKelas>;
              return ListView.builder(
                padding: const EdgeInsets.only(top: 20, bottom: 60),
                itemCount: laporanKelas.length,
                itemBuilder: (context, index) {
                  var materi = laporanKelas[index];
                  return CustomCard(
                    key: Key(materi.kdkelas), // Menggunakan kdkelas sebagai key
                    title: materi.ketkelas,
                    status: "1",
                    image: materi.gambar,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ListLaporan(
                            materi: {
                              'kdkelas': materi.kdkelas,
                              'ketkelas': materi.ketkelas,
                              'image': materi.gambar,
                            },
                            kdkelas: materi.kdkelas,
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
      child: Column(
        children: [
          Card(
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
                        image:
                            NetworkImage(image), // Use a placeholder image URL
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
          // const SizedBox(
          //   height: 20,
          // )
        ],
      ),
    );
  }
}
