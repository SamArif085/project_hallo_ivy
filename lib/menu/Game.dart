import 'package:flutter/material.dart';

class MenuGame extends StatelessWidget {
  const MenuGame({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    child: Card(
                      child: Image.asset('assets/ak.png'),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                    width: 50,
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    child: Card(
                      child: Image.asset('assets/ak.png'),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    child: Card(
                      child: Image.asset('assets/ak.png'),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                    width: 50,
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    child: Card(
                      child: Image.asset('assets/ak.png'),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    child: Card(
                      child: Image.asset('assets/ak.png'),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                    width: 50,
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    child: Card(
                      child: Image.asset('assets/ak.png'),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    child: Card(
                      child: Image.asset('assets/ak.png'),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                    width: 50,
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    child: Card(
                      child: Image.asset('assets/ak.png'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
