import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Game/game_page.dart';
import 'list_materi_menu_dashboard.dart';
import 'list_menu_game_dashboard.dart';
import 'materi_category_list_view.dart';
import 'color_Theme.dart';
import 'models/materi_category.dart';
import 'models/refreshdata.dart';
import 'video_screen.dart';

class DesignCourseHomeScreen extends StatefulWidget {
  const DesignCourseHomeScreen({
    Key? key,
    this.animationController,
  }) : super(key: key);
  final AnimationController? animationController;

  @override
  _DesignCourseHomeScreenState createState() => _DesignCourseHomeScreenState();
}

class _DesignCourseHomeScreenState extends State<DesignCourseHomeScreen> {
  CategoryType categoryType = CategoryType.ui;
  bool showTestPopularView = true;

  @override
  void initState() {
    super.initState();
    UserDataManager.refreshUserData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    UserDataManager.refreshUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: DesignCourseAppTheme.nearlyWhite,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).padding.top,
            ),
            getAppBarUI(),
            Expanded(
              child: ListView(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: <Widget>[
                        Flexible(
                          child: getCategoryUI(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getCategoryUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 18, right: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Materi',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22,
              letterSpacing: 0.27,
              color: DesignCourseAppTheme.darkerText,
            ),
          ),
          Flexible(
            child: CategoryListView(
              callBack: (Category category) {
                moveToMateri(category);
              },
            ),
          ),
          const Flexible(
            child: KontenMenuPRandQuiz(),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Game',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22,
              letterSpacing: 0.27,
              color: DesignCourseAppTheme.darkerText,
            ),
          ),
          Flexible(
            child: GameListView(
              callBack: (Category2 category) {
                moveToGamePage(category);
              },
            ),
          ),
        ],
      ),
    );
  }

  void moveToMateri(category) async {
    final List<Map<String, dynamic>> materiList = await fetchUserMaterials();
    Map<String, dynamic> selectedMateri = materiList.firstWhere(
      (materi) => materi['id'] == category.id,
      orElse: () => {},
    );
    if (selectedMateri.isNotEmpty) {
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VideoScreen(
            materi: selectedMateri,
          ),
        ),
      );
    } else {
      // Handle case where selectedMateri is empty
    }
  }

  Future<List<Map<String, dynamic>>> fetchUserMaterials() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userDataString = preferences.getString('userData');
    if (userDataString != null) {
      Map<String, dynamic> userData = jsonDecode(userDataString);
      // Assuming "materi_user" is the key for user's materials
      return userData['values']['materi_user'].cast<Map<String, dynamic>>();
    } else {
      return []; // Return an empty list if no user data is found
    }
  }

  Future<List<Map<String, dynamic>>> fetchGame() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? dataGameString = preferences.getString('userData');
    if (dataGameString != null) {
      Map<String, dynamic> userData = jsonDecode(dataGameString);
      // Assuming "materi_user" is the key for user's materials
      return userData['link_game'].cast<Map<String, dynamic>>();
    } else {
      return []; // Return an empty list if no user data is found
    }
  }

  void moveToGamePage(Category2 category) async {
    final List<Map<String, dynamic>> dataGame = await fetchGame();
    Map<String, dynamic> selectedMateri = dataGame.firstWhere(
      (materi) => materi['id'] == category.id,
      orElse: () => {},
    );
    if (selectedMateri.isNotEmpty) {
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GamePage(
            materi: selectedMateri,
          ),
        ),
      );
    } else {
      // Handle case where selectedMateri is empty
    }
  }

  Widget getGameUI() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 18, right: 16),
          child: Text(
            'Game',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22,
              letterSpacing: 0.27,
              color: DesignCourseAppTheme.darkerText,
            ),
          ),
        ),
        SizedBox(
          height: 16,
        ),
      ],
    );
  }

  Widget getPopularCourseUI() {
    return const Padding(
      padding: EdgeInsets.only(left: 18, right: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[],
      ),
    );
  }

  Widget getAppBarUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 18, right: 18),
      child: FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          }
          Map<String, dynamic> userData =
              jsonDecode(snapshot.data!.getString('userData') ?? '{}');

          String nama = userData['values']['nama'] ?? '';
          String kelas = userData['values']['kelas'] ?? '';

          return Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      kelas,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        letterSpacing: 0.2,
                        color: DesignCourseAppTheme.grey,
                      ),
                    ),
                    Text(
                      nama,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        letterSpacing: 0.27,
                        color: DesignCourseAppTheme.darkerText,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 60,
                height: 60,
                child: Image.asset('assets/design_course/userImage.png'),
              )
            ],
          );
        },
      ),
    );
  }
}

enum CategoryType {
  ui,
  coding,
  basic,
}
