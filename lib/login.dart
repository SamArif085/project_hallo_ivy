import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:project_hallo_ivy/menu/Dashboard.dart';

import 'menu/Tema/Data/Test/Test.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
// =========================================Declaring are the required variables=============================================
  // final _formKey = GlobalKey<FormState>();

  //FormKey é responsável em dizer se o usuário adicionou algum dado incorreto

  //os dados de email e senha, ou seja, vamos ter o controle

  TextEditingController id = TextEditingController();
  TextEditingController password = TextEditingController();
  var phone = TextEditingController();

  bool notvisible = true;
  bool notVisiblePassword = true;
  Icon passwordIcon = const Icon(Icons.visibility);
  bool emailFormVisibility = true;
  bool otpVisibilty = false;

  String? emailError;
  String? passError;

  Future<void> _login() async {
    var url = Uri.parse("https://hello-ivy.id/cek_login.php");
    var response = await http.post(url, body: {
      "nisn": id.text,
      "password": password.text,
    });

    var data = jsonDecode(response.body);
    print(response.body);

    if (data['statusCode'] == 200) {
      print(data);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => FitnessAppHomeScreen()));
    } else {
      print(data);
      Fluttertoast.showToast(
        backgroundColor: Colors.red,
        textColor: Colors.white,
        msg: 'Username and password invalid',
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }
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
        body: Container(
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
                            // key: _formKey,
                            child: Column(
                          children: [
                            TextFormField(
                              decoration: const InputDecoration(
                                icon: Icon(
                                  Icons.alternate_email_outlined,
                                  color: Colors.grey,
                                ),
                                labelText: 'Email ID',
                              ),
                              controller: id,
                            ),
                            TextFormField(
                              obscureText: notvisible,
                              decoration: InputDecoration(
                                  icon: const Icon(
                                    Icons.lock_outline_rounded,
                                    color: Colors.grey,
                                  ),
                                  labelText: 'Password',
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          notvisible = !notvisible;
                                          notVisiblePassword =
                                              !notVisiblePassword;
                                          passwordVisibility();
                                        });
                                      },
                                      icon: passwordIcon)),
                              controller: password,
                            )
                          ],
                        )),
                      ),
                      // Visibility(
                      //     visible: !emailFormVisibility,
                      //     child: Form(
                      //       child: TextFormField(
                      //         decoration: InputDecoration(
                      //             icon: const Icon(
                      //               Icons.phone_android_rounded,
                      //               color: Colors.grey,
                      //             ),
                      //             labelText: 'Phone Number',
                      //             suffixIcon: IconButton(
                      //                 onPressed: () {
                      //                   setState(() {
                      //                     emailFormVisibility =
                      //                         !emailFormVisibility;
                      //                   });
                      //                 },
                      //                 icon: const Icon(
                      //                     Icons.alternate_email_rounded))),
                      //         controller: phone,
                      //       ),
                      //     ),),

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
                        onPressed: () {
                          _login();
                        },
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
                      ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
