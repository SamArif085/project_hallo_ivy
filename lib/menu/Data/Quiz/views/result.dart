import 'package:flutter/material.dart';
import 'package:hello_ivy_test/menu/Data/Data_Halaman/models/refreshdata.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
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
  }) : super(key: key);

  void replayQuiz(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => PlayQuiz(materi: materi),
      ),
    );
  }

  void nextMateri(BuildContext context) async {
    try {
      final Uri url = Uri.parse('https://hello-ivy.id/post_quiz.php');
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? idnisn = preferences.getString('nisn');
      var request = http.MultipartRequest('POST', url);
      request.fields['nisn'] = idnisn!;
      request.fields['namaSiswa'] = '${materi['namaUser']}';
      request.fields['kodeKelas'] = '${materi['kode_kelas']}';
      request.fields['idTema'] = '${materi['id']}';
      request.fields['judulTema'] = '${materi['judul_materi']}';
      request.fields['nilaiQuiz'] = '$score';
      var response = await request.send();
      if (response.statusCode == 200) {
        await UserDataManager.refreshUserData();
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const QuizMenu(data: "refresh"),
          ),
        );
        UserDataManager.refreshUserData();
        print('Data berhasil dikirim ke server');
        print('$request');
      } else {
        print('Gagal mengirim data ke server');
      }
    } catch (e) {
      print('Terjadi kesalahan: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          margin: const EdgeInsets.fromLTRB(0, 0, 55, 0),
          child: const Center(
            child: Text('Result'),
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.orangeAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.orangeAccent,
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
                        color: '#70f49c',
                        info: 'Correct',
                      ),
                      resultInfo(
                        value: '$incorrect',
                        color: 'EF6262',
                        info: 'incorrect',
                      ),
                    ],
                  ),
                  if (correct <= totalQuestion / 2 ||
                      (correct / totalQuestion) * 100 < 70)
                    ElevatedButton(
                      onPressed: () {
                        replayQuiz(context);
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
                        nextMateri(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: HexColor('85f29d'),
                        elevation: 8,
                      ),
                      child: const Text(
                        'Next Quiz',
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

// ignore: must_be_immutable, camel_case_types
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
