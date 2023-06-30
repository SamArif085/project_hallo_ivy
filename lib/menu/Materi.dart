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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  borderRadius: BorderRadius.circular(30.0),
                  shadowColor: Colors.lightBlueAccent.shade100,
                  child: MaterialButton(
                    minWidth: 200.0,
                    height: 42.0,
                    onPressed: () =>
                        Navigator.pushNamed(context, "konten-page"),
                    child: const Text('Materi',
                        style: TextStyle(color: Colors.black)),
                  ),
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
