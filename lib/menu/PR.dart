import 'package:flutter/material.dart';

class MenuSatu extends StatelessWidget {
  const MenuSatu({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Text(
            'INI MENU PERTAMA',
            style: TextStyle(fontSize: 26),
          ),
        ),
      ),
    );
  }
}
