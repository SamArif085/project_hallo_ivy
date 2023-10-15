import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/question_model.dart';
import 'package:http/http.dart' as http;

Future<List<QuestionModel>> getQuestions(int idMateri) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? idnisn = preferences.getString('nisn');
  final Uri url = Uri.parse(
      'https://hello-ivy.id/api-mobile/get_quiz.php?id_materi=$idMateri&nisn=$idnisn');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = json.decode(response.body);

    if (responseData.containsKey('status') &&
        responseData.containsKey('statusCode') &&
        responseData.containsKey('message') &&
        responseData['status'] == false &&
        responseData['statusCode'] == 400 &&
        responseData['message'] == "Data Not Found") {
      print('Data kuis tidak ditemukan.');
      return []; // Mengembalikan daftar kosong jika data tidak ditemukan
    }

    if (responseData.containsKey('values') &&
        responseData['values'].containsKey('data')) {
      final List<dynamic> quizData = responseData['values']['data'];

      List<QuestionModel> questions = [];

      for (var linkquiz in quizData) {
        QuestionModel questionModel = QuestionModel(
          id: linkquiz['id_materi'],
          question: linkquiz['pertanyaan'],
          answer: linkquiz['ket_jawab'],
          imageUrl: linkquiz['link_quiz'],
        );
        questions.add(questionModel);
      }

      if (questions.isEmpty) {
        print('Tidak ada pertanyaan yang tersedia.');
      }

      return questions;
    } else {
      throw Exception('Data kuis tidak ditemukan atau tidak sesuai format.');
    }
  } else {
    throw Exception('Gagal memuat data kuis');
  }
}
