import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:project_hallo_ivy/menu/Tema/Data/Test2/models/chartmodel.dart';

class ChartApp extends StatefulWidget {
  const ChartApp({Key? key, AnimationController? animationController}) : super(key: key);

  @override
  State<ChartApp> createState() => _BarChartAPIState();
}

class _BarChartAPIState extends State<ChartApp> {
  List<GenderModel> genders = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    var response = await http.get(
      Uri.parse(
        "https://api.genderize.io/?name[]=Eko&name[]=Asep&name[]=Ahmad&name[]=Ayu&name[]=Santi",
      ),
    );

    List data = json.decode(response.body);

    setState(() {
      genders = genderModelFromJson(data);
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: loading
            ? const CircularProgressIndicator()
            : Container(
                height: 400,
                padding: const EdgeInsets.all(15),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        const Text(
                          "Jumlah Penduduk dengan Nama Berikut",
                        ),
                        Expanded(
                          child: SfCartesianChart(
                            primaryXAxis: CategoryAxis(),
                            series: <ChartSeries>[
                              BarSeries<GenderModel, String>(
                                dataSource: genders,
                                yValueMapper: (GenderModel genderModel, _) =>
                                   genderModel.count,
                                xValueMapper: (GenderModel genderModel, _) =>
                                    genderModel.name,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
