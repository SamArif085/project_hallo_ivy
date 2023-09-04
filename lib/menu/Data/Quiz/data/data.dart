import 'dart:convert';

import '../models/question_model.dart';
import 'package:http/http.dart' as http;

Future<List<QuestionModel>> getQuestions(int idMateri) async {
  final Uri url =
      Uri.parse('https://hello-ivy.id/get_quiz.php?id_materi=$idMateri');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = json.decode(response.body);
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

    return questions;
  } else {
    throw Exception('Failed to load quiz data');
  }
}
