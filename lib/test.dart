import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bottom Navigation',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //inisialisasi variabel
  int _currentIndex = 0;
  String _currentMenu = 'Home';

  //metod ini akan dijalankna saat diklik
  void _changeSelectedNavBar(int index) {
    setState(() {
      _currentIndex = index;

      if (index == 0) {
        _currentMenu = 'Home';
      } else if (index == 1) {
        _currentMenu = 'Order';
      } else if (index == 2) {
        _currentMenu = 'Inbox';
      } else if (index == 3) {
        _currentMenu = 'Account';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bottom Navigation"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Menu yang Aktif",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "Index: " + _currentIndex.toString(),
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "Menu: " + _currentMenu,
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
      //membuat bottom navigation
      bottomNavigationBar: BottomNavigationBar(
        //membuat item navigasi
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'Order'),
          BottomNavigationBarItem(icon: Icon(Icons.mail), label: 'Inbox'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
        ],

        //currentindex mengikuti baris item bottom navigasi yang diklik
        currentIndex: _currentIndex,

        //warna saat item diklik
        selectedItemColor: Colors.blue,

        //metode yang dijalankan saat ditap
        onTap: _changeSelectedNavBar,

        //agar bottom navigation tidak bergerak saat diklik
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
