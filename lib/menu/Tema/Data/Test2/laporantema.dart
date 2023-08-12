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
        title: Center(
            // child: const Text('Laporan Siswa'),
            ),
        backgroundColor: HexColor('#85f29d'),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: HexColor('#85f29d'),
        ),
        child: Center(
          child: Container(
            margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
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
                      padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                      child: Text(
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
                            borderRadius: BorderRadius.only(
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
          ),
        ),
      ),
    ));
  }
}
