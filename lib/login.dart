import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:project_hallo_ivy/menu/Dashboard.dart';

class LoginController extends GetxController {
  final RxBool _isObscure = true.obs;
  bool get isObscure => _isObscure.value;

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void togglePasswordVisibility() {
    _isObscure.toggle();
  }

  Future<void> login() async {
    var url = Uri.parse("https://hello-ivy.id/cek_login.php");
    var response = await http.post(url, body: {
      "nisn": usernameController.text,
      "password": passwordController.text,
    });

    var datauser = jsonDecode(response.body);
    var userData = UserData.fromJson(datauser);
    print(userData.values.id); // Contoh penggunaan data dari model UserData

    if (response.statusCode == 200 && datauser['status'] == true) {
      print("Login Success");
      
      // Berpindah ke halaman berikutnya jika login berhasil
      Get.off(() => DashboardHome(
            username: usernameController.text,
            password: passwordController.text,
            userData: userData,
            userDataMateri: userData.linkMateriFull,
            dataGame: userData.linkGame,
            dataTugas: userData.tugasRumah,
            dataQuiz : userData.dataQuiz
            // userDataMateri: userData.values.linkMateriFull, // Kirim data userData ke halaman berikutnya
          ));
    } else {
      print("Login Failed");
      Fluttertoast.showToast(
        msg: "Username atau Password salah",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  // const LoginPage({super.key});

  // @override
  // State<LoginPage> createState() => _LoginPage();
}

class UserDataValues {
  final String id;
  final String nisnSiswa;
  final String password;
  final String nama;
  final String kelas;
  final String materi;
  final String link;
  final String alamat;
  final String ortu;
  final String seks;

  UserDataValues({
    required this.id,
    required this.nisnSiswa,
    required this.password,
    required this.nama,
    required this.kelas,
    required this.materi,
    required this.link,
    required this.alamat,
    required this.ortu,
    required this.seks,
  });

  factory UserDataValues.fromJson(Map<String, dynamic> json) {
    return UserDataValues(
      id: json['id'],
      nisnSiswa: json['nisn_siswa'],
      password: json['password'],
      nama: json['nama'],
      kelas: json['kelas'],
      materi: json['judul'],
      link: json['link_materi'],
      alamat: json['alamat_ortu'],
      ortu: json['nama_ortu'],
      seks: json['jenis_kelamin'],
    );
  }
}


class LinkMateri {
  final String id;
  final String judulMateri;
  final String linkMateri;
  final String createdAt;
  final String idMateri;
  final String kodeKelas;

  LinkMateri({
    required this.id,
    required this.judulMateri,
    required this.linkMateri,
    required this.createdAt,
    required this.idMateri,
    required this.kodeKelas,
  });

  factory LinkMateri.fromJson(Map<String, dynamic> json) {
    return LinkMateri(
      id: json['id'],
      judulMateri: json['judul_materi'],
      linkMateri: json['link_materi'],
      createdAt: json['created_at'],
      idMateri: json['id_materi'],
      kodeKelas: json['kode_kelas'],
    );
  }
}

class LinkGame {
  final String id;
  final String namaGame;
  final String linkGame;
  final String createdAt;

  LinkGame({
    required this.id,
    required this.namaGame,
    required this.linkGame,
    required this.createdAt,
  });

  factory LinkGame.fromJson(Map<String, dynamic> json) {
    return LinkGame(
      id: json['id'],
      namaGame: json['nama_game'],
      linkGame: json['link_game'],
      createdAt: json['created_at'],
    );
  }
}

class Linktugasrumah {
  final String id;
  final String judulPr;
  final String deskripsi;
  final String tenggat;

  Linktugasrumah({
    required this.id,
    required this.judulPr,
    required this.deskripsi,
    required this.tenggat,
  });

  factory Linktugasrumah.fromJson(Map<String, dynamic> json) {
    return Linktugasrumah(
      id: json['id'],
      judulPr: json['judulPr'],
      deskripsi: json['deskripsi'],
      tenggat: json['tenggat'],
    );
  }
}

class Linkquiz {
  final String iddqm;
  final String idquiz;
  final String idmateri;
  final String pertanyaan;
  final String jawaban;
  final String imagelink;

   Linkquiz({
    required this.iddqm,
    required this.idquiz,
    required this.idmateri,
    required this.pertanyaan,
    required this.jawaban,
    required this.imagelink, 
  });

  factory Linkquiz.fromJson(Map<String, dynamic> json) {
    return Linkquiz(
      iddqm: json['id_dqm'],
      idquiz: json['id_quiz'],
      idmateri: json['id_materi'],
      pertanyaan: json['pertanyaan'], 
      jawaban: json['jawaban'],
      imagelink: json['image'],
    );
  }
}

class UserData {
  final bool status;
  final int statusCode;
  final int message;
  final UserDataValues values;
  final List<LinkMateri> linkMateriFull;
  final List<LinkGame> linkGame;
  final List<Linktugasrumah> tugasRumah;
  final List<Linkquiz> dataQuiz;

  UserData({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.values,
    required this.linkMateriFull,
    required this.linkGame,
    required this.tugasRumah,
     required this.dataQuiz,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      status: json['status'] as bool,
      statusCode: int.tryParse(json['statusCode'].toString()) ?? 0,
      message: int.tryParse(json['message'].toString()) ?? 0,
      values: json['values'] != null
          ? UserDataValues.fromJson(json['values'])
          : UserDataValues(
              id: '',
              nisnSiswa: '',
              password: '',
              nama: '',
              kelas: '',
              materi: '',
              link: '',
              alamat: '',
              ortu: '',
              seks: '',
            ),
      linkMateriFull: List<LinkMateri>.from(
        json['link_materi_full']?.map((x) => LinkMateri.fromJson(x)) ?? [],
      ),
      linkGame: List<LinkGame>.from(
        json['link_game']?.map((x) => LinkGame.fromJson(x)) ?? [],
      ),
      tugasRumah: List<Linktugasrumah>.from(
        json['tugas_rumah']?.map((x) => Linktugasrumah.fromJson(x)) ?? [],
      ),
      dataQuiz: List<Linkquiz>.from(
        json['quiz']?.map((x) => Linkquiz.fromJson(x)) ?? [],
      )
    );
  }
}

class LoginPage extends StatelessWidget {
  final LoginController _loginController = Get.put(LoginController());

  LoginPage({super.key});

  void togglePasswordVisibility() {
    _loginController.togglePasswordVisibility();
  }

  //  Get.to(UserDataScreen());
  // var phone = TextEditingController();

  bool notvisible = true;
  bool notVisiblePassword = true;
  Icon passwordIcon = const Icon(Icons.visibility);
  bool emailFormVisibility = true;
  bool otpVisibilty = false;

  String? emailError;
  String? passError;
// ================================================Password Visibility function ===========================================

  void passwordVisibility() {
    if (notVisiblePassword) {
      passwordIcon = const Icon(Icons.visibility);
    } else {
      passwordIcon = const Icon(Icons.visibility_off);
    }
  }

// ================================================Building The Screen ===================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  // Topmost image
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Image.asset(
                      'assets/images/logo.png',
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 10),
                    child: Column(
                      children: [
                        // Login Text
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Login',
                            style: TextStyle(
                                color: Colors.greenAccent,
                                fontSize: 40,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Poppins'),
                          ),
                        ),
                        // Sized box
                        const SizedBox(
                          height: 10,
                        ),
                        Visibility(
                          visible: emailFormVisibility,
                          child: Form(
                            child: Column(
                              children: [
                                TextFormField(
                                  decoration: const InputDecoration(
                                    icon: Icon(
                                      Icons.alternate_email_outlined,
                                      color: Colors.grey,
                                    ),
                                    labelText: 'Username',
                                  ),
                                  controller:
                                      _loginController.usernameController,
                                  // Hapus properti obscureText untuk Username
                                  // obscureText: _loginController.isObscure,
                                ),
                                TextFormField(
                                  obscureText: _loginController.isObscure,
                                  decoration: InputDecoration(
                                    icon: const Icon(
                                      Icons.lock_outline_rounded,
                                      color: Colors.grey,
                                    ),
                                    labelText: 'Password',
                                    suffixIcon: IconButton(
                                      onPressed: togglePasswordVisibility,
                                      icon: passwordIcon,
                                    ),
                                  ),
                                  controller:
                                      _loginController.passwordController,
                                )
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 13),
                        // Forgot Password
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: GestureDetector(
                              child: const Text(
                                'Lupa Password?',
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black),
                              ),
                              onTap: () {},
                            ),
                          ),
                        ),

                        ElevatedButton(
                          onPressed: _loginController.login,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.greenAccent,
                              minimumSize: const Size.fromHeight(45),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          child: const Center(
                              child: Text(
                            "Login",
                            style: TextStyle(fontSize: 15),
                          )),
                        ),
                        // Sized box
                        const SizedBox(height: 15),
                        // Divider and OR
                        Stack(
                          children: [
                            const Divider(
                              thickness: 1,
                            ),
                            Center(
                              child: Container(
                                color: Colors.white,
                                width: 70,
                                child: const Center(
                                  child: Text(
                                    "With",
                                    style: TextStyle(
                                        fontSize: 20,
                                        backgroundColor: Colors.white),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        // Sized box
                        const SizedBox(height: 20),
                        // Login with google

                        // Sized box
                        const SizedBox(height: 25),
                        // Register button
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Flexible(
                                flex: 1,
                                child: Image.asset(
                                  'assets/Lambang-AK.png',
                                  height: 60,
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Image.asset(
                                  'assets/patreon.png',
                                  height: 60,
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Image.asset(
                                  'assets/jatim.png',
                                  height: 60,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
