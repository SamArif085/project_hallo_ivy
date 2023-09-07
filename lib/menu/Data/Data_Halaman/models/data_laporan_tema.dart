import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class DataTema {
  String id;
  String judulmateri;
  String linkmateri;
  String gambarmateri;
  String gambarcover;
  String idpesan;
  String isipesan;
  String count;

  DataTema({
    required this.id,
    required this.judulmateri,
    required this.linkmateri,
    required this.gambarmateri,
    required this.gambarcover,
    required this.idpesan,
    required this.isipesan,
    required this.count,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'judul_materi': judulmateri,
      'link_materi': linkmateri,
      'gambar_materi': gambarmateri,
      'gambar_cover': gambarcover,
      'id_pesan': idpesan,
      'isi_pesan': isipesan,
      'count': count,
    };
  }
}

class DataLaporanStastistik {
  String id;
  String jenistema;
  String idpesan;
  String isipesan;
  String count;

  DataLaporanStastistik({
    required this.id,
    required this.jenistema,
    required this.idpesan,
    required this.isipesan,
    required this.count,
  });

   Map<String, dynamic> toMap() {
    return {
      'id': id,
      'jenis_tema': jenistema,
      'id_pesan': idpesan,
      'isi_pesan': isipesan,
      'count': count,
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
    List<DataTema> dataTema = []; // Ubah tipe dataTema ke List<dataTema>

    for (var linkTema in dataLaporanTema) {
      DataTema kelasModel = DataTema(
        id: linkTema['id'],
        judulmateri: linkTema['judul_materi'],
        linkmateri: linkTema['link_materi'],
        gambarmateri: linkTema['gambar_materi'],
        gambarcover: linkTema['gambar_cover'],
        idpesan: linkTema['id_pesan'],
        isipesan: linkTema['isi_pesan'],
        count: linkTema['count'],
      );
      dataTema.add(kelasModel);
    }

    return dataTema; // Kembalikan List<DataKelas>
  } else {
    throw Exception('Failed to load quiz data');
  }
}

Future<List<DataLaporanStastistik>> getLaporanStastistik(String kdkelas) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? idnisn = preferences.getString('nisn');
  final Uri url =
      Uri.parse('https://hello-ivy.id/get_laporan.php?nisn=$idnisn&kode_kel=$kdkelas');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = json.decode(response.body);
    final List<dynamic> dataLaporanTema = responseData['values']['data'];
    print('kdkelas dalam getDataTema: $dataLaporanTema');
    List<DataLaporanStastistik> dataTema = []; // Ubah tipe dataTema ke List<dataTema>

    for (var linkLaporan in dataLaporanTema) {
      DataLaporanStastistik kelasModel = DataLaporanStastistik(
        id: linkLaporan['id'],
        jenistema: linkLaporan['jenis_tema'],
        idpesan: linkLaporan['id_pesan'],
        isipesan: linkLaporan['isi_pesan'],
        count: linkLaporan['count'],
      );
      dataTema.add(kelasModel);
    }

    return dataTema; // Kembalikan List<DataKelas>
  } else {
    throw Exception('Failed to load quiz data');
  }
}
