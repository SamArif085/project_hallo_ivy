import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/data.dart';
import '../models/question_model.dart';
import 'result.dart';



class PlayQuiz extends StatefulWidget {
  const PlayQuiz({Key? key}) : super(key: key);

  @override
  _PlayQuizState createState() => _PlayQuizState();
}

class _PlayQuizState extends State<PlayQuiz> with TickerProviderStateMixin {
 List<QuestionModel> Quest = [];
  int index = 0;
  int points = 0;
  int correct = 0;
  int incorrect = 0;
  late AnimationController controller;
  late Animation animation;
  double beginAnim = 0.0;
  double endAnim = 1.0;

  void replayQuiz(BuildContext context) {
    setState(() {
      // Reset values
      index = 0;
      points = 0;
      correct = 0;
      incorrect = 0;

      // Reset animation and timer
      resetProgress();
      startProgress();
    });
  }

@override
void initState() {
  super.initState();
  controller = AnimationController(
    duration: const Duration(seconds: 10),
    vsync: this,
  );
  
 controller =
        AnimationController(duration: const Duration(seconds: 10), vsync: this);
    animation = Tween(begin: beginAnim, end: endAnim).animate(controller)
      ..addListener(() {
        setState(() {
          // Change here any Animation object value.
        });
      });
  startProgress();

   populateQuestions();

  animation.addStatusListener(
    (AnimationStatus animationStatus) {
      if (animationStatus == AnimationStatus.completed) {
        if (index < Quest.length - 1) {
          index++;
          resetProgress();
          startProgress();
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Result(
                score: points,
                totalQuestion: Quest.length,
                correct: correct,
                incorrect: incorrect,
              ),
            ),
          );
        }
      }
    },
  );
}

 Future<void> populateQuestions() async {
  final userData = await getUserData();
  if (userData != null) {
    Quest = await getQuestions(userData);
    setState(() {}); // Memicu rebuild UI
  }
}

  Future<Map<String, dynamic>?> getUserData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userDataString = preferences.getString('userData');
    if (userDataString != null) {
      Map<String, dynamic> userData = jsonDecode(userDataString);
      return userData;
    }
    return null;
  }

  startProgress() {
    controller.forward();
  }

  resetProgress() {
    controller.reset();
  }

void nextQuestion() {
  if (index < Quest.length - 1) {
    index++;
    resetProgress();
    startProgress();
  } else {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Result(
          score: points,
          totalQuestion: Quest.length,
          correct: correct,
          incorrect: incorrect,
        ),
      ),
    );
  }
}

  @override
 Widget build(BuildContext context) {
    if (Quest.isEmpty) {
      // Loading indicator or message if questions are still loading
      return const CircularProgressIndicator();
    }

    final currentQuestion = Quest[index];

return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "${index + 1}/${currentQuestion.question.length}",
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        "Question",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w300),
                      )
                    ],
                  ),
                  const Spacer(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "$points",
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        "Points",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w300),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "${currentQuestion.getQuestion()}?",
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              child: LinearProgressIndicator(
                value: animation.value,
              ),
            ),
            FractionallySizedBox(
              widthFactor: 0.7, // Ukuran gambar sebesar 80% lebar layar
              child:
                  CachedNetworkImage(imageUrl: currentQuestion.getImageUrl()),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (currentQuestion.getAnswer() ==
                          "Betul" ) {
                          setState(() {
                            points = points + 20;
                            nextQuestion();
                            correct++;
                          });
                        } else {
                          setState(() {
                            points = points - 5;
                            nextQuestion();
                            incorrect++;
                          });
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                            color: Colors.lightBlue,
                            borderRadius: BorderRadius.circular(24)),
                        child: const Icon(
                          Icons.thumb_up_outlined,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: GestureDetector(
                            onTap: () {
                        if (currentQuestion.getAnswer() == "salah") {
                          // Update this condition
                          setState(() {
                            points = points + 20;
                            nextQuestion();
                            correct++;
                          });
                        } else {
                          setState(() {
                            points = points - 5;
                            nextQuestion();
                            incorrect++;
                          });
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(24)),
                        child: const Icon(
                          Icons.thumb_down_outlined,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
