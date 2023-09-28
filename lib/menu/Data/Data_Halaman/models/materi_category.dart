import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Category2 {
  Category2({
    required this.id,
    required this.title1,
    required this.imagePath1,
  });
  String id;
  String title1;
  String imagePath1;
  factory Category2.fromMap(Map<String, dynamic> map) {
    return Category2(
      title1: map['nama_game'] ?? '',
      imagePath1: map['gambar_game'] ?? '',
      id: map['id'] ?? '',
    );
  }
  Future<List<Category2>> getData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? dataGameString = preferences.getString('userData');
    if (dataGameString != null) {
      Map<String, dynamic> dataGame = jsonDecode(dataGameString);
      List<Map<String, dynamic>> materiList =
          dataGame['link_game'].cast<Map<String, dynamic>>();

      List<Category2> categories1 =
          materiList.map((map) => Category2.fromMap(map)).toList();
      return categories1;
    } else {
      return []; // Return an empty list if no user data is found
    }
  }

  toMap() {}
}

class Category {
  Category({
    required this.id,
    required this.title,
    required this.imagePath,
    required this.imagePathCover,
  });
  String id;
  String title;
  String imagePath;
  String imagePathCover;

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] ?? '',
      title: map['judul_materi'] ?? '',
      imagePath: map['gambar_materi'] ?? '',
      imagePathCover: map['gambar_cover'] ?? '',
    );
  }

  Future<List<Category>> getData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userDataString = preferences.getString('userData');
    if (userDataString != null) {
      Map<String, dynamic> userData = jsonDecode(userDataString);
      List<Map<String, dynamic>> materiList =
          userData['values']['materi_user'].cast<Map<String, dynamic>>();

      List<Category> categories =
          materiList.map((map) => Category.fromMap(map)).toList();
      return categories;
    } else {
      return []; // Return an empty list if no user data is found
    }
  }

  static List<Category2> categoryList1 = <Category2>[
    Category2(
      imagePath1: 'assets/design_course/interFace2.png',
      title1: 'Materi Tema',
      id: '',
    ),
  ];

  static List<Category> popularCourseList = <Category>[
    Category(
      id: '',
      imagePath: 'assets/design_course/interFace4.png',
      title: 'Kuis',
      imagePathCover: '',
    ),
  ];

  static List<Category> testcourseList = <Category>[
    Category(
      id: '',
      imagePath: 'assets/design_course/interFace3.png',
      title: 'Tugas Rumah',
      imagePathCover: '',
    ),
  ];
}
