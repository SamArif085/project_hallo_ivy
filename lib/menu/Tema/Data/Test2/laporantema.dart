import 'package:flutter/material.dart';
import 'package:project_hallo_ivy/login.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
// import 'design_course_app_theme.dart';
import 'package:project_hallo_ivy/menu/Tema/Data/Test/bottom_navigation_view/bottom_bar_view.dart';

class LaporanHome extends StatelessWidget {
  const LaporanHome(
      {super.key,
      required UserData userData,
      required LinkMateri userDataMateri});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Center(
            // child: const Text('Laporan Siswa'),
            ),
        backgroundColor: HexColor('#85f29d'),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: HexColor('#85f29d'),
        ),
        child: Center(
          child: ListView(
            children: [
              pesanGuru(),
              chartVideo(),
            ],
          ),
        ),
      ),
    ));
  }
}

class chartVideo extends StatelessWidget {
  const chartVideo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
      height: 450,
      child: Card(
        elevation: 7,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                child: const Text(
                  'Statistik Siswa',
                  style: TextStyle(
                    color: Colors.black26,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 5,
              child: Container(
                child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  primaryYAxis: NumericAxis(),
                  series: <ChartSeries>[
                    ColumnSeries<Map, String>(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5)),
                      color: HexColor('#85f29d'),
                      dataSource: [
                        {'x': 'A', 'y': 10},
                        {'x': 'B', 'y': 15},
                        {'x': 'C', 'y': 11},
                        {'x': 'E', 'y': 20},
                        {'x': 'F', 'y': 13},
                        {'x': 'G', 'y': 10},
                        {'x': 'H', 'y': 8},
                      ],
                      xValueMapper: (Map data, int index) => data['x'],
                      yValueMapper: (Map data, int index) => data['y'],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class pesanGuru extends StatelessWidget {
  const pesanGuru({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(30, 0, 30, 15),
      height: 300,
      child: Card(
        elevation: 7,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                child: const Text(
                  'Pesan Guru',
                  style: TextStyle(
                    color: Colors.black26,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 5,
              child: Container(
                margin: const EdgeInsets.fromLTRB(30, 0, 30, 15),
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum eu auctor sapien. Cras ut velit et risus efficitur suscipit vitae vitae odio. In blandit sapien convallis turpis laoreet, eget commodo massa lobortis. Aenean eu dignissim arcu, eu elementum mi. Aenean viverra massa a ligula commodo, at tempor nisl pulvinar. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum eu auctor sap',
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
