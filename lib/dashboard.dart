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
          backgroundImage: AssetImage('assets/logo.png'),
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
                image: NetworkImage(
                  "https://images.unsplash.com/photo-1607355739828-0bf365440db5?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1444&q=80",
                ),
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
                image: NetworkImage(
                  "https://images.pexels.com/photos/2583852/pexels-photo-2583852.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=750&w=1260",
                ),
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
                image: NetworkImage(
                  "https://images.unsplash.com/photo-1584810359583-96fc3448beaa?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1267&q=80",
                ),
                fit: BoxFit.cover,
              ),
            ),
          )
        ],
      ),
    );

    return Scaffold(
      body: Center(
        child: ListView(
          children: <Widget>[
            body,
            const SizedBox(height: 48.0),
            konten,
            const SizedBox(height: 48.0),
            Carousel,
          ],
        ),
      ),
    );
  }
}
