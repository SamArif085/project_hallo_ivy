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
      body: Column(
        children: [
          const Expanded(flex: 2, child: _TopPortion()),
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: [
                  Text(
                    userData.values.nama,
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 50),
                  Flexible(
                    child: _buildProfileInfo(userData: userData),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildProfileInfo({required UserData userData}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoItem('NISN', userData.values.nisnSiswa),
        _buildInfoItem('Kelas', userData.values.kelas),
        _buildInfoItem('Jenis Kelamin', userData.values.Seks),
        _buildInfoItem('Nama Orang Tua', userData.values.ortu),
        _buildInfoItem('Alamat', userData.values.alamat),
      ],
    ),
  );
}

Widget _buildInfoItem(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    ),
  );
}

class _TopPortion extends StatelessWidget {
  const _TopPortion({Key? key}) : super(key: key);
  void _logout() {
    // Kembali ke halaman sebelumnya (halaman login) saat tombol logout ditekan
    Get.off(() => LoginPage());
    // Hapus controller yang digunakan dalam halaman AdminPage
    Get.delete<LoginController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Atur warna latar belakang AppBar menjadi transparan
        backgroundColor: Colors.greenAccent,
        elevation: 0,
        // Sembunyikan judul AppBar
        title: null,
        // Sembunyikan tombol kembali (back button) di AppBar
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
            onPressed: _logout,
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 50),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  HexColor('#66e782'),
                  Colors.greenAccent,
                ],
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: 150,
              height: 150,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      // color: Colors.black,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/design_course/userImage.png'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
