import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserDataManager {
  static Future<void> refreshUserData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? nisn = preferences.getString('nisn');
    String? password = preferences.getString('password');
    if (nisn != null && password != null) {
      try {
        Map<String, dynamic> updatedUserData =
            await fetchUpdatedUserDataFromServer(nisn, password);
        preferences.setString('userData', jsonEncode(updatedUserData));
        print("Data updated successfully");
      } catch (e) {
        print("Error fetching and saving data: $e");
      }
    } else {
      print("nisn or password is null");
    }
  }

  static Future<Map<String, dynamic>> fetchUpdatedUserDataFromServer(
      String nisn, String password) async {
    const String serverUrl = "https://hello-ivy.id/cek_login.php";
    final Map<String, String> requestData = {
      "nisn": nisn,
      "password": password,
    };
    try {
      final response = await http.post(
        Uri.parse(serverUrl),
        body: requestData,
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception("Failed to fetch updated user data from server");
      }
    } catch (e) {
      throw Exception("Error fetching data: $e");
    }
  }
}
