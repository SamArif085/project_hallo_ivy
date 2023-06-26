import 'package:flutter/material.dart';

class MenuDashboard extends StatelessWidget {
  const MenuDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final Carousel = SizedBox(
      height: 200,
      child: ListView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            margin: const EdgeInsets.only(
              left: 20,
            ),
            width: 300,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.black12,
              image: const DecorationImage(
                image: AssetImage('assets/ak.png'),
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
    final konten = Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: const BorderRadius.all(Radius.circular(30))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Card(
            child: Image.asset(
              'assets/ak.png',
            ),
          ),
          Card(
            child: Image.asset(
              'assets/ak.png',
            ),
          )
        ],
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 50.0),
              konten,
              const SizedBox(height: 50.0),
              Carousel,
            ],
          ),
        ),
      ),
    );
  }
}
