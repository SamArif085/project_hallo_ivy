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
            userData: userData,// Kirim data userData ke halaman berikutnya
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

  UserDataValues({
    required this.id,
    required this.nisnSiswa,
    required this.password,
    required this.nama,
    required this.kelas,
    required this.materi,
    required this.link,
  });

  factory UserDataValues.fromJson(Map<String, dynamic> json,
      {required id,
      required nisnSiswa,
      required password,
      required nama,
      required kelas,
       required materi,
        required link}) {
    return UserDataValues(
      id: json['id'],
      nisnSiswa: json['nisn_siswa'],
      password: json['password'],
      nama: json['nama'],
      kelas: json['kelas'],
      materi: json['judul_materi'],
      link: json['link_materi'],
    );
  }
}

class UserData {
  final bool status;
  final int statusCode;
  final int message;
  final UserDataValues values;

  UserData({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.values,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      status: json['status'] as bool,
      statusCode: int.tryParse(json['statusCode'].toString()) ?? 0,
      message: int.tryParse(json['message'].toString()) ?? 0,
      values: json['values'] != null
          ? UserDataValues(
              id: json['values']['id'],
              nisnSiswa: json['values']['nisn_siswa'],
              password: json['values']['password'],
              nama: json['values']['nama'],
              kelas: json['values']['kelas'],
              materi: json['values']['judul_materi'],
              link: json['values']['link_materi'],
            )
          : UserDataValues(
              id: '',
              nisnSiswa: '',
              password: '',
              nama: '',
              kelas: '',
              materi: '',
              link: ''),
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
                                controller: _loginController.usernameController,
                                obscureText: _loginController.isObscure,
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
                                        icon: passwordIcon)),
                                controller: _loginController.passwordController,
                              )
                            ],
                          )),
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
                            child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                child: Image.asset(
                                  'assets/Lambang-AK.png',
                                  height: 80,
                                  width: 80,
                                ),
                              ),
                              Image.asset(
                                'assets/patreon.png',
                                height: 80,
                              ),
                              Image.asset(
                                'assets/jatim.png',
                                height: 80,
                              )
                            ],
                          ),
                        ))
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
