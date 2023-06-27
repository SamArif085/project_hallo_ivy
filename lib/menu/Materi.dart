import 'package:flutter/material.dart';

class MenuTiga extends StatelessWidget {
  const MenuTiga({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                child: Card(
                  child: Image.asset('assets/ak.png'),
                ),
              ),
              Container(
                child: Card(
                  child: Image.asset('assets/ak.png'),
                ),
              ),
              Container(
                child: Card(
                  child: Image.asset('assets/ak.png'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
