import 'package:flutter/material.dart';
import 'package:project_hallo_ivy/menu/PR.dart';
import 'package:project_hallo_ivy/menu/Materi.dart';
import 'package:project_hallo_ivy/menu/Laporan.dart';
import 'package:project_hallo_ivy/menu/Dashboard.dart';

class BasePage extends StatefulWidget {
  const BasePage({Key? key}) : super(key: key);
  static String tag = 'home-page';

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  late int _currentIndex = 0;
  final List<Widget> _children = [
    const MenuSatu(),
    const MenuDua(),
    const MenuTiga(),
    const MenuDashboard(),
  ];
  void onBarTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    const foto = Hero(
      tag: 'hero',
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: CircleAvatar(
          radius: 35.0,
          backgroundColor: Colors.transparent,
          backgroundImage: AssetImage('assets/icon/user-212-256.png'),
        ),
      ),
    );

    const welcome = Padding(
      padding: EdgeInsets.all(10.0),
      child: Text(
        'Halo~',
        style: TextStyle(
          fontSize: 20.0,
          color: Colors.white,
        ),
      ),
    );

    const nama = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'Fahrizi',
        style: TextStyle(
          fontSize: 20.0,
          color: Colors.white,
          height: 5,
        ),
      ),
    );
    const kelas = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'B1',
        style: TextStyle(
          fontSize: 15.0,
          color: Colors.white,
        ),
      ),
    );

    final notif = Center(
      child: PopupMenuButton(
        padding: const EdgeInsets.fromLTRB(100, 100, 0, 0),
        itemBuilder: (context) => [
          const PopupMenuItem(
            child: Column(
              children: [Text('item1'), Text('item2')],
            ),
          ),
        ],
        child: const Icon(
          Icons.notification_add,
          color: Colors.black,
          size: 30,
        ),
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

    final Carousel = Container(
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

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Colors.greenAccent[400],
              automaticallyImplyLeading: false,
              expandedHeight: 150.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: const Text("Fahrizi",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    )),
                background: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(28.0),
                  decoration: BoxDecoration(
                    color: Colors.greenAccent[400],
                  ),
                  child: Row(
                    children: <Widget>[
                      foto,
                      welcome,
                      nama,
                      kelas,
                      notif,
                    ],
                  ),
                ),
              ),
            ),
          ];
        },
        body: _children[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onBarTapped,
        //membuat item navigasi
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.add_home_work), label: 'PR'),
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment), label: 'Laporan'),
          BottomNavigationBarItem(
              icon: Icon(Icons.content_paste_search_rounded),
              label: 'Menu Materi'),
          BottomNavigationBarItem(
              icon: Icon(Icons.games_rounded), label: 'Game'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_sharp), label: 'Account'),
        ],
        //agar bottom navigation tidak bergerak saat diklik
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
