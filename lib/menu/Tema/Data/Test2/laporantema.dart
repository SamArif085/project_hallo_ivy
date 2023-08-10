import 'package:flutter/material.dart';
import 'package:project_hallo_ivy/login.dart';



class LaporanHome extends StatelessWidget {
  const LaporanHome({super.key, required UserData userData, required LinkMateri userDataMateri});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Halaman Kosong'),
        ),
        body: const Center(
          child: Text(
            'Halaman ini kosong',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}