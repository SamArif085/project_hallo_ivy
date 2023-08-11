import 'package:flutter/material.dart';
import 'package:project_hallo_ivy/login.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'design_course_app_theme.dart';
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
        backgroundColor: DesignCourseAppTheme.nearlyWhite,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: DesignCourseAppTheme.nearlyWhite,
        ),
        child: Center(
          child: Container(
            height: 450,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    'Laporan Siswa',
                    style: TextStyle(
                      color: HexColor('#85f29d'),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  child: SfCartesianChart(
                    primaryXAxis: CategoryAxis(),
                    primaryYAxis: NumericAxis(),
                    series: <ChartSeries>[
                      ColumnSeries<Map, String>(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        color: HexColor('#85f29d'),
                        dataSource: [
                          {'x': 'A', 'y': 10},
                          {'x': 'B', 'y': 15},
                          {'x': 'C', 'y': 15},
                          {'x': 'D', 'y': 15},
                        ],
                        xValueMapper: (Map data, int index) => data['x'],
                        yValueMapper: (Map data, int index) => data['y'],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
