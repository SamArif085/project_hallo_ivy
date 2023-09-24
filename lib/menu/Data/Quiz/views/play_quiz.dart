import 'dart:convert';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:hello_ivy_test/menu/Data/Data_Halaman/color_Theme.dart';
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
  List<QuestionModel> Quest = [];
  int index = 0;
  int answeredQuestions = 0;
  int correct = 0;
  int incorrect = 0;
  late AnimationController controller;
  late Animation animation;
  double beginAnim = 0.0;
  double endAnim = 1.0;
  int totalQuiz = 0;
  late FlickManager flickManager = FlickManager(
    videoPlayerController: VideoPlayerController.network(''), // Video kosong
  );
  int currentVideoIndex = 0;

  void replayQuiz(BuildContext context) {
    setState(() {
      index = 0;
      correct = 0;
      incorrect = 0;
      resetProgress();
      startProgress();
    });
  }

  @override
  void dispose() {
    flickManager.dispose();
    controller.dispose();
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
            double scorePercentage = (correct / answeredQuestions) * 100.0;
            if (scorePercentage > 100) {
              scorePercentage = 100; // Batasan maksimal poin adalah 100
            }
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Result(
                  score: scorePercentage
                      .toInt(), // Mengonversi poin menjadi integer
                  totalQuestion: answeredQuestions,
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

      if (Quest.isEmpty) {
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Tidak Ada Pertanyaan Tersedia'),
              content: const Text(
                  'Mohon maaf, saat ini tidak ada pertanyaan yang tersedia untuk kuis ini.'),
              actions: <Widget>[
                TextButton(
                  child: const Text('Kembali'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
        setState(() {
          currentVideoIndex = 0;
          var controllervideo =
              VideoPlayerController.network(Quest[index].imageUrl);
          print(Quest[index].imageUrl);
          flickManager.dispose();
          flickManager = FlickManager(
            videoPlayerController: controllervideo,
            autoPlay: true,
          );
        });
      }
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
        currentVideoIndex++;
        var controllervideo =
            VideoPlayerController.network(Quest[currentVideoIndex].imageUrl);
        flickManager.dispose();
        flickManager = FlickManager(
          videoPlayerController: controllervideo,
          autoPlay: true,
        );
      });
    } else {
      double scorePercentage = (correct / answeredQuestions) * 100.0;
      if (scorePercentage > 100) {
        scorePercentage = 100; // Batasan maksimal poin adalah 100
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Result(
            score: scorePercentage.toInt(), // Mengonversi poin menjadi integer
            totalQuestion: answeredQuestions,
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
      return const Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 24), // Jarak antara indikator progres dan teks
              Text('Mohon Tunggu'),
            ],
          ),
        ),
      );
    }
    final currentQuestion = Quest[index];

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Jumlah Kuis",
              style: TextStyle(
                fontSize: 15,
                color: DesignCourseAppTheme.darkText,
              ),
            ),
            Text(
              "${index + 1}/$totalQuiz",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: DesignCourseAppTheme.darkText,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
        elevation: 0,
        backgroundColor: HexColor('#85f29d'),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: DesignCourseAppTheme.darkText,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            LinearProgressIndicator(
              value: (index + 1) /
                  totalQuiz, // Hitung kemajuan berdasarkan nomor soal saat ini
              color: Colors.blueAccent,
              backgroundColor: HexColor('#85f29d'),
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
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (currentQuestion.getAnswer() == "Betul") {
                          setState(() {
                            correct++;
                            answeredQuestions++;
                          });
                        } else {
                          setState(() {
                            incorrect++;
                            answeredQuestions++;
                          });
                        }
                        nextQuestion();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                            color: Colors.lightBlue,
                            borderRadius: BorderRadius.circular(24)),
                        child: Image.asset(
                          'assets/icon/thumb-up-14-64.png',
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
                          setState(() {
                            correct++;
                            answeredQuestions++;
                          });
                        } else {
                          setState(() {
                            incorrect++;
                            answeredQuestions++;
                          });
                        }
                        nextQuestion();
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
