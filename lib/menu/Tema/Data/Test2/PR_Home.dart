import 'package:flutter/material.dart';

class PRHome extends StatelessWidget {
  const PRHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halaman Kosong'),
      ),
      body: const Center(
        child: Text(
          'Halaman ini kosong',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
