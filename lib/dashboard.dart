import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static String tag = 'home-page';

  @override
  Widget build(BuildContext context) {
    final foto = Hero(
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

    final welcome = Padding(
      padding: EdgeInsets.all(10.0),
      child: Text(
        'Halo~',
        style: TextStyle(
          fontSize: 20.0,
          color: Colors.white,
        ),
      ),
    );

    final nama = Padding(
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
    final kelas = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'B1',
        style: TextStyle(
          fontSize: 15.0,
          color: Colors.white,
        ),
      ),
    );

    final notif = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.greenAccent[400],
        elevation: 0,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50))),
      ),
      onPressed: () {},
      child: Container(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Icon(
          Icons.notification_add,
          color: Colors.black,
          size: 30,
        ),
      ),
    );

    final body = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(28.0),
      decoration: BoxDecoration(
        color: Colors.greenAccent[400],
      ),
      child: Row(
        children: <Widget>[foto, welcome, nama, kelas, notif],
      ),
    );

    final konten = Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(30))),
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
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            margin: EdgeInsets.only(
              left: 20,
            ),
            width: 300,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.black12,
              image: DecorationImage(
                image: AssetImage('assets/ak.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              left: 20,
            ),
            width: 300,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: AssetImage('assets/jatim.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              left: 20,
            ),
            width: 300,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
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
                title: Text("Fahrizi",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    )),
                background: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(28.0),
                  decoration: BoxDecoration(
                    color: Colors.greenAccent[400],
                  ),
                  child: Row(
                    children: <Widget>[foto, welcome, nama, kelas, notif],
                  ),
                ),
              ),
            ),
          ];
        },
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 50.0),
            konten,
            const SizedBox(height: 50.0),
            Carousel,
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        //membuat item navigasi
        items: [
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
