import 'package:http/http.dart' as http;
import 'dart:convert';

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
