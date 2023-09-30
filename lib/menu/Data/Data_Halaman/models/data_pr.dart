import 'package:http/http.dart' as http;
import 'dart:convert';

class dataPRAktif {
  String id;
  String judulPr;
  String deskripsi;
  String kodeKelas;
  String tenggat;
  String status;

  dataPRAktif({
    required this.id,
    required this.judulPr,
    required this.deskripsi,
    required this.kodeKelas,
    required this.status,
    required this.tenggat,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'judulPr': judulPr,
      'deskripsi': deskripsi,
      'kode_kelas': kodeKelas,
      'tenggat': tenggat,
      'status': status,
    };
  }
}

// ignore: camel_case_types
class dataPRSelesai {
  String id;
  String judulPr;
  String deskripsi;
  String kodeKelas;
  String tenggat;
  String status;

  dataPRSelesai({
    required this.id,
    required this.judulPr,
    required this.deskripsi,
    required this.kodeKelas,
    required this.status,
    required this.tenggat,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'judulPr': judulPr,
      'deskripsi': deskripsi,
      'kode_kelas': kodeKelas,
      'tenggat': tenggat,
      'status': status,
    };
  }
}

Future<List<dataPRAktif>> getDataPRAktif(String kodeKelas) async {
  final Uri url =
      Uri.parse('https://hello-ivy.id/get_pr_aktif.php?kode_kel=$kodeKelas');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = json.decode(response.body);
    final List<dynamic> dataPR = responseData['values']['data'];
    print('kdkelas dalam getDataTema: $dataPR');
    List<dataPRAktif> dataTema = [];
    for (var linkDataAktif in dataPR) {
      dataPRAktif kelasModel = dataPRAktif(
          id: linkDataAktif['id'],
          judulPr: linkDataAktif['judulPr'],
          deskripsi: linkDataAktif['deskripsi'],
          kodeKelas: linkDataAktif['kode_kelas'],
          tenggat: linkDataAktif['tenggat'],
          status: linkDataAktif['status']);
      dataTema.add(kelasModel);
    }
    return dataTema;
  } else {
    throw Exception('Failed to load quiz data');
  }
}

Future<List<dataPRSelesai>> getDataPRSelesai(String kodeKelas) async{
  final Uri url =
      Uri.parse('https://hello-ivy.id/api-mobile/get_pr_selesai.php?kode_kel=$kodeKelas');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = json.decode(response.body);
    final List<dynamic> dataPR = responseData['values']['data'];
    print('status pr selesai : $dataPR');
    List<dataPRSelesai> dataTema = [];
    for (var linkDataAktif in dataPR) {
      dataPRSelesai kelasModel = dataPRSelesai(
          id: linkDataAktif['id'],
          judulPr: linkDataAktif['judulPr'],
          deskripsi: linkDataAktif['deskripsi'],
          kodeKelas: linkDataAktif['kode_kelas'],
          tenggat: linkDataAktif['tenggat'],
          status: linkDataAktif['status']);
      dataTema.add(kelasModel);
    }
    return dataTema;
  } else {
    throw Exception('Failed to load quiz data');
  }
}

