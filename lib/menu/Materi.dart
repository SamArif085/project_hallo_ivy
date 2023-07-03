import 'package:flutter/material.dart';

class MenuMateri extends StatelessWidget {
  const MenuMateri({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SizedBox(
          child: Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60)),
              ),
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
                        child: const Text('Materi 1',
                            style: TextStyle(color: Colors.black)),
                      ),
                    ),
                  ),
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
                        child: const Text('Materi 2',
                            style: TextStyle(color: Colors.black)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
