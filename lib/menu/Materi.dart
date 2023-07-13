import 'package:flutter/material.dart';

class MenuMateri extends StatelessWidget {
  const MenuMateri({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent[400],
      body: SizedBox(
        child: Expanded(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(60), topRight: Radius.circular(60)),
            ),
            child: SingleChildScrollView(
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
                        child: Center(
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/materi1.png',
                                height: 250,
                                width: 250,
                              ),
                              const Text(
                                'Contoh Materi',
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.0),
                      shadowColor: Colors.lightBlueAccent.shade100,
                      child: MaterialButton(
                        minWidth: 200.0,
                        height: 42.0,
                        onPressed: () =>
                            Navigator.pushNamed(context, "konten-page"),
                        child: Center(
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/materi1.png',
                                height: 250,
                                width: 250,
                              ),
                              const Text(
                                'Contoh Materi 1',
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
                      borderRadius: BorderRadius.circular(30.0),
                      shadowColor: Colors.lightBlueAccent.shade100,
                      child: MaterialButton(
                        minWidth: 200.0,
                        height: 42.0,
                        onPressed: () =>
                            Navigator.pushNamed(context, "konten-page"),
                        child: Center(
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/materi1.png',
                                height: 250,
                                width: 250,
                              ),
                              const Text(
                                'Contoh Materi 2',
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
      ),
    );
  }
}
