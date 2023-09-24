// import 'package:flutter/material.dart';
// import 'package:hello_ivy_test/menu/Data/Data_Halaman/models/data_laporan_kelas.dart';
// import '../Module/bottom_navigation_view/bottom_bar_view.dart';
// import 'list_laporan_tema_page.dart';
// import 'list_materi_page.dart';

// class ListAllKelas extends StatefulWidget {
//   const ListAllKelas({
//     super.key,
//     AnimationController? animationController,
//   });

//   @override
//   State<ListAllKelas> createState() => _ListAllKelasState();
// }

// class _ListAllKelasState extends State<ListAllKelas> {
//   List<Map<String, dynamic>> laporanKelas = [];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         elevation: 0,
//         backgroundColor: HexColor('#85f29d'),
//         leading: IconButton(
//           icon: const Icon(
//             Icons.arrow_back,
//             color: Colors.white,
//           ),
//           onPressed: () {
//              Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const MateriPage(),
//                 ),
//               );
//           },
//         ),
//         title: const Padding(
//           padding: EdgeInsets.only(right: 0),
//           child: Center(
//             child: Text('Materi Semua Kelas'),
//           ),
//         ),
//         actions: <Widget>[
//           IconButton(
//             icon: const Icon(Icons.info),
//             iconSize: 30,
//             onPressed: () {
//               showDialog(
//                 context: context,
//                 builder: (BuildContext context) {
//                   return AlertDialog(
//                     title: const Text('Materi Semua Kelas'),
//                     content: const Text(
//                         'Semua materi kelas yang sudah pernah dipelajari. Anda bisa melihatnya kembali pada halaman ini.'),
//                     actions: <Widget>[
//                       TextButton(
//                         child: const Text('Tutup'),
//                         onPressed: () {
//                           Navigator.of(context).pop();
//                         },
//                       ),
//                     ],
//                   );
//                 },
//               );
//             },
//           ),
//         ],
//       ),
//       body: Container(
//         decoration: BoxDecoration(color: HexColor('#85f29d')),
//         child: FutureBuilder<List<DataKelas>>(
//           future: getKelas(), // Fetch the user's materials
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             } else if (snapshot.hasError) {
//               return Text('Error: ${snapshot.error}');
//             } else {
//               // Populate laporanKelas with fetched data
//               List<DataKelas> laporanKelas = snapshot.data as List<DataKelas>;
//               return ListView.builder(
//                 padding: const EdgeInsets.only(top: 20, bottom: 60),
//                 itemCount: laporanKelas.length,
//                 itemBuilder: (context, index) {
//                   var materi = laporanKelas[index];
//                   return CustomCard(
//                     key: Key(materi.kdkelas), // Menggunakan kdkelas sebagai key
//                     title: materi.ketkelas,
//                     status: "1",
//                     image: materi.gambar,
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => ListLaporan(
//                             materi: {
//                               'kdkelas': materi.kdkelas,
//                               'ketkelas': materi.ketkelas,
//                               'image': materi.gambar,
//                             },
//                             kdkelas: materi.kdkelas,
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 },
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

// // ignore: must_be_immutable
// class CustomCard extends StatelessWidget {
//   final VoidCallback onTap;

//   CustomCard({
//     Key? key,
//     required this.title,
//     required this.image,
//     required this.status,
//     required this.onTap,
//   }) : super(key: key);

//   String title;
//   String status;
//   String image;
//   @override
//   Widget build(BuildContext context) {
//     double sizedHeight = MediaQuery.of(context).size.width > 600 ? 230 : 130;
//     return Padding(
//       padding: const EdgeInsets.only(right: 30, left: 30, bottom: 10),
//       child: Column(
//         children: [
//           Card(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(5.0),
//             ),
//             elevation: 7,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 InkWell(
//                   onTap: onTap,
//                   child: Container(
//                     height: sizedHeight,
//                     decoration: BoxDecoration(
//                       image: DecorationImage(
//                         image:
//                             NetworkImage(image), // Use a placeholder image URL
//                         fit: BoxFit.cover,
//                       ),
//                       borderRadius: const BorderRadius.only(
//                         topLeft: Radius.circular(5.0),
//                         topRight: Radius.circular(5.0),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.only(
//                       top: 10, bottom: 10, left: 20, right: 20),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         title,
//                         textAlign: TextAlign.center,
//                       ),
//                       Container(
//                         child: status == "1"
//                             ? Image.asset(
//                                 'assets/icon/unlock_icon.png',
//                                 height: 20,
//                               )
//                             : Image.asset(
//                                 'assets/icon/lock_icon.png',
//                                 height: 20,
//                               ),
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
