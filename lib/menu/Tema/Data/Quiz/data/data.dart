import 'dart:convert';

import 'package:hello_ivy_test/menu/Tema/Data/Quiz/models/question_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<List<QuestionModel>> getQuestions(userData) async {
  List<QuestionModel> questions = [];

  List<Map<String, dynamic>> quizData = await fetchUserMaterials();
  
  for (var linkquiz in quizData) {
    QuestionModel questionModel = QuestionModel(
  id: linkquiz['id_quiz'],
  question: linkquiz['pertanyaan'],
  answer: linkquiz['jawaban'],
  imageUrl: linkquiz['image'],
);
    questions.add(questionModel);
  }

  return questions;
}

Future<List<Map<String, dynamic>>> fetchUserMaterials() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? userDataString = preferences.getString('userData');
  if (userDataString != null) {
    Map<String, dynamic> userData = jsonDecode(userDataString);
    // Assuming "quiz" is the key for user's quiz data
    return userData['quiz'].cast<Map<String, dynamic>>();
  } else {
    return []; // Return an empty list if no user data is found
  }
}
