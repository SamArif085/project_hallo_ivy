import 'package:flutter/material.dart';
import 'package:project_hallo_ivy/login.dart';
import 'package:project_hallo_ivy/menu/Tema/Data/Quiz/views/homepage.dart';
import 'package:project_hallo_ivy/menu/Tema/Data/Quiz/views/play_quiz.dart';

// Inisialisasi objek userData
void replayQuiz(BuildContext context, UserData userData) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => PlayQuiz(userData: userData),
    ),
  );
}

void Home(BuildContext context, UserData userData) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => HomePage(userData: userData),
    ),
  );
}

class Result extends StatelessWidget {
  final int score;
  final int totalQuestion;
  final int correct;
  final int incorrect;
  final UserData userData; // Add this line

  const Result({
    Key? key,
    required this.score,
    required this.totalQuestion,
    required this.correct,
    required this.incorrect,
    required this.userData, // Add this line
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Di sini, Anda dapat merancang tampilan untuk hasil kuis
    // Gunakan nilai-nilai seperti 'score', 'totalQuestion', 'correct', dan 'incorrect'
    // untuk menampilkan informasi yang sesuai.
    // Contoh:
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Your Score: $score'),
            Text('Total Questions: $totalQuestion'),
            Text('Correct Answers: $correct'),
            Text('Incorrect Answers: $incorrect'),
            ElevatedButton(
              onPressed: () {
                // Ketika tombol "Play Again" ditekan, panggil fungsi untuk mengulang kuis.
                Home(context, userData);
              },
              child: const Text('Home'),
            ),
          ],
        ),
      ),
    );
  }
}
