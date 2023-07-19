import 'package:flutter/material.dart';
import 'package:project_hallo_ivy/menu/PR.dart';
import 'package:project_hallo_ivy/menu/Materi.dart';
import 'package:project_hallo_ivy/menu/Laporan.dart';
import 'package:project_hallo_ivy/menu/Dashboard.dart';
import 'package:project_hallo_ivy/menu/Game.dart';

class BasePage extends StatefulWidget {
  const BasePage({Key? key}) : super(key: key);
  // static String tag = 'home-page';

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  late int _currentIndex = 0;
  bool lastStatus = true;
  double height = 390;
  final List<Widget> _children = [
    const MenuDashboard(),
    const MenuLaporan(),
    const MenuMateri(),
    const MenuGame(),
    const MenuPR(),
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
      child: SizedBox(
        child: CircleAvatar(
          radius: 35.0,
          backgroundImage: AssetImage('assets/icon/user-212-256.png'),
        ),
      ),
    );

    const nama = SizedBox(
      child: Text(
        'Ahmad Fahrizi',
        style: TextStyle(
          fontSize: 20.0,
          color: Colors.white,
        ),
      ),
    );
    const kelas = SizedBox(
      child: Text(
        'Kelas B1',
        style: TextStyle(
          fontSize: 20.0,
          color: Colors.white,
        ),
      ),
    );

    final notif = SizedBox(
      child: PopupMenuButton(
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.greenAccent[400],
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: Colors.greenAccent[400],
                automaticallyImplyLeading: false,
                floating: true,
                pinned: true,
                snap: true,
                expandedHeight: 150,
                title: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: nama,
                      ),
                    ),
                  ],
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: foto,
                        ),
                      ),
                      const SizedBox(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: kelas,
                        ),
                      ),
                      SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: notif,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: _children[_currentIndex],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onBarTapped,
        //membuat item navigasi
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment), label: 'Laporan'),
          BottomNavigationBarItem(
              icon: Icon(Icons.content_paste_search_rounded),
              label: 'Menu Materi'),
          BottomNavigationBarItem(
              icon: Icon(Icons.games_rounded), label: 'Game'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_sharp), label: 'Akun'),
        ],
        //agar bottom navigation tidak bergerak saat diklik
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
