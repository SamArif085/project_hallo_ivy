import 'package:flutter/material.dart';

class Konten extends StatelessWidget {
  static String tag = 'konten-page';

  const Konten({super.key});

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
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  child: MaterialButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, "konten-page-video"),
                    child: const Card(
                      child: Text('Video'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
