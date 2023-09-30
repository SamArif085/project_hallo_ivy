import 'package:http/http.dart' as http;
import 'dart:convert';

class DataKelas {
  String kdkelas;
  String ketkelas;
  String gambar;

  DataKelas({
    required this.kdkelas,
    required this.ketkelas,
    required this.gambar,
  });
}

Future<List<DataKelas>> getKelas() async {
  final Uri url = Uri.parse('https://hello-ivy.id/api-mobile/get_kelas.php');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = json.decode(response.body);
    final List<dynamic> quizData = responseData['values']['data'];
    List<DataKelas> dataKelas = [];
    for (var linkKelas in quizData) {
      DataKelas kelasModel = DataKelas(
        kdkelas: linkKelas['kode_kelas'],
        ketkelas: linkKelas['ket_kelas'],
        gambar: linkKelas['image'],
      );
      dataKelas.add(kelasModel);
    }
    return dataKelas;
  } else {
    throw Exception('Failed to load quiz data');
  }
}
