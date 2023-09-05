import 'dart:convert';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../Module/bottom_navigation_view/bottom_bar_view.dart';
import '../data/data.dart';
import '../models/question_model.dart';
import 'result.dart';

class PlayQuiz extends StatefulWidget {
  const PlayQuiz({
    Key? key,
    required this.materi,
  }) : super(key: key);
  final Map<String, dynamic> materi;
  @override
  _PlayQuizState createState() => _PlayQuizState();
}

class _PlayQuizState extends State<PlayQuiz> with TickerProviderStateMixin {
  // ignore: non_constant_identifier_names
  List<QuestionModel> Quest = [];
  int index = 0;
  int points = 0;
  int correct = 0;
  int incorrect = 0;
  late AnimationController controller;
  late Animation animation;
  double beginAnim = 0.0;
  double endAnim = 1.0;
  int totalQuiz = 0;
  late FlickManager flickManager;
  int currentVideoIndex = 0;

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
  void dispose() {
    flickManager.dispose(); // Menghentikan pemutar video
    controller.dispose(); // Membebaskan sumber daya animasi
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 10000),
      vsync: this,
    );

    controller = AnimationController(
        duration: const Duration(seconds: 10000), vsync: this);
    animation = Tween(begin: beginAnim, end: endAnim).animate(controller)
      ..addListener(() {
        setState(() {
          // Change here any Animation object value.
        });
      });
    startProgress();
    print(widget.materi['id']);
    int idMateri = int.tryParse(widget.materi['id'] ?? "") ?? 0;
    populateQuestions(idMateri);

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
                  materi: widget.materi,
                ),
              ),
            );
          }
        }
      },
    );
  }

  Future<void> populateQuestions(int idMateri) async {
    final userData = await getUserData();

    if (userData != null) {
      Quest = await getQuestions(idMateri);
      totalQuiz = Quest.length;

      setState(() {
        currentVideoIndex = 0;
        var controllervideo =
            VideoPlayerController.network(Quest[index].imageUrl);
        print(Quest[index].imageUrl);
        flickManager = FlickManager(
          videoPlayerController: controllervideo,
          autoPlay: true,
        );
      }); // Memicu rebuild UI
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
      setState(() {
        currentVideoIndex++; // Pindah ke video berikutnya
        var controllervideo =
            VideoPlayerController.network(Quest[currentVideoIndex].imageUrl);
        flickManager.dispose(); // Hentikan video sebelumnya
        flickManager = FlickManager(
          videoPlayerController: controllervideo,
          autoPlay: true,
        );
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Result(
            score: points,
            totalQuestion: Quest.length,
            correct: correct,
            incorrect: incorrect,
            materi: widget.materi,
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
        // color: HexColor('#85f29d'),
        padding: const EdgeInsets.fromLTRB(0, 24, 0, 10),
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              color: HexColor('#85f29d'),
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              color: HexColor('#85f29d'),
              child: Row(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "${index + 1}/$totalQuiz",
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
            Container(
              color: HexColor('#85f29d'),
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Text(
                "${currentQuestion.getQuestion()}?",
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            // Container(
            //   child: LinearProgressIndicator(
            //     value: animation.value,
            //     color: Colors.red,
            //   ),
            // ),
            FractionallySizedBox(
              widthFactor: 0.9,
              child: VisibilityDetector(
                key: ObjectKey(flickManager),
                onVisibilityChanged: (visibility) {
                  if (visibility.visibleFraction == 0 && this.mounted) {
                    flickManager.flickControlManager?.autoPause();
                  } else if (visibility.visibleFraction == 1) {
                    flickManager.flickControlManager?.autoResume();
                    setState(() {});
                  }
                },
                child: FlickVideoPlayer(
                  flickManager: flickManager,
                  flickVideoWithControls: const FlickVideoWithControls(
                    closedCaptionTextStyle: TextStyle(fontSize: 8),
                    controls: FlickPortraitControls(),
                  ),
                  flickVideoWithControlsFullscreen:
                      const FlickVideoWithControls(
                    controls: FlickLandscapeControls(),
                  ),
                ),
              ),
            ),
            // FractionallySizedBox(
            //   widthFactor: 0.9, // Ukuran gambar sebesar 80% lebar layar
            //   child:
            //       CachedNetworkImage(imageUrl: currentQuestion.getImageUrl()),
            // ),
            const Spacer(),
            Container(
              // width: 300,
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (currentQuestion.getAnswer() == "Betul") {
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
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                            color: Colors.lightBlue,
                            borderRadius: BorderRadius.circular(24)),
                        child: Image.asset(
                          'assets/icon/thumb-up-14-64.png',
                          // width: 1,
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
                        if (currentQuestion.getAnswer() == "Salah") {
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
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(24)),
                        child: Image.asset(
                          'assets/icon/thumb-down-10-64.png',
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
}
