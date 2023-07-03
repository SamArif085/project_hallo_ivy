import 'package:flutter/material.dart';
import 'package:project_hallo_ivy/menu/PR.dart';
import 'package:project_hallo_ivy/menu/Materi.dart';
import 'package:project_hallo_ivy/menu/Laporan.dart';
import 'package:project_hallo_ivy/menu/Dashboard.dart';
import 'package:project_hallo_ivy/menu/Game.dart';

class BasePage extends StatefulWidget {
  const BasePage({Key? key}) : super(key: key);
  static String tag = 'home-page';

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  late ScrollController _scrollController;
  late int _currentIndex = 0;
  bool lastStatus = true;
  double height = 390;
  final List<Widget> _children = [MenuDashboard()];

  bool get _isShrink {
    return _scrollController.hasClients &&
        _scrollController.offset > (height - kToolbarHeight);
  }

  void _scrollListener() {
    if (_isShrink != lastStatus) {
      setState(() {
        lastStatus = _isShrink;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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
          backgroundColor: Colors.transparent,
          backgroundImage: AssetImage('assets/icon/user-212-256.png'),
        ),
      ),
    );

    const welcome = SizedBox(
      child: Text(
        'Halo~',
        style: TextStyle(
          fontSize: 20.0,
          color: Colors.white,
        ),
      ),
    );

    const nama = SizedBox(
      child: Text(
        'Fahrizi',
        style: TextStyle(
          fontSize: 20.0,
          color: Colors.white,
        ),
      ),
    );
    const kelas = SizedBox(
      child: Text(
        'B1',
        style: TextStyle(
          fontSize: 15.0,
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
          controller: _scrollController,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: Colors.greenAccent[400],
                automaticallyImplyLeading: false,
                floating: true,
                pinned: true,
                snap: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    child: nama,
                  ),
                  centerTitle: true,
                  title: _isShrink
                      ? const Text('pmatatias Statistic',
                          style: TextStyle(fontSize: 16))
                      : const SizedBox(),
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
              icon: Icon(Icons.account_circle_sharp), label: 'PR'),
          BottomNavigationBarItem(
              icon: Icon(Icons.content_paste_search_rounded),
              label: 'Menu Materi'),
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment), label: 'Laporan'),
          BottomNavigationBarItem(
              icon: Icon(Icons.games_rounded), label: 'Game'),
        ],
        //agar bottom navigation tidak bergerak saat diklik
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
