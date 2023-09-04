// ignore_for_file: camel_case_types, must_be_immutable

import 'package:flutter/material.dart';

import '../../Module/bottom_navigation_view/bottom_bar_view.dart';
import 'list_quiz.dart';
import 'play_quiz.dart';

class Result extends StatelessWidget {
  final int score;
  final int totalQuestion;
  final int correct;
  final int incorrect;
  final Map<String, dynamic> materi;

  const Result({
    Key? key,
    required this.score,
    required this.totalQuestion,
    required this.correct,
    required this.incorrect,
    required this.materi,
    // Add this line
  }) : super(key: key);

// Inisialisasi objek userData
  void replayQuiz(
    BuildContext context,
  ) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => PlayQuiz(materi: materi),
      ),
    );
  }

// ignore: non_constant_identifier_names
  void Home(
    BuildContext context,
  ) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const QuizMenu(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Di sini, Anda dapat merancang tampilan untuk hasil kuis
    // Gunakan nilai-nilai seperti 'score', 'totalQuestion', 'correct', dan 'incorrect'
    // untuk menampilkan informasi yang sesuai.
    // Contoh:
    return Scaffold(
      appBar: AppBar(
        title: Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 55, 0),
            child: const Center(
              child: Text('Result'),
            )),
        elevation: 0,
        backgroundColor: HexColor('#85f29d'),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: HexColor('#85f29d'),
        ),
        child: Center(
          child: Container(
            height: 350,
            margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Card(
              elevation: 7,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Your Score',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    '$score',
                    style: const TextStyle(
                      fontSize: 130,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      resultInfo(
                        value: '$totalQuestion',
                        color: 'ADC4CE',
                        info: 'Total',
                      ),
                      resultInfo(
                        value: '$correct',
                        color: '9BE8D8',
                        info: 'Correct',
                      ),
                      resultInfo(
                        value: '$incorrect',
                        color: 'EF6262',
                        info: 'incorrect',
                      ),
                    ],
                  ),
                  // nilai seng perlu dirubah
                  // if (score <= 10)
                  if (correct <= totalQuestion / 2)
                    ElevatedButton(
                      onPressed: () {
                        Home(
                          context,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: HexColor('F24C3D'),
                        elevation: 8,
                      ),
                      child: const Text(
                        'Ulang Quiz',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    )
                  else
                    ElevatedButton(
                      onPressed: () {
                        Home(
                          context,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: HexColor('85f29d'),
                        elevation: 8,
                      ),
                      child: const Text(
                        'Next Materi',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class resultInfo extends StatelessWidget {
  String value;
  String color;
  String info;
  resultInfo(
      {super.key,
      required this.value,
      required this.color,
      required this.info});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: HexColor(color),
        ),
        padding: const EdgeInsets.all(10),
        child: Text('$info: $value'),
      ),
    );
  }
}
