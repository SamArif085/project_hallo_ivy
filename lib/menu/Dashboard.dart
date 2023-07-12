import 'package:flutter/material.dart';

class MenuDashboard extends StatelessWidget {
  const MenuDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final Carousel = SizedBox(
      height: 200,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            margin: const EdgeInsets.only(
              left: 20,
            ),
            width: 300,
            height: 200,
            child: MaterialButton(
              minWidth: 200.0,
              height: 42.0,
              onPressed: () => Navigator.pushNamed(context, "konten-Game1"),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        'assets/susun_kata.png',
                        height: 150,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 20,
            ),
            width: 300,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: const DecorationImage(
                image: AssetImage('assets/jatim.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 20,
            ),
            width: 300,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: const DecorationImage(
                image: AssetImage('assets/ak.png'),
                fit: BoxFit.cover,
              ),
            ),
          )
        ],
      ),
    );
    final konten = Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          border: Border.all(color: Color.fromARGB(255, 201, 198, 198)),
          borderRadius: const BorderRadius.all(
            Radius.circular(40),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Material(
              child: MaterialButton(
                color: Colors.white,
                elevation: 1,
                onPressed: () =>
                    Navigator.pushNamed(context, "konten-page-video"),
                child: Center(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/Video.png',
                        height: 125,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Material(
              child: MaterialButton(
                color: Colors.white,
                elevation: 1,
                onPressed: () => Navigator.pushNamed(context, "konten-page"),
                child: Center(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/materi1.png',
                        height: 125,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    final konten1 = Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Card(
            child: Image.asset(
              'assets/ak.png',
            ),
          ),
          Material(
            child: MaterialButton(
              color: Colors.white,
              elevation: 1,
              onPressed: () => Navigator.pushNamed(context, "konten-page-Quiz"),
              child: Center(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/Quiz.png',
                      height: 150,
                      width: 150,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );

    const namakonten1 = Padding(
      padding: EdgeInsets.fromLTRB(30, 0, 0, 10),
      child: Row(
        children: [
          Text(
            'Materi',
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );

    const namakonten2 = Padding(
      padding: EdgeInsets.fromLTRB(100, 0, 100, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'PR',
            style: TextStyle(fontSize: 20),
          ),
          Text(
            'Quiz',
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );

    return Scaffold(
      backgroundColor: Colors.greenAccent[400],
      body: SizedBox(
        child: Expanded(
          child: Container(
            height: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(60), topRight: Radius.circular(60)),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 50.0),
                  namakonten1,
                  konten,
                  const SizedBox(height: 50.0),
                  namakonten2,
                  konten1,
                  const SizedBox(height: 50.0),
                  Carousel,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
