import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'login.dart';
import 'menu/Tema/Data/Quiz/views/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Kodeversitas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        fontFamily: 'Nunito',
      ),
      // home:  LoginPage(),
      initialRoute: '/', // Atur rute awal aplikasi (biasanya '/' untuk halaman beranda)
      routes: {
        '/': (context) =>  LoginPage(), // Rute untuk halaman beranda
        // '/quiz': (context) => HomePage(), // Rute untuk halaman kuis, sesuaikan dengan halaman kuis Anda jika berbeda
        // Jika Anda memiliki halaman lain, Anda dapat menambahkan rute lain di sini
      }, 
    );
  }
}
