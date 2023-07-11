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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Material(
                    child: MaterialButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, "konten-page-video"),
                      child: Center(
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/Video.png',
                              height: 200,
                              width: 200,
                            ),
                            const Text(
                              'Mari Pembelajaran',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Material(
                    child: MaterialButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, "konten-page-Quiz"),
                      child: Center(
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/Quiz.png',
                              height: 200,
                              width: 200,
                            ),
                            const Text(
                              'Mari Quiz',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Material(
                    child: MaterialButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, "konten-page-video-3"),
                      child: Center(
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/Test.png',
                              height: 200,
                              width: 200,
                            ),
                            const Text(
                              'Mari Test',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
