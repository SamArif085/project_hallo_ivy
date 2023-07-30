import 'package:flutter/material.dart';
import 'package:project_hallo_ivy/menu/Tema/Data/Quiz/views/homepage.dart';
import 'package:project_hallo_ivy/menu/Tema/Data/Quiz/views/play_quiz.dart';
void replayQuiz(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const PlayQuiz(),
      ),
    );
  }

  void Home(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
    );
  }

class Result extends StatelessWidget {
  final int score;
  final int totalQuestion;
  final int correct;
  final int incorrect;

  const Result({super.key, 
    required this.score,
    required this.totalQuestion,
    required this.correct,
    required this.incorrect,
  });

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
                replayQuiz(context);
              },
              child: const Text('Play Again'),
            ),
             ElevatedButton(
              onPressed: () {
                // Ketika tombol "Play Again" ditekan, panggil fungsi untuk mengulang kuis.
                Home(context);
              },
              child: const Text('Home'),
            ),
          ],
        ),
      ),
    );
  }
}
