import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hello_ivy_test/menu/Data/Module/bottom_navigation_view/bottom_bar_view.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'menu/Dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Map<String, dynamic> userData =
      await getUserDataFromPreferences(); // Use 'await' here
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false, // Add this
      home: userData.isEmpty ? const Login() : const DashboardHome()));
}

Future<Map<String, dynamic>> getUserDataFromPreferences() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? userDataString = preferences.getString('userData');
  if (userDataString != null) {
    return jsonDecode(userDataString);
  } else {
    return {}; // Return an empty map if no user data is found
  }
}

class Login extends StatefulWidget {
  const Login({
    super.key,
  });

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  bool notvisible = true;
  bool notVisiblePassword = true;
  Icon passwordIcon = const Icon(Icons.visibility);
  bool emailFormVisibility = true;
  bool otpVisibilty = false;

  String? emailError;
  String? passError;

  Future<void> checkLogin() async {
    String nisn = emailController.text;
    String password = passController.text;

    // Replace with your actual server URL
    String serverUrl = "https://hello-ivy.id/api-mobile/cek_login.php";
    // Create a map for your login data
    Map<String, dynamic> loginData = {
      "nisn": nisn,
      "password": password,
    };

    try {
      var request = http.MultipartRequest('POST', Uri.parse(serverUrl));
      request.fields['nisn'] = nisn;
      request.fields['password'] = password;

      var response = await request.send();

      if (response.statusCode == 200) {
        // Successful response
        String responseBody = await response.stream.bytesToString();
        print("Request URL: $serverUrl");
        print("Response Status Code: ${response.statusCode}");
        print("Response Body: $responseBody");
        Map<String, dynamic> serverResponse = jsonDecode(responseBody);
        print("Request Body: ${jsonEncode(loginData)}");

        if (serverResponse['status'] == true) {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          preferences.setString('nisn', nisn);
          preferences.setString('password', password);
          preferences.setString('userData', jsonEncode(serverResponse));

          // ignore: use_build_context_synchronously
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DashboardHome()),
          );

          Fluttertoast.showToast(
            msg: "Login Successful",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.greenAccent,
            textColor: Colors.black,
            fontSize: 16.0,
          );
        } else {
          // Invalid server response
          Fluttertoast.showToast(
              msg: "Username & Password salah!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.black,
              fontSize: 16.0);
        }
      } else {
        // Error response
        Fluttertoast.showToast(
            msg: "Username & Password salah!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.black,
            fontSize: 16.0);
      }
    } catch (e) {
      print("Error: $e");
      // Handle exception or error here
      Fluttertoast.showToast(
          msg: "Ada kesalahan pada server ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.black,
          fontSize: 16.0);
    }
  }

// ================================================Password Visibility function ===========================================

  void togglePasswordVisibility() {
    setState(() {
      notVisiblePassword = !notVisiblePassword;
      passwordVisibility();
    });
  }

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
        backgroundColor: HexColor('ff8478'),
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
                    padding: const EdgeInsets.only(
                      top: 8.0,
                      right: 35.0,
                      left: 35.0,
                    ),
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
                                color: Colors.white,
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
                                        color: Colors.white,
                                      ),
                                      labelText: 'Username',
                                    ),
                                    controller: emailController),
                                TextFormField(
                                    obscureText: notVisiblePassword,
                                    decoration: InputDecoration(
                                      icon: const Icon(
                                        Icons.lock_outline_rounded,
                                        color: Colors.white,
                                      ),
                                      labelText: 'Password',
                                      suffixIcon: IconButton(
                                        onPressed: togglePasswordVisibility,
                                        icon: notVisiblePassword
                                            ? const Icon(Icons.visibility)
                                            : const Icon(Icons.visibility_off),
                                      ),
                                    ),
                                    controller: passController)
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 50),
                        ElevatedButton(
                          onPressed: () {
                            checkLogin();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color.fromRGBO(255, 132, 120, 100),
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
                                color: HexColor('ff8478'),
                                width: 70,
                                child: const Center(
                                  child: Text(
                                    "With",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 20),
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
