import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../Module/bottom_navigation_view/bottom_bar_view.dart';
// import 'design_course_app_theme.dart';

class LaporanHome extends StatelessWidget {
  final Map<String, dynamic> materi;
  const LaporanHome({
    super.key,
    required this.materi,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            title: const Center(
              child:
                  Text('Laporan Siswa', style: TextStyle(color: Colors.black)),
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
                  PesanGuru(materi: materi),
                  chartVideo(
                    materi: materi,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

// ignore: camel_case_types
class chartVideo extends StatelessWidget {
  final Map<String, dynamic> materi;
  const chartVideo({
    Key? key,
    required this.materi,
  }) : super(key: key);

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
              child: FutureBuilder(
                future: Future.value(materi),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final Map<String, dynamic> materi =
                        snapshot.data as Map<String, dynamic>;
                    return Container(
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
                              {
                                'x': 'A',
                                'y': int.parse(materi['count'].toString())
                              },
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
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PesanGuru extends StatelessWidget {
  const PesanGuru({super.key, required this.materi});
  final Map<String, dynamic> materi;
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
                  materi['isi_pesan'],
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
