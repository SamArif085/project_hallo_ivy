import 'package:flutter/material.dart';
import '../Module/bottom_navigation_view/bottom_bar_view.dart';
import 'models/data_laporan_tema.dart';
import 'video_screen_all_kelas.dart';

class MateriPage extends StatefulWidget {
  final String kdkelas;
  const MateriPage({
    super.key,
    AnimationController? animationController,
    required this.kdkelas,
  });

  @override
  State<MateriPage> createState() => _MateriPageState();
}

class _MateriPageState extends State<MateriPage> {
  List<Map<String, dynamic>> linkMateriFull = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: HexColor('#ff8478'),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Padding(
          padding: EdgeInsets.only(right: 0),
          child: Center(
            child: Text('Materi'),
          ),
        ),
        actions: <Widget>[
          // Tambahkan tombol di sini
          IconButton(
            icon: const Icon(Icons.info),
            iconSize: 30,
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Materi'),
                    content: const Text(
                        'Anda bisa mempelajari materi yang anda pilih pada kelas ini.'),
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
        decoration: BoxDecoration(color: HexColor('#ff8478')),
        child: FutureBuilder(
          future: getDataTema(widget.kdkelas),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              // Populate linkMateriFull with fetched data
              List<DataTema> linkMateriFull = snapshot.data as List<DataTema>;
              print('linkMateriFull: $linkMateriFull');
              return ListView.builder(
                padding: const EdgeInsets.only(top: 20),
                itemCount: linkMateriFull.length,
                itemBuilder: (context, index) {
                  var materi = linkMateriFull[index];
                  return CustomCard(
                    key: Key(materi.id.toString()),
                    title: materi.judulmateri,
                    status: '1',
                    image: materi.gambarmateri,
                    materi: materi.linkmateri,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VideoScreenAllKelas(
                            materi: materi,
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

  // // Replace this with your actual fetching logic
  // Future<List<Map<String, dynamic>>> fetchUserMaterials() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   String? userDataString = preferences.getString('userData');
  //   if (userDataString != null) {
  //     Map<String, dynamic> userData = jsonDecode(userDataString);
  //     // Assuming "materi_user" is the key for user's materials
  //     return userData['values']['materi_user'].cast<Map<String, dynamic>>();
  //   } else {
  //     return []; // Return an empty list if no user data is found
  //   }
  // }
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
                  // Container(
                  //   child: status == '1'
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
