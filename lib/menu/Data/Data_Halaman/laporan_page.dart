import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../Module/bottom_navigation_view/bottom_bar_view.dart';
import 'models/data_laporan_tema.dart';
import 'package:dio/dio.dart';

// import 'design_course_app_theme.dart';
class LaporanHome extends StatelessWidget {
  final String kodeKelas;
  final Map<String, dynamic> materi;
  const LaporanHome({
    super.key,
    required this.materi,
    required this.kodeKelas,
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
                  Text('Laporan Siswa', style: TextStyle(color: Colors.white)),
            ),
            backgroundColor: HexColor('#ff8478'),
          ),
          body: Container(
            decoration: BoxDecoration(
              color: HexColor('#ff8478'),
            ),
            child: Center(
              child: ListView(
                children: [
                  PesanGuru(
                    materi: materi,
                  ),
                  chartVideo(
                    kodeKelas: kodeKelas,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  chartNilai(
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
class chartVideo extends StatefulWidget {
  final String kodeKelas;
  const chartVideo({
    super.key,
    required this.kodeKelas,
  });

  @override
  State<chartVideo> createState() => _chartVideoState();
}

// ignore: camel_case_types
class _chartVideoState extends State<chartVideo> {
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
                future: getLaporanStastistik(widget.kodeKelas),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final List<DataLaporanStastistik> dataLaporanStatistik =
                        snapshot.data as List<DataLaporanStastistik>;
                    if (dataLaporanStatistik.isEmpty) {
                      return Container(
                        child: const Center(
                          child: Text(
                            'Tidak ada data laporan',
                            style: TextStyle(
                              color: Colors.black26,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    }
                    List<Map<String, dynamic>> chartData = [];

                    for (var data in dataLaporanStatistik) {
                      chartData.add({
                        'x': data.jenistema,
                        'y': int.parse(data.count),
                      });
                    }
                    return Container(
                      child: SfCartesianChart(
                        primaryXAxis: CategoryAxis(),
                        primaryYAxis: NumericAxis(),
                        series: <ChartSeries>[
                          ColumnSeries<Map<String, dynamic>, String>(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5)),
                            color: HexColor('#ff8478'),
                            dataSource: chartData,
                            xValueMapper:
                                (Map<String, dynamic> data, int index) =>
                                    data['x'],
                            yValueMapper:
                                (Map<String, dynamic> data, int index) =>
                                    data['y'],
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
  final Map<String, dynamic> materi;
  const PesanGuru({
    super.key,
    required this.materi,
  });

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
              child: FutureBuilder(
                future: materi['id'] != null
                    ? getDataPesanGuru(materi['id'])
                    : Future.value([]),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    if (snapshot.error is DioError) {
                      final dioError = snapshot.error as DioError;
                      if (dioError.response?.statusCode == 404) {
                        // Handle 404 error
                        return Center(
                          child: Text(
                            'Data Not Found',
                            style: TextStyle(
                              color: Colors.black26,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }
                    }
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final List<DataPesanGuru> dataPesan =
                        (snapshot.data as List<dynamic>)
                            .map((item) => DataPesanGuru(
                                  idpesan: item.idpesan,
                                  isipesan: item.isipesan,
                                ))
                            .toList();
                    if (dataPesan.isEmpty) {
                      return Container(
                        child: const Center(
                          child: Text(
                            'Tidak ada Pesan Guru',
                            style: TextStyle(
                              color: Colors.black26,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    }
                    return Flexible(
                      flex: 5,
                      child: Container(
                          margin: const EdgeInsets.fromLTRB(30, 0, 30, 15),
                          child: Text(
                            dataPesan[0].isipesan,
                            textAlign: TextAlign.justify,
                          )),
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

// ignore: camel_case_types
class chartNilai extends StatefulWidget {
  final Map<String, dynamic> materi;
  const chartNilai({
    super.key,
    required this.materi,
  });

  @override
  State<chartNilai> createState() => _chartNilaiState();
}

class _chartNilaiState extends State<chartNilai> {
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
                  'Nilai Kuis Siswa',
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
                future: getLaporanNilaiQuiz(widget.materi['id']),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final List<DataLaporanNilaiQuiz> dataNilaiQuiz =
                        snapshot.data as List<DataLaporanNilaiQuiz>;
                    if (dataNilaiQuiz.isEmpty) {
                      return Container(
                        child: const Center(
                          child: Text(
                            'Tidak ada data Nilai',
                            style: TextStyle(
                              color: Colors.black26,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    }
                    List<Map<String, dynamic>> chartData = [];

                    for (var data in dataNilaiQuiz) {
                      chartData.add({
                        'x': data.date,
                        'y': int.parse(data.nilai),
                      });
                    }
                    return Container(
                      child: SfCartesianChart(
                        primaryXAxis: CategoryAxis(),
                        primaryYAxis: NumericAxis(),
                        series: <ChartSeries>[
                          SplineSeries<Map<String, dynamic>, String>(
                            color: HexColor('#ff8478'),
                            dataSource: chartData,
                            xValueMapper:
                                (Map<String, dynamic> data, int index) =>
                                    data['x'],
                            dataLabelSettings:
                                const DataLabelSettings(isVisible: true),
                            yValueMapper:
                                (Map<String, dynamic> data, int index) =>
                                    data['y'],
                            markerSettings: const MarkerSettings(
                              isVisible: true,
                            ),
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
