import 'package:flutter/material.dart';

class MenuDua extends StatelessWidget {
  const MenuDua({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Text(
            'INI MENU Ketiga',
            style: TextStyle(fontSize: 26),
          ),
        ),
      ),
    );
  }
}
