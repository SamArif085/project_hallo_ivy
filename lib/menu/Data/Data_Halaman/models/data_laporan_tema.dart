import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class DataTema {
  String id;
  String judulmateri;
  String linkmateri;
  String gambarmateri;
  String gambarcover;
  String count;

  DataTema({
    required this.id,
    required this.judulmateri,
    required this.linkmateri,
    required this.gambarmateri,
    required this.gambarcover,
    required this.count,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'judul_materi': judulmateri,
      'link_materi': linkmateri,
      'gambar_materi': gambarmateri,
      'gambar_cover': gambarcover,
      'count': count,
    };
  }
}

class DataLaporanStastistik {
  String id;
  String jenistema;
  String count;

  DataLaporanStastistik({
    required this.id,
    required this.jenistema,
    required this.count,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'jenis_tema': jenistema,
      'count': count,
    };
  }
}

class DataPesanGuru {
  String idpesan;
  String isipesan;

  DataPesanGuru({
    required this.idpesan,
    required this.isipesan,
  });

  Map<String, dynamic> toMap() {
    return {
      'id_pesan': idpesan,
      'isi_pesan': isipesan,
    };
  }
}

Future<List<DataTema>> getDataTema(String kdkelas) async {
  print('kdkelas dalam getDataTema: $kdkelas');
  final Uri url =
      Uri.parse('https://hello-ivy.id/get_materi.php?kode_kel=$kdkelas');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = json.decode(response.body);
    final List<dynamic> dataLaporanTema = responseData['values']['data'];
    print('kdkelas dalam getDataTema: $dataLaporanTema');
    List<DataTema> dataTema = [];

    for (var linkTema in dataLaporanTema) {
      DataTema kelasModel = DataTema(
        id: linkTema['id'],
        judulmateri: linkTema['judul_materi'],
        linkmateri: linkTema['link_materi'],
        gambarmateri: linkTema['gambar_materi'],
        gambarcover: linkTema['gambar_cover'],
        count: linkTema['count'],
      );
      dataTema.add(kelasModel);
    }

    return dataTema;
  } else {
    throw Exception('Failed to load quiz data');
  }
}

Future<List<DataLaporanStastistik>> getLaporanStastistik(String kdkelas) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? idnisn = preferences.getString('nisn');
  final Uri url = Uri.parse(
      'https://hello-ivy.id/get_laporan.php?nisn=$idnisn&kode_kel=$kdkelas');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = json.decode(response.body);
    final List<dynamic> dataLaporanTema = responseData['values']['data'];
    print('kdkelas dalam getDataTema: $dataLaporanTema');
    List<DataLaporanStastistik> dataTema = [];

    for (var linkDataLaporanStastistik in dataLaporanTema) {
      DataLaporanStastistik kelasModel = DataLaporanStastistik(
        id: linkDataLaporanStastistik['id_materi'],
        jenistema: linkDataLaporanStastistik['jenis_tema'],
        count: linkDataLaporanStastistik['count'],
      );
      dataTema.add(kelasModel);
    }

    return dataTema;
  } else {
    throw Exception('Failed to load quiz data');
  }
}

Future<List<DataPesanGuru>> getDataPesanGuru(String materi) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? idnisn = preferences.getString('nisn');
  final Uri url = Uri.parse(
      'https://hello-ivy.id/get_pesan_guru.php?nisn=$idnisn&id_materi=$materi');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = json.decode(response.body);
    final List<dynamic> dataLaporanPesan = responseData['values']['data'];
    print('getDataTema: $dataLaporanPesan');
    print('mater:$materi');
    List<DataPesanGuru> dataTema = [];

    for (var linkLaporan in dataLaporanPesan) {
      DataPesanGuru kelasModel = DataPesanGuru(
        idpesan: linkLaporan['id_pesan'],
        isipesan: linkLaporan['isi_pesan'],
      );
      dataTema.add(kelasModel);
    }

    return dataTema;
  } else {
    throw Exception('Failed to load quiz data');
  }
}
