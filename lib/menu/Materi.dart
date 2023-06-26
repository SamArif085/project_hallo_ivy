import 'package:flutter/material.dart';

class MenuTiga extends StatelessWidget {
  const MenuTiga({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Text(
            'INI MENU Kedua',
            style: TextStyle(fontSize: 26),
          ),
        ),
      ),
    );
  }
}
