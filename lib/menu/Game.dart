import 'package:flutter/material.dart';

class MenuGame extends StatelessWidget {
  const MenuGame({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.greenAccent[400],
        body: SizedBox(
          child: Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Material(
                              borderRadius: BorderRadius.circular(30.0),
                              shadowColor: Colors.lightBlueAccent.shade100,
                              child: MaterialButton(
                                minWidth: 200.0,
                                height: 42.0,
                                onPressed: () => Navigator.pushNamed(
                                    context, "konten-Game1"),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Image.asset(
                                          'assets/susun_kata.png',
                                          height: 100,
                                          width: 150,
                                        ),
                                        const Text(
                                          'Susun Kata',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ],
                                    ),
                                  ],
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
                                onPressed: () => Navigator.pushNamed(
                                    context, "konten-Game1"),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Image.asset(
                                          'assets/susun_kata.png',
                                          height: 100,
                                          width: 150,
                                        ),
                                        const Text(
                                          'Susun Kata',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: Card(
                              child: Image.asset('assets/Lambang-AK.png'),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                            width: 50,
                          ),
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: Card(
                              child: Image.asset('assets/Lambang-AK.png'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: Card(
                              child: Image.asset('assets/Lambang-AK.png'),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                            width: 50,
                          ),
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: Card(
                              child: Image.asset('assets/Lambang-AK.png'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: Card(
                              child: Image.asset('assets/Lambang-AK.png'),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                            width: 50,
                          ),
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: Card(
                              child: Image.asset('assets/Lambang-AK.png'),
                            ),
                          ),
                        ],
                      ),
                    ],
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
